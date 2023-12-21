//
//  LottieView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 20/12/23.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    let animation: String

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animation)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        return animationView
    }
}
