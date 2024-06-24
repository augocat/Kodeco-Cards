//  Created by Grahame Narborough on 28/5/2024.

import SwiftUI

struct CardToolbar: ViewModifier {
    @EnvironmentObject var store: CardStore
    @Environment(\.dismiss) var dismiss //*
    @Binding var currentModal: ToolbarSelection?
    @Binding var card: Card
    @State private var stickerImage: UIImage?
    @State private var frameIndex: Int?
    @State private var textElement = TextElement()
    
    func body(content: Content) -> some View {
        content //*
            .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                  menu
            }
            ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
            dismiss()
            }
            }
            ToolbarItem(placement: .bottomBar) {
                BottomToolbar(
                  card: $card,
                  modal: $currentModal)
            }
            }
            .sheet(item: $currentModal) { item in //*
            switch item {
            case .frameModal:
                  FrameModal(frameIndex: $frameIndex)
                    .onDisappear {
                      if let frameIndex {
                        card.update(
                          store.selectedElement,
                          frameIndex: frameIndex)
                      }
                      frameIndex = nil
                    }
            case .stickerModal:
                StickerModal(stickerImage: $stickerImage)
                  .onDisappear {
                    if let stickerImage = stickerImage {
                      card.addElement(uiImage: stickerImage)
                    }
                    stickerImage = nil
                  }
            case .textModal:
                TextModal(textElement: $textElement)
                  .onDisappear {
                      if !textElement.text.isEmpty {
                        card.addElement(text: textElement)
                      }
                      textElement = TextElement()
                  }

            default: //*
            Text(String(describing: item)) //*
            } //*
            } //*
            }

    var menu: some View {
      Menu {
        Button {
            if UIPasteboard.general.hasImages {
              if let images = UIPasteboard.general.images {
                for image in images {
                  card.addElement(uiImage: image)
                }
              }
            } else if UIPasteboard.general.hasStrings {
              if let strings = UIPasteboard.general.strings {
                for text in strings {
                  card.addElement(text: TextElement(text: text))
                }
              }
            }
        } label: {
          Label("Paste", systemImage: "doc.on.clipboard")
        }
        .disabled(!UIPasteboard.general.hasImages
          && !UIPasteboard.general.hasStrings)
      } label: {
        Label("Add", systemImage: "ellipsis.circle")
      }
    }
            }
