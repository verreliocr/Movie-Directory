//
//  VideoObject.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

enum VideoType: String, Codable, CaseIterableDefaultsLast {
    case trailer = "Trailer"
    case teaser = "Teaser"
    case clip = "Clip"
    case featurette = "Featurette"
    case bts = "Behind the Scenes"
    case bloopers = "Bloopers"
    case unknown
    
    var isTrailer: Bool {
        return self == .trailer
    }
}

struct VideoObject: Codable {
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    var type: VideoType?
    
    enum CodingKeys: String, CodingKey {
        case id, key, name, site, type
    }
}
