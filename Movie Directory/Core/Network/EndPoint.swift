//
//  EndPoint.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

private let baseURL = "https://api.themoviedb.org/3"
private let APIKey = "0634895be8bc7be70fe69ceef8e006cf"

enum EndPoint {
    case getDiscoverMovie(page: Int)
    case getDetailMovie(id: Int)
    case getVideo(id: Int)
    case getReviews(id: Int, page: Int)
    
    var method: HTTPMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    var url: String {
        var path = ""
        switch self {
        case .getDiscoverMovie(let page):
            path = "/discover/movie?api_key=\(APIKey)&page=\(page)"
        case .getDetailMovie(let id):
            path = "/movie/\(id)?api_key=\(APIKey)"
        case .getVideo(let id):
            path = "/movie/\(id)/videos?api_key=\(APIKey)"
        case .getReviews(let id, let page):
            path = "/movie/\(id)/reviews?api_key=\(APIKey)&page=\(page)"
        }
        print(baseURL + path)
        return baseURL + path
    }
}
