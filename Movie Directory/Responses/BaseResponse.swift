//
//  BaseResponse.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    var id: Int?
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: T?
    
    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
