//
//  SunView.swift
//  hiAnimation
//
//  Created by Mohammad Blur on 1/18/24.
//

import SwiftUI

struct SunView: View {
    @ObservedObject var sunVM: SunViewModel
    var geometry: GeometryProxy
    
    var body: some View {
        let x = geometry.size.width
        let y = geometry.size.height
        
        Image(systemName: "sun.max.fill")
            .scaleEffect(sunVM.sunRotating ? CGSize(width: 1.0, height: 1.0) : CGSize(width: 1.3, height: 1.3))
            .rotationEffect(sunVM.sunRotating ? Angle(degrees: 0) : Angle(degrees: 360))
            .foregroundColor(Color.yellow)
            .position(CGPoint(x: 0, y: 0))
            .onAppear {
                withAnimation(.easeOut(duration: 5).repeatForever()) { sunVM.sunRotating.toggle() }
            }
            .keyframeAnimator(initialValue: SunPosition(), trigger: sunVM.percentage) { content, value in
                content
                    .offset(
                        CGSize(width: value.width * x / (2 * .pi),
                               height: cos(value.height - .pi) * y / -5 + y / 2
                              )
                    )
            } keyframes: { _ in
                KeyframeTrack(\.height) {
                    LinearKeyframe(2 * .pi * 0.7, duration: sunVM.animationTime)
                }
                KeyframeTrack(\.width){
                    LinearKeyframe(2 * .pi * 0.7, duration: sunVM.animationTime)
                }
            }
    }
}
