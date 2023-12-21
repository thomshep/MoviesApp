//
//  MovieScrollableList.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 21/12/23.
//

import SwiftUI

struct MovieScrollableList: View {
    @EnvironmentObject var router: Router
    let title : String
    @Binding var isLoading : Bool
    @Binding var movieList : [Movie]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(title)
                    .foregroundStyle(Color.white)
                    .font(.title3)
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                    if isLoading {
                        MovieItemView(movie: Movie.getPlaceholderMovie())
                            .redacted(reason: .placeholder)
                        
                        MovieItemView(movie: Movie.getPlaceholderMovie())
                            .redacted(reason: .placeholder)
                        
                        MovieItemView(movie: Movie.getPlaceholderMovie())
                            .redacted(reason: .placeholder)
                    } else {
                        ForEach(movieList, id: \.id) { movie in
                            MovieItemView(movie: movie)
                                .onTapGesture {
                                    router.navigate(to: .movieDetail(movie: movie))
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MovieScrollableList(title: "All", isLoading: .constant(false), movieList: .constant([Movie.getPlaceholderMovie()]))
}
