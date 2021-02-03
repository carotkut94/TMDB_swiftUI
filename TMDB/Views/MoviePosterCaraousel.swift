//
//  File.swift
//  TMDB
//
//  Created by Death Code on 04/02/21.
//

import SwiftUI

struct MoviePosterCaraousel:View {
    let title:String
    let movies: [Movie]
    
    var body: some View{
        VStack(alignment: .leading, spacing:16){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators:false){
                HStack(alignment: .top, spacing:16){
                    ForEach(self.movies){ movie  in
                        MoviePosterCard(movie: movie)
                            .padding(.leading, movie.id == self.movies.first!.id ? 16:0 )
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16:0 )
                    }
                }
            }
        }
    }
}

struct nameMoviePosterCaraousel_Previews: PreviewProvider{
    static var previews: some View{
        MoviePosterCaraousel(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}
