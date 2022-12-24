//
//  IRequest.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

protocol IRequest {
    func call(_ endPoint: EndPoint, bodyParams: [String: Any], completion: @escaping (Data?, ErrorType?) -> Void)
}
