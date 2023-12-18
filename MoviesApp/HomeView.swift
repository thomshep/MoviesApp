//
//  HomeView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    let moviesViewModel : MoviesViewModel
    
    @State var movieList : [Movie] = []
    
    var body: some View {
        ZStack {
            VStack {
                List(movieList, id: \.id) { movie in
                    MovieItemView(movie: movie)
                        .onTapGesture {
                            router.navigate(to: .movieDetail(movie: movie))
                        }
                }
            }
        }
        .task {
            do {
                try await moviesViewModel.getMovies()
                DispatchQueue.main.async {
                    movieList = moviesViewModel.movies
                }
                
            } catch {
                //TODO: show application message
                print("error")
                print(error)
                DispatchQueue.main.async {
                    movieList = Movie.getMovies()
                }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Películas")
            }
        }
    }
}

#Preview {
    HomeView(moviesViewModel: MoviesViewModel())
}
