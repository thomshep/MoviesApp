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
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let response = try JSONDecoder().decode(MovieListResponseMessage.self, from: data)
                if response.errorMessage != "" {
                    print(response.errorMessage)
                    throw NSError(domain: "", code: 0)
                } else {
                    self.movies = response.items
                    self.saveMoviesCache(movies: response.items)
                    
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
