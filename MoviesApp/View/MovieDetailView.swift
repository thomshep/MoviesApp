//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var router: Router
    let moviesViewModel : MoviesViewModel
    @State var movie : Movie
    
    var body: some View {
        ZStack {
            VStack {
                Text(movie.plot)

            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(movie.title)
            }
        }
    }
}

#Preview {
    MovieDetailView(moviesViewModel: MoviesViewModel(), movie: Movie.getPlaceholderMovie())
}
