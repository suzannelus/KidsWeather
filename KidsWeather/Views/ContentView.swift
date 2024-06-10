//
//  ContentView.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 08/06/2024.
//

// 52.373709, 4.874793

import SwiftUI
import CoreLocation
import WeatherKit


struct ForecastView: View {
    
    @Environment(LocationManager.self) var locationManager
    @State private var selectedCity: City?
    
    let weatherManager = WeatherManager.shared
    
    @State private var currentWeather: CurrentWeather?
    @State private var isLoading = false
    
    
    
    
    
    
    var body: some View {
        ZStack {
            if let selectedCity {
                
                
                if isLoading {
                    ProgressView()
                    Text("fetching weather...")
                } else {
                    if let currentWeather {
                        
                        Color.blue
                            .ignoresSafeArea()
                        VStack {
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 60.0)
                                    .foregroundColor(.white)
                                    .opacity(0.3)
                                    .aspectRatio(16/9, contentMode: .fit)
                                VStack {
                                    Text(selectedCity.name)
                                        .font(.title)
                                    Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                                    Text(Date.now.formatted(date: .omitted, time: .shortened))
                                    HStack {
                                        VStack {
                                            
                                            
                                            Text("\(currentWeather.temperature.value.formatted(.number.precision(.fractionLength(0))))°")
                                            
                                            Image(systemName: currentWeather.symbolName)
                                                .renderingMode(.original)
                                                .symbolVariant(.fill)
                                            Text(currentWeather.condition.description)
                                                .font(.subheadline)
                                        }
                                        .font(.custom("Avenir", size: 180, relativeTo: .largeTitle))
                                        .fontDesign(.rounded)
                                        .fontWeight(.medium)
                                        
                                        
                                        
                                        Cloudy()
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .padding(20)
                                        
                                        
                                    }
                                    .padding()
                                }
                            }
                            .padding(60)
                            AttributionView()
                        }
                    }
                }
            }
        }.task(id: locationManager.currentLocation) {
            if let currentLocation = locationManager.currentLocation, selectedCity == nil {
                selectedCity = currentLocation
            }
            
        }
        .task(id: selectedCity) {
            if let selectedCity {
                await fetchWeather(for: selectedCity)
            }
        }
    }
    
    func fetchWeather(for city: City) async {
        isLoading = true
        Task.detached { @MainActor in
            currentWeather = await weatherManager.currentWeather(for:city.cLlocation)
            
        }
        isLoading = false
    }
    
}



#Preview {
    ForecastView()
        .environment(LocationManager())
}
