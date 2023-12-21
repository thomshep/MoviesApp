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
    @State var showSplashScreen : Bool = true
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                ZStack {
                    if showSplashScreen {
                        SplashScreenView()
                    } else {
                        HomeView(moviesViewModel: moviesViewModel)
                            .task {
                                // Ask for permissions
                                let permissionsHandler = Permissions()
                                let _ = await permissionsHandler.isAuthorizedToUseCamera
                                
                                permissionsHandler.requestLocationAuthorization()
                            }
                            .navigationDestination(for: Router.Destination.self) { destination in
                                switch destination {
                                case .movieList:
                                    HomeView(moviesViewModel: moviesViewModel)
                                case .movieDetail(let movie):
                                    MovieDetailView(moviesViewModel: moviesViewModel, movie: movie)
                                }
                            }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showSplashScreen = false
                    }
                }
            }
            .environmentObject(router)
            
        }
    }
}
