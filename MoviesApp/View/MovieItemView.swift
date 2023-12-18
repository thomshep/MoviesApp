//
//  MovieItemView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import SwiftUI

struct MovieItemView: View {
    @State var movie : Movie
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.image)) { image in
                image.resizable()
            }
            placeholder: {
                Color.red
            }
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            Text(movie.title)
            Text("-")
            Text(movie.directors)
        }
    }
}

#Preview {
    MovieItemView(movie: Movie.getPlaceholderMovie())
}
