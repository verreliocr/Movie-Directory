//
//  ListMovieObject.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

struct ListMovieObject: Codable {
    var id: Int?
    var posterPath: String?
    var title: String?
    var voteAverage: Double?
    var overview: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}
