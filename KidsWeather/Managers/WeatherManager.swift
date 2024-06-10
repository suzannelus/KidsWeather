//
//  WeatherManager.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 08/06/2024.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherManager: ObservableObject {
    static let shared = WeatherManager()
    let service = WeatherService.shared
    
   
    
    func currentWeather(for location: CLLocation) async -> CurrentWeather? {
        let currentWeather = await Task.detached(priority: .userInitiated) {
            let forecast = try? await self.service.weather(
                for: location,
                including: .current
            
            )
            return forecast
        }.value
        return currentWeather
    }
    
    func weatherAttribution() async -> WeatherAttribution? {
        let attribution = await Task(priority: .userInitiated) {
            return try? await self.service.attribution
        }.value
        return attribution
    }
}
