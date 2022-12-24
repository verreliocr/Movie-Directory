//
//  Extension+Codable.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

extension Decodable {
    static func decode(from data: Data?) -> Self? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}

extension Encodable {
    func asDictionary() -> [String: Any]? {
        if let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            print(dictionary)
            return dictionary
        }
        return nil
    }
}

protocol CaseIterableDefaultsLast: Decodable & CaseIterable & RawRepresentable
where Self.RawValue: Decodable, Self.AllCases: BidirectionalCollection { }

extension CaseIterableDefaultsLast {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.last!
    }
}
