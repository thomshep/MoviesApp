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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .movieList:
                            HomeView()
                        case .movieDetail(let movie):
                            MovieDetailView(movie: movie)
                        }
                    }
            }
            .environmentObject(router)
            
        }
    }
}
