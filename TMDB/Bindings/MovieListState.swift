//
//  MovieListState.swift
//  TMDB
//
//  Created by Death Code on 04/02/21.
//

import SwiftUI

class MovieListState: ObservableObject{
    
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error:NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.sharedInstance) {
        self.movieService = movieService
    }
    
    func loadMovies(with endPoint:MovieListEndpoints){
        self.movies = nil
        self.isLoading = true
        self.movieService.fetchMovies(from: endPoint){[weak self](result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result{
            case .success(let resposne): self.movies = resposne.results
            case .failure(let error): self.error = error as NSError
            }
        }
    }
    
    
}
