//
//  PhotosModal.swift
//  Cards
//
//  Created by Grahame Narborough on 31/5/2024.
//

import SwiftUI
import PhotosUI

struct PhotosModal: View {
  @Binding var card: Card
  // 1
  @State private var selectedItems: [PhotosPickerItem] = []

  var body: some View {
    // 2
    PhotosPicker(
      // 3
      selection: $selectedItems,
      // 4
      matching: .images) {
      // 5
        ToolbarButton(modal: .photoModal)
    }
      .onChange(of: selectedItems) { items in
        for item in items {
            item.loadTransferable(type: Data.self) { result in
              Task {
                  switch result {
                      case .success(let data):
                        if let data,
                          let uiImage = UIImage(data: data) {
                          card.addElement(uiImage: uiImage)
                        }
                      case .failure(let failure):
                        fatalError("Image transfer failed: \(failure)")
                  }
              }
            }
        }
        selectedItems = []
      }
  }
}


#Preview {
    PhotosModal(card: .constant(Card()))
}
