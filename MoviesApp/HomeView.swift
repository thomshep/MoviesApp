//
//  HomeView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    @State var showAlert : Bool = false
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
            await moviesViewModel.getMovies()
            DispatchQueue.main.async {
                movieList = moviesViewModel.movies
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Películas")
            }
        }
        .onChange(of: moviesViewModel.error) {
            showAlert = moviesViewModel.error != nil
        }
        .alert(moviesViewModel.error?.description ?? "", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    HomeView(moviesViewModel: MoviesViewModel())
}
