//
//  Endpoint.swift
//  Covid-19 Dependecy_Injection
//
//  Created by Arpit Srivastava on 01/11/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//


protocol Endpoint {
  var path: String { get }
}

enum CovidCase {
  case india
}

extension CovidCase: Endpoint {
    private var baseUrl:String{
        return "https://api.covid19api.com/dayone/country/"
    }
    
    
  var path: String {
    switch self {
    case .india: return baseUrl + "india"
    }
  }
}
