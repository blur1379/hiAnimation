//
//  Config.swift
//  hiAnimation
//
//  Created by Mohammad Blur on 1/18/24.
//

import Foundation

struct Config: Identifiable, Codable {
    var id: UUID = UUID()
    var isTrue: Bool
    var name: String
}
