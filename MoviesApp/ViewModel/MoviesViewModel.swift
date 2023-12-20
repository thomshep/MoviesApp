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
    @Published var categories : [String] = []
    @Published var error : CustomError?
    
    @MainActor
    func getMovies() async -> Void {
        //TODO: api key move to variable
        if let url = URL(string: "https://my.api.mockaroo.com/movies.json?key=cb03b960") {
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(MovieListResponseMessage.self, from: data)
                if response.errorMessage != "" {
                    print(response.errorMessage)
                    self.error = .errorFetchingData
                } else {
                    
                    
                    self.movies = response.items
                    
                    getCategories()
                    
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
                getCategories()
                self.error = .errorFetchingData
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
            
            // Delete all previous data
            try realm.write {
                realm.deleteAll()
            }
            
            try realm.write {
                for movie in movies {
                    realm.add(movie.getPersistedObject())
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    // Get categories API is needed to make this more efficient
    func getCategories() {
        self.movies.forEach { movie in
            movie.genreList.forEach { genre in
                if !categories.contains(genre.value) {
                    categories.append(genre.value)
                }
            }
        }
        print(categories)
    }
}
