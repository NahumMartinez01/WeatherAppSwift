//
//  ContentView.swift
//  WeatherAppPruebav1.0
//
//  Created by NAHUM MARTINEZ on 24/9/23.
//

import SwiftUI

///NOTA: Tengo que corregir el cambia de F a C en los grados esto esta por Hacer

struct ContentView: View {
    @ObservedObject private var weatherViewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var city = ""
    
    
    
    
    //MARK: FUNCTION GEOLOCATION
    private func fetchWeatherByLocation(unit: String)  {
        locationManager.manager.startUpdatingLocation()
        weatherViewModel.fetchWeather(lat: locationManager.manager.location?.coordinate.latitude ?? 0, lon: locationManager.manager.location?.coordinate.longitude ?? 0, unit: unit)
        
    }
    
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                VStack(){
                    Spacer()
                    
                    
                    if city.isEmpty {
                        
                        if let weather = weatherViewModel.weatherData{
                            VStack {
                                HStack(spacing: 8){
                                    Text(String(format: "%.2f", weather.main.temp))
                                    Text(weatherViewModel.isFarenheit ? "F" : "C")
                                }
                                .font(.system(size: 36))
                                .fontWeight(.bold)
                                .padding(.bottom, 12)
                                VStack{
                                    Text("\(weather.name)")
                                        .font(.system(size: 26))
                                        .fontWeight(.thin)
                                }
                            }
                        }
                    } else {
                        if let city = weatherViewModel.suggestion {
                            List(city) { country in
                                
                                NavigationLink(destination: DetailWeatherView(country: country).environmentObject(weatherViewModel)) {
                                    HStack{
                                        Text(country.name)
                                        Text(", \(country.sys.country)")
                                    }
                                }
                            }
                            .listStyle(.plain)
                        }
                    }
                    Spacer()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)                
            }  //:Ztack
            
            
            
            VStack {
                Button(action: {
                    
                    weatherViewModel.toogleUnits()
                    
                }) {
                    Text(weatherViewModel.isFarenheit ? "CAMBIAR DE FARENHEIT / CELSIUS" : "CAMBIAR DE CELSIUS / FARENHEIT")
                        .padding(.horizontal)
                        .font(Font.headline.smallCaps())
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 16)
                .foregroundColor(Color.white)
                .background(Color.black)
                .cornerRadius(8)
                
            } //: VSTACK
            
        } //: NavigationView
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.orange)
        .padding(.top, -30)
        .searchable(text: $city, prompt: "Search")
        .onAppear {
            if locationManager.manager.authorizationStatus  == .authorizedWhenInUse {
                fetchWeatherByLocation(unit: "metric")
            }
        }
        .onChange(of: city){ newCity in
            if city != "" && city.count > 2 {
                weatherViewModel.fetchWeather(city: newCity, unit: "metric")
            }else {
                if locationManager.manager.authorizationStatus  == .authorizedWhenInUse {
                    fetchWeatherByLocation(unit:"metric")
                }
            }
            
        }
        .onChange(of: locationManager.location){ newLocation in
            if locationManager.manager.authorizationStatus == .authorizedWhenInUse {
                fetchWeatherByLocation(unit: "metric")
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
