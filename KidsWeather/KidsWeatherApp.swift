//
//  KidsWeatherApp.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 08/06/2024.
//

import SwiftUI

@main
struct KidsWeatherApp: App {
    
    @State private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            if locationManager.isAuthorized {
                ForecastView()
            } else {
                LocationDeniedView()
            }
        }
        .environment(locationManager)
    }
}
