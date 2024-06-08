//
//  HourlyForecastView.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 08/06/2024.
//

import Foundation
import SwiftUI

struct HourlyForecastView: View {
    @StateObject private var locationManager = LocationManager()
        @StateObject private var weatherManager: WeatherManager

        init() {
            let locationManager = LocationManager()
            _locationManager = StateObject(wrappedValue: locationManager)
            _weatherManager = StateObject(wrappedValue: WeatherManager(locationManager: locationManager))
        }

    var body: some View {
        NavigationView {
            VStack {
                               Image(systemName: weatherManager.icon)
                                   .font(.largeTitle)
                                   .shadow(radius: 2)
                                   .padding()
                               Text("Temperature: \(weatherManager.temperature)")
            }
            
            List(weatherManager.hourlyForecast) { forecast in
                HStack {
                    Text("\(forecast.time, formatter: DateFormatter.shortTime)")
                    Spacer()
                    Text("\(forecast.temperature, specifier: "%.1f")°C")
                    Text(forecast.condition.description)
                }
            }
            .navigationTitle("Hourly Forecast")
            
        }
    }
}

extension DateFormatter {
    static var shortTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }
}

