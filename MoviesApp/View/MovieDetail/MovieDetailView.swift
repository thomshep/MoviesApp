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
            ScrollView {
                VStack(spacing: 22) {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            AsyncImage(url: URL(string: movie.image)) { image in
                                image
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .frame(width: 200, height: 360)
                                    .aspectRatio(contentMode: .fit)
                            }
                            placeholder: {
                                Color.white.opacity(0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .frame(width: 200, height: 360)
                            }
                                
                            
                            
                            Spacer()
                            
                            VStack {
                                MovieDetailInfoView(icon: "video", title: "Genre", info: movie.genreList.first?.value ?? "-")
                                
                                Spacer()
                                
                                MovieDetailInfoView(icon: "alarm", title: "Duration", info: movie.runtimeStr)
                                
                                Spacer()
                                
                                MovieDetailInfoView(icon: "star.leadinghalf.filled", title: "Rating", info: movie.imDbRating)
                                
                                
                            }
                        }
                        
                        Spacer()
                            .frame(height: 8)
                        
                        Text(movie.title)
                            .lineLimit(1)
                            .foregroundStyle(Color.white)
                            .font(.title2)
                        
                        Text(movie.year)
                            .foregroundStyle(Color.gray)
                            .font(.caption)
                    }
                    
                    
                    
                    Divider()
                        .frame(height: 2)
                        .overlay(Color.white)
                        
                    
                    HStack {
                        Text("Plot")
                            .foregroundStyle(Color.white)
                            .font(.title3.weight(.semibold))
                        Spacer()
                    }
                    
                    
                    Text(movie.plot)
                        .foregroundStyle(Color.gray)
                        .font(.subheadline)
                    
                    Spacer()
                    
                }.padding()
                
            }.padding()
        }
        .background(Color( #colorLiteral(red: 0.11, green: 0.12, blue: 0.20, alpha: 1.00) ))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Movie details")
                    .foregroundStyle(Color.white)
                    .font(.title2)
            }
        }
    }
}

#Preview {
    MovieDetailView(moviesViewModel: MoviesViewModel(), movie: Movie.getPlaceholderMovie())
}
