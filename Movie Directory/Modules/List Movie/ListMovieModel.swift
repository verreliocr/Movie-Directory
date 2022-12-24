//
//  ListMovieModel.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

class ListMovieModel {
    var page: Int = 1
    var totalPages: Int = 0
    var totalElements: Int = 0
    var movies: [ListMovieObject] = []
}
