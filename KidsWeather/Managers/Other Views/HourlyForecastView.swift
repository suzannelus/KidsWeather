//
//  DailyForecastView.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 16/06/2024.
//

struct HourlyForecastView: View {
    let hourlyForecast: Forecast<HourWeather>
    let timezone: TimeZone
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(hourlyForecast, id: \.date) { hour in
                    VStack {
                        Text(hour.date.formattedHour(for: timezone))
                        Image("\(hour.condition)")
                            .resizable()
                            .scaledToFit()
                        Text("\(hour.temperature.value.formatted(.number.precision(.fractionLength(0))))°")
                    }
                }
            }
        }
        .frame(height: 150)
    }
}
