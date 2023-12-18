//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import SwiftUI

struct MovieDetailView: View {
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
    MovieDetailView(movie: Movie.getPlaceholderMovie())
}
