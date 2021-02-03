//
//  MovieBackdropCaraousel.swift
//  TMDB
//
//  Created by Death Code on 04/02/21.
//

import SwiftUI


struct MovieBackdropCaraousel: View {
    let title:String
    let movies: [Movie]
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators:false){
                HStack(alignment: .top, spacing: 16){
                    ForEach(self.movies) { movie in
                        MovieBackdropCard(movie:movie)
                            .frame(width:272, height:200)
                            .padding(.leading, movie.id == self.movies.first!.id ? 16:0 )
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16:0 )
                    }
                }
            }
        }
    }
}

struct MovieBackdropCaraousel_Previews: PreviewProvider{
    static var previews: some View{
        MovieBackdropCaraousel(title: "Latest", movies: Movie.stubbedMovies)
    }
}
