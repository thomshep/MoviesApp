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
    @Published var moviesFiltered : [Movie] = []
    @Published var mostPopularMovies : [Movie] = []
    @Published var categories : [String] = []
    @Published var error : CustomError?
    private var API_KEY : String
    
    init() {
        API_KEY = ""
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            API_KEY = apiKey
        }
    }
    
    @MainActor
    func getMovies() async -> Void {
        if let url = URL(string: "https://my.api.mockaroo.com/movies.json?key=\(API_KEY)") {
            
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
                    
                    self.moviesFiltered = self.movies
                    mostPopularMovies(moviesList: self.movies)
                                        
                    self.saveMoviesCache(movies: self.movies)
                    
                }
            } catch {
                self.movies = getCachedMovies()
                self.moviesFiltered = self.movies
                mostPopularMovies(moviesList: self.movies)
                getCategories()
                self.error = .errorFetchingData
            }

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
    }
    
    func filterMovies(filter: String, genre: String) {
        if filter.isEmpty && genre.isEmpty {
            self.moviesFiltered = self.movies
        } else {
            self.moviesFiltered = self.movies.filter { movie in
                return (filter.isEmpty || movie.title.lowercased().contains(filter.lowercased())) &&
                       (genre.isEmpty || movie.genreList.first(where: { genreItem in
                                                return genreItem.key == genre
                                            }) != nil)
            }
        }
        
    }
    
    func mostPopularMovies(moviesList : [Movie]) {
        self.mostPopularMovies = moviesList.sorted { movie1, movie2 in
            return Float(movie1.imDbRating) ?? 0 > Float(movie2.imDbRating) ?? 0
        }
    }
    
    //MARK: - Realm
    @MainActor
    func getCachedMovies() -> [Movie] {
        do {
            let realm = try Realm()
            let objects = realm.objects(MovieRealm.self)
            let realmMovies = Array(objects)
            return realmMovies.map { realmMovie in
                //Convert every MovieRealm to Movie type
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
                    realm.add(MovieRealm.getPersistedObject(movie: movie))
                }
            }
            
        } catch {
            print(error)
        }
    }
}
