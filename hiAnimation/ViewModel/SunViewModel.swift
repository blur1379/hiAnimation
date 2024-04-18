//
//  SunViewModel.swift
//  hiAnimation
//
//  Created by Mohammad Blur on 1/18/24.
//

import SwiftUI

class SunViewModel: ObservableObject {
    @Published var percentage: Double = 0
    @Published var sunRotating = false
    let animationTime: TimeInterval = 4
    
    func PathView(geometry: GeometryProxy) -> Path {
        Path { path in
            let initialY = cos(.pi) * geometry.size.height / -5 + geometry.size.height / 2
            path.move(to: CGPoint(x: 0, y: initialY))
            for angle in stride(from: 0, through: 2 * .pi, by: 0.01) {
                let x = angle * geometry.size.width / (2 * .pi)
                let y = cos(angle - .pi) * geometry.size.height / -5 + geometry.size.height / 2
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
    }
}
