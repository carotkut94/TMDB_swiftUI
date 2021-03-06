//
//  Movie.swift
//  TMDB
//
//  Created by Death Code on 04/02/21.
//

import Foundation

struct MovieResponse: Decodable {
    let results:[Movie]
}

struct Movie: Decodable, Identifiable{
    let id:Int
    let title:String
    let backdropPath:String?
    let posterPath:String?
    let overview:String
    let voteAverage:Double
    let voteCount:Int
    let runtime:Int?
    
    var backdropURL:URL{
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    
    
    var posterUrl:URL{
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}
