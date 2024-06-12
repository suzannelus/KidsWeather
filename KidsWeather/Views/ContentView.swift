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
import CoreMotion


struct ForecastView: View {
    
    
    
    
    @Environment(LocationManager.self) var locationManager
    @Environment(\.scenePhase) private var scenePhase
    @State private var selectedCity: City?
    @State private var timezone: TimeZone = .current
    
    let weatherManager = WeatherManager.shared
    
    @State private var currentWeather: CurrentWeather?
    @State private var isLoading = false
    
    @State private var pitch = 0.0
    @State private var yaw = 0.0
    @State private var roll = 0.0
    
    
    var body: some View {
        ZStack {
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
                                            Text(currentWeather.date.localDate(for: timezone))
                                                
                                            Text(currentWeather.date.localTime(for: timezone))                                        }
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
                                    .frame(maxWidth: 500)
                                    
                                    Spacer()

                                }
                                
                                
                            }
                            
                            AttributionView()
                                .tint(.white)
                            
                        }
                    }
                }
            } else {
                Text("Hi")
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            if let currentWeather = currentWeather {
                BackgroundView(condition: currentWeather.condition)
                    .ignoresSafeArea()
            } else {
                DefaultBackground()
                    .ignoresSafeArea()
            }
        }
        .preferredColorScheme(.dark)
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                selectedCity = locationManager.currentLocation
                if let selectedCity {
                    Task {
                        await fetchWeather(for: selectedCity)
                    }
                }
            }
        }
        .task(id: locationManager.currentLocation) {
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
            timezone = await locationManager.getTimezone(for: city.cLlocation)
        }
        isLoading = false
    }
    
}
    
    #Preview {
        ForecastView()
            .environment(LocationManager())
    }
    
    
