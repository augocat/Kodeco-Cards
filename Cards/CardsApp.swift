/// Copyright (c) 2023 Kodeco

import SwiftUI

@main
struct CardsApp: App {
  @StateObject var store = CardStore(defaultData: false)

  var body: some Scene {
    WindowGroup {
      CardsListView()
        .environmentObject(store)
        .onAppear {
          print(URL.documentsDirectory)
        }
    }
  }
}
