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
    
    func getPersistedObject() -> RealmMovie {
        var realmMovie = RealmMovie()
        realmMovie.id = self.id
        realmMovie.title = self.title
        realmMovie.fullTitle = self.fullTitle
        realmMovie.year = self.year
        realmMovie.releaseState = self.releaseState
        realmMovie.image = self.image
        realmMovie.runtimeMins = self.runtimeMins
        realmMovie.runtimeStr = self.runtimeStr
        realmMovie.plot = self.plot
        realmMovie.contentRating = self.contentRating
        realmMovie.imDbRating = self.imDbRating
        realmMovie.imDbRatingCount = self.imDbRatingCount
        realmMovie.metacriticRating = self.metacriticRating
        realmMovie.genres = self.genres
        realmMovie.genreList = List()
        self.genreList.forEach({ item in
            var keyValue = RealmKeyValue()
            keyValue.key = item.key
            keyValue.value = item.value
            realmMovie.genreList.append(keyValue)
        })
        realmMovie.directorList = List()
        self.directorList.forEach({ item in
            var idName = RealmIdName()
            idName.id = item.id
            idName.name = item.name
            realmMovie.directorList.append(idName)
        })
        realmMovie.directors = self.directors
        realmMovie.stars = self.stars
        realmMovie.starList = List()
        self.starList.forEach({ item in
            var idName = RealmIdName()
            idName.id = item.id
            idName.name = item.name
            realmMovie.starList.append(idName)
        })
        return realmMovie
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


//MARK: - Realm Objects

class RealmMovie : Object {
    @Persisted var id : String
    @Persisted var title : String
    @Persisted var fullTitle : String
    @Persisted var year : String
    @Persisted var releaseState : String
    @Persisted var image : String
    @Persisted var runtimeMins : String
    @Persisted var runtimeStr : String
    @Persisted var plot : String
    @Persisted var contentRating : String
    @Persisted var imDbRating : String
    @Persisted var imDbRatingCount : String
    @Persisted var metacriticRating : String
    @Persisted var genres : String
    @Persisted var genreList : List<RealmKeyValue>
    @Persisted var directors : String
    @Persisted var directorList : List<RealmIdName>
    @Persisted var stars : String
    @Persisted var starList : List<RealmIdName>
    
    func getMovie() -> Movie {
        let genreList = Array(self.genreList.map({ realmKeyVale in
            return KeyValue(key: realmKeyVale.key, value: realmKeyVale.value)
        }))
        let directorList = Array(self.directorList.map({ realmIdName in
            return IdName(id: realmIdName.id, name: realmIdName.name)
        }))
        let starList = Array(self.starList.map({ realmIdName in
            return IdName(id: realmIdName.id, name: realmIdName.name)
        }))
        return Movie(id: self.id, title: self.title, fullTitle: self.fullTitle, year: self.year, releaseState: self.releaseState, image: self.image, runtimeMins: self.runtimeMins, runtimeStr: self.runtimeStr, plot: self.plot, contentRating: self.contentRating, imDbRating: self.imDbRating, imDbRatingCount: self.imDbRatingCount, metacriticRating: self.metacriticRating, genres: self.genres, genreList: genreList, directors: self.directors, directorList: directorList, stars: self.stars, starList: starList)
    }
}

class RealmKeyValue : Object {
    @Persisted var key : String
    @Persisted var value : String
}

class RealmIdName : Object {
    @Persisted var id : String
    @Persisted var name : String
}
