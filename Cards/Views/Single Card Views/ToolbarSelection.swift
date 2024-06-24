//
//  ToolbarSelection.swift
//  Cards
//
//  Created by Grahame Narborough on 27/5/2024.
//

import Foundation

enum ToolbarSelection: CaseIterable, Identifiable {
    var id: Int {
      hashValue
    }
    case photoModal, frameModal, stickerModal, textModal
}
