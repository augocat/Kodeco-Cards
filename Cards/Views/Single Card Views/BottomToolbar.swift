/// Copyright (c) 2023 Kodeco

import SwiftUI

struct ToolbarButton: View {
  @Environment(\.verticalSizeClass) var verticalSizeClass
  let modal: ToolbarSelection
  private let modalButton: [
    ToolbarSelection: (text: String, imageName: String)
  ] = [
    .photoModal: ("Photos", "photo"),
    .frameModal: ("Frames", "square.on.circle"),
    .stickerModal: ("Stickers", "heart.circle"),
    .textModal: ("Text", "textformat")
  ]

  var body: some View {
    if let text = modalButton[modal]?.text,
      let imageName = modalButton[modal]?.imageName {
      if verticalSizeClass == .compact {
        compactView(imageName)
      } else {
        regularView(imageName, text)
      }
    }
  }

  func regularView(
    _ imageName: String,
    _ text: String
  ) -> some View {
    VStack(spacing: 2) {
      Image(systemName: imageName)
      Text(text)
    }
    .frame(minWidth: 60)
    .padding(.top, 5)
  }

  func compactView(_ imageName: String) -> some View {
    VStack(spacing: 2) {
      Image(systemName: imageName)
    }
    .frame(minWidth: 60)
    .padding(.top, 5)
  }
}

struct BottomToolbar: View {
  @EnvironmentObject var store: CardStore
  @Binding var card: Card
  @Binding var modal: ToolbarSelection?

  var body: some View {
    HStack(alignment: .bottom) {
      ForEach(ToolbarSelection.allCases) { selection in
        switch selection {
        case .photoModal:
          Button {
          } label: {
            PhotosModal(card: $card)
          }
        case .frameModal:
          defaultButton(selection)
            .disabled(
              store.selectedElement == nil
              || !(store.selectedElement is ImageElement))
        default:
          defaultButton(selection)
        }
      }
    }
  }

  func defaultButton(_ selection: ToolbarSelection) -> some View {
    Button {
      modal = selection
    } label: {
      ToolbarButton(modal: selection)
    }
  }
}

struct BottomToolbar_Previews: PreviewProvider {
  static var previews: some View {
    BottomToolbar(
      card: .constant(Card()),
      modal: .constant(.stickerModal))
    .padding()
    .environmentObject(CardStore())
  }
}
