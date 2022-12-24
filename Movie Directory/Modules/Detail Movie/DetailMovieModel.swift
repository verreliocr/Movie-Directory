//
//  DetailMovieModel.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

class DetailMovieModel {
    var movieId: Int
    var detailMovie: DetailMovieResponse = DetailMovieResponse()
    var youtubeKey: String = ""
    
    init(movieId: Int) {
        self.movieId = movieId
    }
}
