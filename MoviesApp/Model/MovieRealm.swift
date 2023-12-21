//
//  MovieRealm.swift
//  MoviesApp
//
//  Created by Thomas Sheppard on 21/12/23.
//

import Foundation
import RealmSwift
import Realm

class MovieRealm : Object {
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
    
    static func getPersistedObject(movie: Movie) -> MovieRealm {
        let realmMovie = MovieRealm()
        realmMovie.id = movie.id
        realmMovie.title = movie.title
        realmMovie.fullTitle = movie.fullTitle
        realmMovie.year = movie.year
        realmMovie.releaseState = movie.releaseState
        realmMovie.image = movie.image
        realmMovie.runtimeMins = movie.runtimeMins
        realmMovie.runtimeStr = movie.runtimeStr
        realmMovie.plot = movie.plot
        realmMovie.contentRating = movie.contentRating
        realmMovie.imDbRating = movie.imDbRating
        realmMovie.imDbRatingCount = movie.imDbRatingCount
        realmMovie.metacriticRating = movie.metacriticRating
        realmMovie.genres = movie.genres
        realmMovie.genreList = List()
        movie.genreList.forEach({ item in
            let keyValue = RealmKeyValue()
            keyValue.key = item.key
            keyValue.value = item.value
            realmMovie.genreList.append(keyValue)
        })
        realmMovie.directorList = List()
        movie.directorList.forEach({ item in
            let idName = RealmIdName()
            idName.id = item.id
            idName.name = item.name
            realmMovie.directorList.append(idName)
        })
        realmMovie.directors = movie.directors
        realmMovie.stars = movie.stars
        realmMovie.starList = List()
        movie.starList.forEach({ item in
            let idName = RealmIdName()
            idName.id = item.id
            idName.name = item.name
            realmMovie.starList.append(idName)
        })
        return realmMovie
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
