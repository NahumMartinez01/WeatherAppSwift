//
//  WeatherCityModel.swift
//  WeatherAppPruebav1.0
//
//  Created by NAHUM MARTINEZ on 25/9/23.
//

import Foundation


struct WeatherResponse: Codable {
    let name: String
    let main: Weather
   
}

struct Weather: Codable {
    let temp: Double
    
}

