//
//  ContentView.swift
//  hiAnimation
//
//  Created by Mohammad Blur on 1/18/24.
//

import SwiftUI


struct SunWithPathView: View {
    
    @StateObject var sunVM = SonViewModel()
    
   
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                ZStack {
                    sunVM.PathView(geometry: geometry)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 1 , dash: [5]))
                    
                    sunVM.PathView(geometry: geometry)
                        .trim(from: 0 , to : sunVM.percentage)
                        .stroke(Color.purple, lineWidth: 3)

                    SunView(sunVM: sunVM, geometry: geometry)
                    
                }
            }
        }
        .onAppear { withAnimation(.linear(duration: sunVM.animationTime)) { sunVM.percentage = 0.7 } }
        .padding()
        
    }
}

#Preview(body: {
    SunWithPathView()
})


struct SunView: View {
    @ObservedObject var sunVM: SonViewModel
    var geometry : GeometryProxy
    var body: some View {
        let x = geometry.size.width
        let y = geometry.size.height
        Image(systemName: "sun.max.fill")
            .scaleEffect( sunVM.sunRotating ? CGSize(width: 1.0, height: 1.0) : CGSize(width: 1.3, height: 1.3))
            .rotationEffect(sunVM.sunRotating ? Angle(degrees: 0) : Angle(degrees: 360))
            .foregroundColor(Color.yellow)
            .position(CGPoint(x: 0, y: 0))
            .onAppear{
                withAnimation(.easeOut(duration: 5).repeatForever()){ sunVM.sunRotating.toggle() }
            }
            .keyframeAnimator(initialValue: SunPosition() ,trigger: sunVM.percentage) { content, value in
                content
                    .offset(
                        CGSize(width: value.width * x / (2 * .pi) ,
                               height: cos(value.height - .pi) * y / -15 + y / 2
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


class SonViewModel: ObservableObject {
    @Published var percentage : Double = 0
    @Published var sunRotating = false
    var animationTime: TimeInterval = 4
    
    func PathView( geometry : GeometryProxy) -> Path{
        Path{ path in
            let initialY = cos(.pi) * geometry.size.height / -15 + geometry.size.height / 2
            path.move(to: CGPoint(x: 0, y: initialY))
            for angle in stride(from: 0, through: 2 * .pi, by: 0.01) {
                let x = angle * geometry.size.width / (2 * .pi)
                let y = cos(angle - .pi) * geometry.size.height / -15 + geometry.size.height / 2
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
    }

}

