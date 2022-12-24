//
//  ReviewObject.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

struct ReviewObject: Codable {
    var author: String?
    var content: String?
    var id: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case author, content, id, url
    }
}
