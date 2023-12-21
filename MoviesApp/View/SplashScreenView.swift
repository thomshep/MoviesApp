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
        .background(Color( #colorLiteral(red: 0.11, green: 0.12, blue: 0.20, alpha: 1.00) ))
        //.background(Color(UIColor(_colorLiteralRed: 3, green: 2, blue: 3, alpha: 1)))
        
    }
}

#Preview {
    SplashScreenView()
}
