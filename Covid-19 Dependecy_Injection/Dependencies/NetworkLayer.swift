//
//  NetworkLayer.swift
//  Covid-19 Dependecy_Injection
//
//  Created by Arpit Srivastava on 01/11/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//

import UIKit

enum HttpMethodsType:String{
    case GET
    case POST
    case DELETE
    case PUT
}

protocol Networking {
    
    typealias JSONDictionary = [String:String]
    typealias CompletionHandler = (Data?,Swift.Error?)->Void
    func request(from:Endpoint,param:JSONDictionary,method:HttpMethodsType,header:JSONDictionary,completion:@escaping CompletionHandler)
}

class NetworkLayer: Networking {
    
    
    
    func request(from: Endpoint,param:JSONDictionary = [:],method:HttpMethodsType = .GET,header:JSONDictionary = [:],completion: @escaping CompletionHandler) {
        guard let url = URL(string: from.path) else { return }
        let request = createRequest(from: url, param: param, method: method, header: header)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createRequest(from url:URL,param:JSONDictionary,method:HttpMethodsType,header:JSONDictionary) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        _ = header.compactMap { request.setValue($0.value, forHTTPHeaderField: $0.key)}
        if !param.isEmpty{
            request.httpBody = try! JSONEncoder().encode(param)
        }
        request.cachePolicy = .reloadIgnoringCacheData
        print("==========API REQUEST LOGS==========")
        print("METHOD -----> \(String(describing: request.httpMethod))")
        print("PARAM ------> \(String(describing: param))")
        print("HEADER ------> \(String(describing: request.allHTTPHeaderFields))")
        return request
    }
    
    private func createDataTask(from request:URLRequest,completion: @escaping CompletionHandler) -> URLSessionDataTask{
        return URLSession.shared.dataTask(with: request) { (data, responce, error) in
            completion(data,error)
        }
        
    }
}
