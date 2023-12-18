//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    @ObservedObject var router = Router()
    let moviesViewModel = MoviesViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeView(moviesViewModel: moviesViewModel)
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .movieList:
                            HomeView(moviesViewModel: moviesViewModel)
                        case .movieDetail(let movie):
                            MovieDetailView(moviesViewModel: moviesViewModel, movie: movie)
                        }
                    }
            }
            .environmentObject(router)
            
        }
    }
}
