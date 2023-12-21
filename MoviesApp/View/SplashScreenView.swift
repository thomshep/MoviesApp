//
//  SplashScreenView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 20/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            VStack {
                LottieView(loopMode: .playOnce, animation: "SplashAnimation")
                    .scaleEffect(0.2)
            }
            
                
        }
        .background(Color( MovieColor.backgroundColor ))
        
    }
}

#Preview {
    SplashScreenView()
}
