//
//  NetworkLayer.swift
//  Covid-19 Dependecy_Injection
//
//  Created by Arpit Srivastava on 01/11/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//

import UIKit

protocol Networking {
    typealias CompletionHandler = (Data?,Swift.Error?)->Void
    func request(from:Endpoint, completion:@escaping CompletionHandler)
}

class NetworkLayer: Networking {
    
    func request(from: Endpoint, completion: @escaping CompletionHandler) {
        guard let url = URL(string: from.path) else { return }
        let request = createRequest(from: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createRequest(from url:URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringCacheData
        return request
    }
    
    private func createDataTask(from request:URLRequest,completion: @escaping CompletionHandler) -> URLSessionDataTask{
        return URLSession.shared.dataTask(with: request) { (data, responce, error) in
            completion(data,error)
        }
        
    }
}
