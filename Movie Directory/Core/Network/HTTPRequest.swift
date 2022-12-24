//
//  HTTPRequest.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

class HTTPRequest: IRequest {
    func call(_ endPoint: EndPoint, bodyParams: [String : Any], completion: @escaping (Data?, ErrorType?) -> Void) {
        
        let session = URLSession.shared
        let url = URL(string: endPoint.url)!
        var request = URLRequest(url: url)
        
        switch endPoint.method {
        case .GET:
            request.httpMethod = "GET"
        case .POST:
            request.httpMethod = "POST"
        case .PUT:
            request.httpMethod = "PUT"
        case .DELETE:
            request.httpMethod = "DELETE"
        }

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let bodyData = try? JSONSerialization.data(withJSONObject: bodyParams, options: []), !endPoint.method.isGet {
            request.httpBody = bodyData
        }
        
        if Reachability.isConnectedToNetwork() {
            
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.main.async {
                    if let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode >= 300,
                        error == nil {
                        completion(nil, ErrorType.serverError(data))
                        return
                    }
                    completion(data, nil)
                }
            })
            task.resume()
            
        }else {
            completion(nil, ErrorType.noConnection)
        }
        
    }
}
