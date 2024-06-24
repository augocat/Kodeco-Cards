//
//  CardThumbnail.swift
//  Cards
//
//  Created by Grahame Narborough on 27/5/2024.
//

import SwiftUI

struct CardThumbnail: View {
    let card: Card
    var body: some View {
        card.backgroundColor
          .cornerRadius(10)
        .shadow(
          color: Color("shadow-color"),
          radius: 3,
          x: 0.0,
          y: 0.0)
    }
}

#Preview {
    CardThumbnail(card: initialCards[0])
        .frame(
          width: Settings.thumbnailSize.width,
          height: Settings.thumbnailSize.height)

}
