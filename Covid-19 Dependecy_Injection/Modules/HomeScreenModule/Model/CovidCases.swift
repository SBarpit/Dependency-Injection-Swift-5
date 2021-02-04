//
//  CovidCases.swift
//  Covid-19 Dependecy_Injection
//
//  Created by Arpit Srivastava on 01/11/20.
//  Copyright © 2020 Arpit Srivastava. All rights reserved.
//
struct DailyTaly:Codable {
    let Date:String
    let Confirmed:Int
    let Deaths:Int
    let Recovered:Int
    let Active:Int
    
    
}

struct CovidCases: Codable {
    let data:[DailyTaly]
}
