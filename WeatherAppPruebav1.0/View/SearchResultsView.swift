//
//  SearchResults.swift
//  WeatherAppPruebav1.0
//
//  Created by NAHUM MARTINEZ on 29/9/23.
//

import SwiftUI

struct SearchResultsView: View {
    @EnvironmentObject var viewmodel : WeatherViewModel
    
    let country: WeatherData
    
    var body: some View {
        VStack{
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
            
        }
        
    }
}



