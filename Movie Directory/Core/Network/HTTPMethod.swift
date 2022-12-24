//
//  HTTPMethod.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

enum HTTPMethod {
    case GET
    case POST
    case PUT
    case DELETE
    
    var isGet: Bool {
        return self == .GET
    }
}
