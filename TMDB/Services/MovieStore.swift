//
//  MovieStore.swift
//  TMDB
//
//  Created by Death Code on 04/02/21.
//

import Foundation


class MovieStore: MovieService{
    
    static let sharedInstance = MovieStore()
    private init(){}
    
    private let apiKey = "6b9c915bda967ab8e42a24d089ae997f"
    private let baseUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
    
        self.loadURLAndDecode(url: url, params: ["append_to_response":"video,credits"], completion: completion)
    }
    
    func fetchMovies(from endPoint: MovieListEndpoints, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/movie/\(endPoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseUrl)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.loadURLAndDecode(url: url, params:["language":"en-US", "include_adult":"false", "region":"US", "query":query] , completion: completion)
        
    }
    
    private func loadURLAndDecode<D:Decodable>(url:URL, params: [String: String]?=nil, completion: @escaping (Result<D, MovieError>)->()){
        guard var urlComponents = URLComponents(url:url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        if let params = params{
            queryItems.append(contentsOf: params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            })
        }
        
        urlComponents.queryItems = queryItems
        guard let finalUrl = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalUrl){[weak self](data, resonse, error) in
            guard let self = self else { return }
            if error != nil{
                self.executeCompletionOnMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let urlResponse = resonse as? HTTPURLResponse, 200..<300 ~= urlResponse.statusCode else {
                self .executeCompletionOnMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self .executeCompletionOnMainThread(with: .failure(.noData), completion: completion)
                return
            }
            do{
                let decodeResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionOnMainThread(with: .success(decodeResponse), completion: completion)
            }catch{
                self.executeCompletionOnMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionOnMainThread<D:Decodable>(with result:Result<D, MovieError>, completion: @escaping (Result<D, MovieError>)->()){
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
