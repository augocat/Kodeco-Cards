//
//  StickerModal.swift
//  Cards
//
//  Created by Grahame Narborough on 31/5/2024.
//

import SwiftUI

struct StickerModal: View {
    @Binding var stickerImage: UIImage?
    @Environment(\.dismiss) var dismiss
    @State private var stickerNames: [String] = []
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 10)
    ]
    
    func image(from path: String) -> UIImage {
      print("loading:", path)
      return UIImage(named: path)
        ?? UIImage(named: "error-image")
        ?? UIImage()
    }
    static func loadStickers() -> [String] {
      var themes: [URL] = []
      var stickerNames: [String] = []
        let fileManager = FileManager.default
        if let resourcePath = Bundle.main.resourcePath,
          // 2
          let enumerator = fileManager.enumerator(
            at: URL(fileURLWithPath: resourcePath + "/Stickers"),
            includingPropertiesForKeys: nil,
            options: [
              .skipsSubdirectoryDescendants,
              .skipsHiddenFiles
            ]) {
              // 3
              for case let url as URL in enumerator
              where url.hasDirectoryPath {
                themes.append(url)
              }
        }
        for theme in themes {
          if let files = try?
          fileManager.contentsOfDirectory(atPath: theme.path) {
            for file in files {
              stickerNames.append(theme.path + "/" + file)
            }
          }
        }
        return stickerNames
    }
    var body: some View {
      ScrollView {
          LazyVGrid(columns: columns) {
              ForEach(stickerNames, id: \.self) { sticker in
              Image(uiImage: image(from: sticker))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    stickerImage = image(from: sticker)
                    dismiss()
                }

              }
          }
      }
      .onAppear {
        stickerNames = Self.loadStickers()
      }
    }
}
//out
#Preview {
    StickerModal(stickerImage: .constant(UIImage()))
}
