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
    @State private var selectedCity: City? = City(name: "Amsterdam", latitude: 52.373709, longitude: 44.874793)
    
    let weatherManager = WeatherManager.shared
    
    @State private var currentWeather: CurrentWeather?
    @State private var isLoading = false
    
    

    var body: some View {
        ZStack {
            if ((currentWeather?.isDaylight) != nil) {
                SunnyBackground()
            } else {
                ClearNight()
            }
            ClearNight()
            if let selectedCity {
                
                if isLoading {
                    ProgressView()
                    Text("fetching weather...")
                } else {
                    if let currentWeather {
                        
                        VStack {
                            
                            ZStack {
                               
                                VStack {
                                    Group {
                                        Text(selectedCity.name)
                                            .font(.title)
                                        HStack {
                                            Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                                            Text(Date.now.formatted(date: .omitted, time: .shortened))
                                        }
                                    }
                                    .foregroundColor(.white)
                                    HStack {
                                   
                                            Text("\(currentWeather.temperature.value.formatted(.number.precision(.fractionLength(0))))°")
                                                   .font(.system(size: 500))
                                                   .minimumScaleFactor(0.01)
                                        .fontDesign(.rounded)
                                        .fontWeight(.medium)
                                        .padding()
                                        .foregroundColor(.white)

                                        VStack {
                                            Image("\(currentWeather.condition)")
                                                .resizable()
                                                .scaledToFit()
                                            Text(currentWeather.condition.description)
                                               
                                        }
                                        
                                    }
                                   
                                }
                                
                               
                            }
                            ScrollView {
                                HStack {
                                    HStack {
                                        Capsule()
                                        Capsule()
                                        Capsule()
                                        
                                        
                                    }
                                    Divider()
                                    HStack {
                                        Capsule()
                                        Capsule()
                                        Capsule()
                                        
                                        
                                    }
                                }
                            }
                            
                            AttributionView()
                            
                        }
                    }
                }
            } else {
                Text("Hi")
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
            currentWeather = await weatherManager.currentWeather(for: city.cLlocation)
        }
        isLoading = false
    }
}

#Preview {
    ForecastView()
        .environment(LocationManager())
}


