//
//  MovieService.swift
//  TMDB
//
//  Created by Death Code on 04/02/21.
//

import Foundation


protocol MovieService {
    func fetchMovies(from endPoint:MovieListEndpoints, completion: @escaping (Result<MovieResponse, MovieError>)->())
    func fetchMovie(id:Int, completion: @escaping (Result<Movie, MovieError>)->())
    func searchMovie(query:String, completion: @escaping (Result<MovieResponse, MovieError>)->())
}


enum MovieListEndpoints: String{
    case nowPlaying = "now_playing"
    case upcoming
    case topRated =  "top_rated"
    case popular
    
    var description: String{
        switch self {
        case .nowPlaying: return "Now Playing"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top Rated"
        case .popular: return "Popular"
        }
    }
}

enum MovieError:Error, CustomNSError{
    case apiError
    case invalidEndpoint
    case noData
    case invalidResponse
    case serializationError
    
    var localizedDescription: String{
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid Endpoint"
        case .invalidResponse: return "Invalid Response"
        case .noData: return "No Data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any]{
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}


