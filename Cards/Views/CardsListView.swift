//
//  CardsListView.swift
//  Cards
//
//  Created by Grahame Narborough on 27/5/2024.
//

import SwiftUI

struct CardsListView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var store: CardStore
    @State private var selectedCard: Card?
    var initialView: some View {
      VStack {
        Spacer()
          let card = Card(
            backgroundColor: Color(uiColor: .systemBackground))
        ZStack {
          CardThumbnail(card: card)
          Image(systemName: "plus.circle.fill")
            .font(.largeTitle)
        }
        .frame(
          width: thumbnailSize.width * 1.2,
          height: thumbnailSize.height * 1.2)
        .onTapGesture {
          selectedCard = store.addCard()
        }
        Spacer()
      }
    }
    var createButton: some View {
      Button {
        selectedCard = store.addCard()
      } label: {
        Label("Create New", systemImage: "plus")
              .frame(maxWidth: .infinity)
      }
      .font(.system(size: 16, weight: .bold))
      .padding([.top, .bottom], 10)
      .background(Color("barColor"))
      .accentColor(.white)
    }
    var thumbnailSize: CGSize {
      var scale: CGFloat = 1
      if verticalSizeClass == .regular,
        horizontalSizeClass == .regular {
        scale = 1.5
      }
      return Settings.thumbnailSize * scale
    }
    
    var columns: [GridItem] {
      [
        GridItem(.adaptive(
          minimum: thumbnailSize.width))
      ]
    }
  var body: some View {
      VStack {
          Group {
            if store.cards.isEmpty {
              initialView
            } else {
              list
            }
          }
                    .fullScreenCover(item: $selectedCard) { card in
            if let index = store.index(for: card) {
              SingleCardView(card: $store.cards[index])
                .onChange(of: scenePhase) { newScenePhase in
                  if newScenePhase == .inactive {
                    store.cards[index].save()
                  }
                }
            } else {
              fatalError("Unable to locate selected card")
            }
      }
          createButton
      }
      .background(Color.red)
//      .background(
//        Color("background")
//      .ignoresSafeArea()

  }

  var list: some View {
    ScrollView(showsIndicators: false) {
        LazyVGrid(columns: columns, spacing: 30) {
        ForEach(store.cards) { card in
          CardThumbnail(card: card)
            .frame(
              width: thumbnailSize.width,
              height: thumbnailSize.height)
            .contextMenu {
              Button(role: .destructive) {
                store.remove(card)
              } label: {
                Label("Delete", systemImage: "trash")
              }
            }
            .onTapGesture {
              selectedCard = card
            }
        }
      }
    }
    .padding(.top, 20)
  }
}

struct CardsListView_Previews: PreviewProvider {
  static var previews: some View {
    CardsListView()
      .environmentObject(CardStore(defaultData: true))
  }
}
