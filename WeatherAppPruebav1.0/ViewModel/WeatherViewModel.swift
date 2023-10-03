//
//  WeatherViewModel.swift
//  WeatherAppPruebav1.0
//
//  Created by NAHUM MARTINEZ on 24/9/23.
//

import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    
    @Published var suggestion : [WeatherData] = []
    
    @Published var isFarenheit: Bool = false
    
    func fetchWeather(city: String,unit:String){
        self.isFarenheit = false
        
        NetworkManager.shared.fetchWeather(city: city.lowercased(), unit: unit) {  [weak self] result in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.suggestion  = weather.list
                case .failure(let error):
                    print("Error:\(error.localizedDescription)")
                }
            }
        }
    }
    
    
    
    func fetchWeather(lat: Double, lon: Double,unit:String = "metric"){
        self.isFarenheit = false
        
        NetworkManager.shared.fetchWeather(lat: lat, lon: lon, unit: unit) {  [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.weatherData = weather
                case .failure(let error):
                    print("Error:\(error.localizedDescription)")
                }
            }
            
        }
    }
    
    
    func toogleUnits() {
        self.isFarenheit.toggle()
        let currentTemp = self.weatherData?.main.temp ?? 0.0
        
        
        
        if self.isFarenheit {
            
            self.weatherData?.main.temp = ((currentTemp * 9/5) + 32)
        } else {
            
            self.weatherData?.main.temp = ((currentTemp - 32)  * 5/9)
        }
        
        
        for i in 0..<suggestion.count {
            
            let currentTemp = self.suggestion[i].main.temp
            
            
            if self.isFarenheit {
                
                self.suggestion[i].main.temp = ((currentTemp * 9/5) + 32)
            } else {
                
                self.suggestion[i].main.temp  = ((currentTemp - 32)  * 5/9)
            }
            
            
        }//:FIN DE FOR
        
        
    }
    
    
    
    
}

