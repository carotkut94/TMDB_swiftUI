//
//  ContentView.swift
//  TMDB
//
//  Created by Death Code on 04/02/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MovieBackdropCard(movie: Movie.stubbedMovie)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
