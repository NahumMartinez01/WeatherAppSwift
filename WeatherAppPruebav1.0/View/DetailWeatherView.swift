//
//  DetailWeatherView.swift
//  WeatherAppPruebav1.0
//
//  Created by NAHUM MARTINEZ on 2/10/23.
//

import SwiftUI

struct DetailWeatherView: View {
    @EnvironmentObject var viewmodel: WeatherViewModel
    let country: WeatherData
    
    var body: some View {
        
        VStack{
            Spacer()
            
            HStack(spacing: 8){
                Text(String(format: "%.2f", country.main.temp))
                Text(viewmodel.isFarenheit ? "F" : "C")
            }
            .font(.system(size: 36))
            .fontWeight(.bold)
            .padding(.bottom, 12)
            
            VStack{
                Text("\(country.name)")
                    .font(.system(size: 26))
                    .fontWeight(.thin)
            }
            
            Spacer()
        } //VSTACK
        
        
        VStack {
            Button(action: {
                viewmodel.toogleUnits()
            }) {
                Text(viewmodel.isFarenheit ? "CAMBIAR DE FARENHEIT / CELSIUS" : "CAMBIAR DE CELSIUS / FARENHEIT")
                    .padding(.horizontal)
                    .font(Font.headline.smallCaps())
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 16)
            .foregroundColor(Color.white)
            .background(Color.black)
            .cornerRadius(8)
            
        } //: VSTACK
    }
}


