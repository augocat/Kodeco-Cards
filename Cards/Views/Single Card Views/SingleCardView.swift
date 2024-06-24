//
//  SingleCardView.swift
//  Cards
//
//  Created by Grahame Narborough on 27/5/2024.
//

import SwiftUI

struct SingleCardView: View {
@State private var currentModal: ToolbarSelection?
@Binding var card: Card

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                CardDetailView(
                  card: $card,
                  viewScale: Settings.calculateScale(proxy.size))
                    .onDisappear {
                        card.save()
                    }
                .frame(
                  width: Settings.calculateSize(proxy.size).width,
                  height: Settings.calculateSize(proxy.size).height)
                .clipped()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .modifier(CardToolbar(
                        currentModal: $currentModal,
                        card: $card))
            } //*
        } //*
    }
var content: some View { //*
card.backgroundColor
}
    
}
//out
struct SingleCardView_Previews: PreviewProvider {
  struct CardDetailPreview: View {
    @EnvironmentObject var store: CardStore

    var body: some View {
        SingleCardView(card: $store.cards[0])
    }
  }

  static var previews: some View {
    CardDetailPreview()
      .environmentObject(CardStore(defaultData: true))
  }
}
