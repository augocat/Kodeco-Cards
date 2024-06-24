//
//  Transform.swift
//  Cards
//
//  Created by Grahame Narborough on 28/5/2024.
//

import SwiftUI

struct Transform {
    var size = CGSize(
      width: Settings.defaultElementSize.width,
      height: Settings.defaultElementSize.height)
  var rotation: Angle = .zero
  var offset: CGSize = .zero
}
extension Transform: Codable {}
