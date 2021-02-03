//
//  Movie+Stub.swift
//  TMDB
//
//  Created by Death Code on 04/02/21.
//

import Foundation


extension Movie{
    
    static var stubbedMovies: [Movie]{
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.results
    }
    
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
}

extension Bundle{
    func loadAndDecodeJSON<D:Decodable>(filename:String) throws -> D?{
        do{
            guard let url = self.url(forResource: filename, withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: url)
            let jsonDecoder = Utils.jsonDecoder
            let decodedData = try jsonDecoder.decode(D.self, from: data)
            return decodedData
        }catch{
            throw error
        }
    }
}
