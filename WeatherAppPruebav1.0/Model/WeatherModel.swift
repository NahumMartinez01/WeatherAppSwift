//
//  WeatherModel.swift
//  WeatherAppPruebav1.0
//
//  Created by NAHUM MARTINEZ on 24/9/23.
//

import Foundation

struct WeatherSearch: Codable  {
    var list: [WeatherData]
}

struct WeatherData: Codable, Identifiable {
    var id: Int
    var name: String
    var main: WeatherMain
    var sys: Sys
}

struct WeatherMain: Codable {
    var temp: Double
}

struct Sys: Codable {
    var country: String
}


    
extension WeatherData {
    static let MOCK_DATA: WeatherData = WeatherData(id: 0, name: "", main: WeatherMain(temp: 0), sys: Sys(country: ""))
}
