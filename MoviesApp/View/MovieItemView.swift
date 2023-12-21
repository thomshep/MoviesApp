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
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: movie.image)) { image in
                image
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 150, height: 200)
                    .aspectRatio(contentMode: .fit)
            }
            placeholder: {
                Color.white.opacity(0.1)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 150, height: 200)
            }
            
            Spacer()
                .frame(height: 8)
            
            Text(movie.title)
                .lineLimit(1)
                .foregroundStyle(Color.white)
                .font(.headline)
            
            Text(movie.runtimeStr)
                .foregroundStyle(Color.gray)
                .font(.caption)
            
        }
        .frame(width: 150)
    }
}

#Preview {
    MovieItemView(movie: Movie.getPlaceholderMovie())
}
