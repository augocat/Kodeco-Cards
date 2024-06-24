/// Copyright (c) 2023 Kodeco

import SwiftUI

struct CardDetailView: View {
  @EnvironmentObject var store: CardStore
  @Binding var card: Card
  var viewScale: CGFloat = 1
  var proxy: GeometryProxy?

  func isSelected(_ element: CardElement) -> Bool {
    store.selectedElement?.id == element.id
  }

  var body: some View {
    ZStack {
      card.backgroundColor
        .onTapGesture {
          store.selectedElement = nil
        }
      ForEach($card.elements, id: \.id) { $element in
        CardElementView(element: element)
          .overlay(
            element: element,
            isSelected: isSelected(element))
          .elementContextMenu(
            card: $card,
            element: $element)
          .resizableView(
            transform: $element.transform,
            viewScale: viewScale)
          .frame(
            width: element.transform.size.width,
            height: element.transform.size.height)
          .onTapGesture {
            store.selectedElement = element
          }
      }
    }
    .onDisappear {
      store.selectedElement = nil
    }
    .dropDestination(for: CustomTransfer.self) { items, location in
      let offset = Settings.calculateDropOffset(
        proxy: proxy,
        location: location)
      Task {
        card.addElements(from: items, at: offset)
      }
      return !items.isEmpty
    }
  }
}

struct CardDetailView_Previews: PreviewProvider {
  struct CardDetailPreview: View {
    @EnvironmentObject var store: CardStore
    var body: some View {
      CardDetailView(card: $store.cards[0])
    }
  }

  static var previews: some View {
    CardDetailPreview()
      .environmentObject(CardStore(defaultData: true))
  }
}

private extension View {
  @ViewBuilder
  func overlay(
    element: CardElement,
    isSelected: Bool
  ) -> some View {
    if isSelected,
      let element = element as? ImageElement,
      let frameIndex = element.frameIndex {
      let shape = Shapes.shapes[frameIndex]
      self.overlay(shape
        .stroke(lineWidth: Settings.borderWidth)
        .foregroundColor(Settings.borderColor))
    } else {
      self
        .border(
          Settings.borderColor,
          width: isSelected ? Settings.borderWidth : 0)
    }
  }
}
