//
//  hiAnimationApp.swift
//  hiAnimation
//
//  Created by Mohammad Blur on 1/18/24.
//

import SwiftUI

@main
struct hiAnimationApp: App {
    var body: some Scene {
        WindowGroup {
            SunWithPathView()
                
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
                .frame(height: 200)
            ConfigView()
                
        }
    }
}
