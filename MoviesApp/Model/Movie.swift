//
//  Movie.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 17/12/23.
//

import Foundation
import RealmSwift
import Realm

struct MovieListResponseMessage : Decodable {
    let items : [Movie]
    let errorMessage : String
}

struct Movie : Codable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id : String
    let title : String
    let fullTitle : String
    let year : String
    let releaseState : String
    let image : String
    let runtimeMins : String
    let runtimeStr : String
    let plot : String
    let contentRating : String
    let imDbRating : String
    let imDbRatingCount : String
    let metacriticRating : String
    let genres : String
    let genreList : [KeyValue]
    let directors : String
    let directorList : [IdName]
    let stars : String
    let starList : [IdName]
    
    static func getMovies() -> [Self] {
        return [Movie.getPlaceholderMovie()]
    }
    
    static func getPlaceholderMovie() -> Self {
        return Movie(id: "tt1649418", title: "The Gray Man", fullTitle: "The Gray Man", year: "2022", releaseState: "22 Jul 2022", image: "", runtimeMins: "122", runtimeStr: "122 mins", plot: "When the CIA's most skilled operative-whose true identity is known to none-accidentally uncovers dark agency secrets, a psychopathic former colleague puts a bounty on his head, setting off a global manhunt by international assassins", contentRating: "PG-13", imDbRating: "6.6", imDbRatingCount: "65523", metacriticRating: "49", genres: "Action, Thriller", genreList: [KeyValue(key: "Action", value: "Action"), KeyValue(key: "Thriller", value: "Thriller")], directors: "Anthony Russo, Joe Russo", directorList: [IdName(id: "nm0751577", name: "Anthony Russo"), IdName(id: "nm0751648", name: "Joe Russo")], stars: "Ryan Gosling, Chris Evans, Ana de Armas, Billy Bob Thornton", starList: [IdName(id: "nm0331516", name: "Ryan Gosling"), IdName(id: "nm0262635", name: "Chris Evans")])
    }
    
}

struct KeyValue : Codable, Hashable {
    let key : String
    let value : String
}

struct IdName : Codable, Hashable {
    let id : String
    let name : String
}
