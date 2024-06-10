//
//  ContentView.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 08/06/2024.
//

import SwiftUI
import CoreLocation
import WeatherKit


struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherManager: WeatherManager

        init() {
            let locationManager = LocationManager()
            _locationManager = StateObject(wrappedValue: locationManager)
            _weatherManager = StateObject(wrappedValue: WeatherManager(locationManager: locationManager))
        }
    
    var currentTemp = 19
    
    
    var body: some View {
        ZStack {
            
            Color.blue
                .ignoresSafeArea()
            VStack {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 60.0)
                    .foregroundColor(.white)
                    .opacity(0.3)
                    .aspectRatio(16/9, contentMode: .fit)
                    
                    HStack {
                        Text("\(currentTemp)°")
                            .font(.custom("Avenir", size: 200, relativeTo: .largeTitle))
                            .fontDesign(.rounded)
                            .fontWeight(.medium)
                        Cloudy()
                            .aspectRatio(1.0, contentMode: .fit)
                            .padding(20)
                            

                    }
                    .padding()
                }
                .padding(60)

                ZStack{
                    VStack {
                        
                    }
                }
            }
            
        }
    }
}



#Preview {
    ContentView()
}
