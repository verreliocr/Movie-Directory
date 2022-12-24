//
//  DetailMovieResponse.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

struct DetailMovieResponse: Codable {
    var id: Int?
    var posterPath: String?
    var title: String?
    var voteAverage: Double?
    var voteCount: Int?
    var overview: String?
    var releaseDate: String?
    var genres: [GenreItem]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
}

struct GenreItem: Codable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
