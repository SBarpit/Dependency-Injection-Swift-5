//
//  CovidParser.swift
//  Covid-19 Dependecy_Injection
//
//  Created by Arpit Srivastava on 01/11/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol CovidFetcher {
    func fetch<T:Decodable>(_ endpoint:Endpoint,type:T.Type,response: @escaping ([T]?) -> Void)
}


class CovidParser: CovidFetcher {

    let networking:NetworkLayer!
    
    init(networking:NetworkLayer){
        self.networking = networking
    }
    
    func fetch<T:Decodable>(_ endpoint:Endpoint,type:T.Type,response: @escaping ([T]?) -> Void) {
        networking.request(from: endpoint) { (data, error) in
            if let e = error{
                print("Error ----- \(e.localizedDescription)")
                return
            }else{
                let decoded = Parser.shared.decodeParser(type: type.self, from: data)
                if let decode = decoded{
                    print(decode)
                    response(decode)
                }else{
                    print("Error in parsing.....")
                }
            }
        }
    }
    
    
}
