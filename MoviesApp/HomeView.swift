//
//  HomeView.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    
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
                //TODO: api key move to variable
                if let url = URL(string: "https://my.api.mockaroo.com/movies.json?key=cb03b960") {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    print(data)
                    let response = try JSONDecoder().decode(MovieListResponseMessage.self, from: data)
                    DispatchQueue.main.async {
                        movieList = response.items
                    }
                    if response.errorMessage != "" {
                        //TODO: show application message
                        DispatchQueue.main.async {
                            movieList = Movie.getMovies()
                        }
                    }
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
    HomeView()
}
