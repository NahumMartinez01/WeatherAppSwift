//
//  NetworkManager.swift
//  WeatherAppPruebav1.0
//
//  Created by NAHUM MARTINEZ on 25/9/23.
//

import Foundation
import UIKit
import SwiftUI


enum Errors: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case decondingError
}

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather?&appid=d059036fd7d00cf47cccae737e63604e&q="
    static let baseURL2 = "https://api.openweathermap.org/data/2.5/find?&appid=d059036fd7d00cf47cccae737e63604e&q="
    
    private override init() {}
    

    func fetchWeather(lat: Double, lon: Double ,unit:String = "metric",completed: @escaping((Result<WeatherData, Errors>)) -> Void ){
        guard let url = URL(string: "\(NetworkManager.baseURL)&lat=\(lat)&lon=\(lon)&units=\(unit)")  else {
            completed(.failure(.invalidURL))
            return
        }
        
             
       let task =  URLSession.shared.dataTask(with: url)  { data, _, error in
            
            guard let data = data else {
                print("invalida data")
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(WeatherData.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                
                completed(.failure(.decondingError))
                }
            }
        
        task.resume()
        }

    
    
    
    
    func fetchWeather(city: String,unit:String, completed: @escaping((Result<WeatherSearch, Errors>)) -> Void ){
        guard let city = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(NetworkManager.baseURL2 + city.lowercased())&units=\(unit)")  else {
            completed(.failure(.invalidURL))
            return
        }
        
        
              
       let task =  URLSession.shared.dataTask(with: url)  { data, _, error in
            
           guard let data = data else {
               print("invalida data")
               completed(.failure(.invalidData))
               return
           }
           
           do{
               let decoder = JSONDecoder()
               let decodedResponse = try decoder.decode(WeatherSearch.self, from: data)
               
               completed(.success(decodedResponse))
           } catch {
               
               completed(.failure(.decondingError))
               }
           }
        
        task.resume()
        }
        
    }

