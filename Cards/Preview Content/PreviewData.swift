/// Copyright (c) 2023 Kodeco

import SwiftUI

let initialCards: [Card] = [
  Card(backgroundColor: .yellow, elements: initialElements),
  Card(backgroundColor: .green),
  Card(backgroundColor: .orange),
  Card(backgroundColor: .red),
  Card(backgroundColor: .purple)
]
let initialElements: [CardElement] = [
    ImageElement(
        uiImage: UIImage(named: "giraffe3"),
      transform: Transform(
        size: CGSize(width: 250, height: 180),
        offset: CGSize(width: 27, height: -140))),
    ImageElement(
        uiImage: UIImage(named: "giraffe2"),
      transform: Transform(
        size: CGSize(width: 380, height: 270),
        offset: CGSize(width: -80, height: 25))),
    ImageElement(
        uiImage: UIImage(named: "giraffe1"),
      transform: Transform(
        size: CGSize(width: 250, height: 180),
        offset: CGSize(width: 80, height: 205))),
    TextElement(
      transform: Transform(
        size: Settings.defaultElementSize * 1.1,
        offset: CGSize(width: 10, height: -275)),
      text: "Giraffes!!!",
      textColor: .black)
  ]
