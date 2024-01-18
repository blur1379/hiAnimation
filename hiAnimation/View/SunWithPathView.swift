//
//  ContentView.swift
//  hiAnimation
//
//  Created by Mohammad Blur on 1/18/24.
//

import SwiftUI


struct SunWithPathView: View {
    @StateObject var sunVM = SunViewModel()
    
    var body: some View {
        VStack{
            GeometryReader{ geometry in
                ZStack {
                    sunVM.PathView(geometry: geometry)
                        .stroke(Color.gray, style: StrokeStyle(lineWidth: 1 , dash: [2]))
                    
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
        .frame(height: 300)
})
