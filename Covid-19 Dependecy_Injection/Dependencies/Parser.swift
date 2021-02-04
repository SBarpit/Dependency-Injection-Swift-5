//
//  Parser.swift
//  Covid-19 Dependecy_Injection
//
//  Created by Arpit Srivastava on 04/02/21.
//  Copyright © 2021 Arpit Srivastava. All rights reserved.
//

import Foundation

class Parser{
    
    static let shared = Parser()
    private init(){}
    
    func decodeParser<T:Decodable>(type:T.Type,from:Data?) -> [T]?{
        let decoder = JSONDecoder()
        
//        print(dataToJSON(data: from!))
        guard let d = from, let response = try? decoder.decode([T].self, from: d) else {
            return nil
        }
        return response
    }
    
    func dataToJSON(data: Data) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
    
}
