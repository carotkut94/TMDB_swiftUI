//
//  MovieListView.swift
//  TMDB
//
//  Created by Death Code on 04/02/21.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingMovieState = MovieListState()
    @ObservedObject private var topRatedMoviedState = MovieListState()
    @ObservedObject private var popularMovieState = MovieListState()
    
    var body: some View{
        NavigationView{
            List{
                Group{
                    if nowPlayingState.movies != nil{
                        MoviePosterCaraousel(title: "Now Playing", movies: nowPlayingState.movies!)
                    }else{
                        LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error){
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                }.listRowInsets(EdgeInsets(top:16, leading: 0, bottom: 8, trailing: 0))
                
                Group{
                    if upcomingMovieState.movies != nil{
                        MovieBackdropCaraousel(title: "Upcoming", movies: upcomingMovieState.movies!)
                    }else{
                        LoadingView(isLoading: upcomingMovieState.isLoading, error: upcomingMovieState.error){
                            self.upcomingMovieState.loadMovies(with: .upcoming)
                        }
                    }
                }.listRowInsets(EdgeInsets(top:8, leading: 0, bottom: 8, trailing: 0))
                
                Group{
                    if topRatedMoviedState.movies != nil{
                        MovieBackdropCaraousel(title: "Top Rated", movies: topRatedMoviedState.movies!)
                    }else{
                        LoadingView(isLoading: topRatedMoviedState.isLoading, error: topRatedMoviedState.error){
                            self.topRatedMoviedState.loadMovies(with: .topRated)
                        }
                    }
                }.listRowInsets(EdgeInsets(top:8, leading: 0, bottom: 8, trailing: 0))
                
                
                Group{
                    if popularMovieState.movies != nil{
                        MovieBackdropCaraousel(title: "Popular", movies: popularMovieState.movies!)
                    }else{
                        LoadingView(isLoading: popularMovieState.isLoading, error: popularMovieState.error){
                            self.popularMovieState.loadMovies(with: .popular)
                        }
                    }
                }.listRowInsets(EdgeInsets(top:8, leading: 0, bottom: 16, trailing: 0))
            }.navigationBarTitle("TMDB")
        }.onAppear{
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.popularMovieState.loadMovies(with: .popular)
            self.topRatedMoviedState.loadMovies(with: .topRated)
            self.upcomingMovieState.loadMovies(with: .upcoming)
        }
    }
    
}


struct MovieListView_Previews: PreviewProvider {
    static var previews: some View{
        MovieListView()
    }
}
