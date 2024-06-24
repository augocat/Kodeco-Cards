//
//  AppLoadingView.swift
//  Cards
//
//  Created by Grahame Narborough on 3/6/2024.
//

import SwiftUI

struct AppLoadingView: View {
    @State private var showSplash = true
    var body: some View {
      if showSplash {
        SplashScreen()
          .ignoresSafeArea()
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                showSplash = false
              }
            }
          }
      } else {
        CardsListView()
              .transition(.scale(scale: 0, anchor: .top))
      }
    }
}

#Preview {
    AppLoadingView()
    .environmentObject(CardStore(defaultData: true))
}
