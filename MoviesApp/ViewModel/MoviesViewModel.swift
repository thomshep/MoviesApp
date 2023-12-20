//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import Foundation
import RealmSwift

class MoviesViewModel : ObservableObject {
    @Published var movies : [Movie] = []
    
    @MainActor
    func getMovies() async throws -> Void {
        //TODO: api key move to variable
        if let url = URL(string: "https://my.api.mockaroo.com/movies.json?key=cb03b960") {
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(MovieListResponseMessage.self, from: data)
                if response.errorMessage != "" {
                    print(response.errorMessage)
                    throw NSError(domain: "", code: 0)
                } else {
                    
                    
                    self.movies = response.items
                    
                    // Order by release date
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd MMM yyyy"
                    
                    self.movies.sort { movie1, movie2 in
                        if let dateMovie1 = formatter.date(from: movie1.releaseState), let dateMovie2 = formatter.date(from: movie2.releaseState) {
                            return dateMovie1 > dateMovie2
                        }
                        
                        return false
                    }
                    
                    self.saveMoviesCache(movies: self.movies)
                    
                }
            } catch {
                self.movies = getCachedMovies()
                throw NSError(domain: "", code: 0)
            }

        }
    }
    
    @MainActor
    func getCachedMovies() -> [Movie] {
        do {
            let realm = try Realm()
            let objects = realm.objects(RealmMovie.self)
            let realmMovies = Array(objects)
            return realmMovies.map { realmMovie in
                return realmMovie.getMovie()
            }
        } catch {
            return []
        }
    }
    
    @MainActor
    func saveMoviesCache(movies: [Movie]) {
        do {
            let realm = try Realm()
            try realm.write {
                for movie in movies {
                    realm.add(movie.getPersistedObject())
                }
            }
        } catch {
            
        }
    }
    
}
