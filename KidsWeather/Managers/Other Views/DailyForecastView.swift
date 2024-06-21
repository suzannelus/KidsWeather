//
//  WeeklyColors.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 15/06/2024.
//

import SwiftUI
import WeatherKit

struct WeekDayColors: View {
    
    var condition: WeatherCondition
    @State private var currentWeather: CurrentWeather?
    
    
    var body: some View {
        VStack {
            
          
        }
        
    }
    
}
    struct Monday: View {
        var body: some View {
            RadialGradient(colors: [.teal, .mint, .white], center: .topLeading, startRadius: 400, endRadius: 70)
                .ignoresSafeArea()
        }
    }


#Preview {
    WeekDayColors(condition: .breezy)
}
