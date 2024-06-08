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
    @Published var temperature: String = "--"
    @Published var icon: String = "cloud"
    @Published var hourlyForecast: [HourlyWeather] = []

    private let weatherService = WeatherService()
    private var locationManager: LocationManager

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self.locationManager.locationUpdateHandler = { [weak self] location in
            self?.fetchWeather(for: location)
        }
    }

    private func fetchWeather(for location: CLLocation) {
        Task {
            do {
                let weather = try await weatherService.weather(for: location)
                DispatchQueue.main.async {
                    self.temperature = "\(weather.currentWeather.temperature.value)°"
                    self.icon = self.getWeatherIcon(condition: weather.currentWeather.condition)
                    self.hourlyForecast = weather.hourlyForecast.forecast.map {
                        HourlyWeather(time: $0.date, temperature: $0.temperature.value, condition: $0.condition)
                    }
                }
            } catch {
                print("Failed to get weather data: \(error)")
            }
        }
    }
    
    private func getWeatherIcon(condition: WeatherCondition) -> String {
        switch condition {
        case .clear:
            return "sun.max"
        case .rain:
            return "cloud.rain"
        default:
            return "cloud"
        }
    }
}

struct HourlyWeather: Identifiable {
    let id = UUID()
    let time: Date
    let temperature: Double
    let condition: WeatherCondition
}
