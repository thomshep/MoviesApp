//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import Foundation

class MoviesViewModel : ObservableObject {
    @Published var movies : [Movie] = []
    
    func getMovies() async throws -> Void {
        //TODO: api key move to variable
        if let url = URL(string: "https://my.api.mockaroo.com/movies.json?key=cb03b960") {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let response = try JSONDecoder().decode(MovieListResponseMessage.self, from: data)
                if response.errorMessage != "" {
                    print(response.errorMessage)
                    throw NSError(domain: "", code: 0)
                } else {
                    self.movies = response.items
                }
            } catch {
                self.movies = getCachedMovies()
                throw NSError(domain: "", code: 0)
            }

        }
    }
    
    func getCachedMovies() -> [Movie] {
        return []
    }
    
}
