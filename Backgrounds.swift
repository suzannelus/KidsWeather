//
//  Backgrounds.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 10/06/2024.
//

import SwiftUI
import WeatherKit


struct BackgroundView: View {
    
    var condition: WeatherCondition
    @State private var currentWeather: CurrentWeather?

    
    var body: some View {
        if ((currentWeather?.isDaylight) != nil) {
                   switch condition {
                   case .clear, .mostlyClear, .hot:
                       SunnyBackground()
                   case .partlyCloudy, .mostlyCloudy, .cloudy, .foggy, .haze:
                       CloudyBackground()
                   case .drizzle, .rain, .heavyRain:
                       RainyBackground()
                   case .flurries, .snow, .heavySnow, .sleet, .freezingDrizzle, .freezingRain, .blowingSnow, .blizzard:
                       SnowyBackground()
                   case .hail, .tropicalStorm, .hurricane, .isolatedThunderstorms, .scatteredThunderstorms, .strongStorms, .thunderstorms:
                       StormyBackground()
                   case .windy, .breezy:
                       WindyBackground()
                   case .blowingDust, .smoky:
                       DustyBackground()
                   case .frigid:
                       FrigidBackground()
                   case .sunFlurries, .wintryMix:
                       WintryBackground()
                   case .sunShowers:
                       SunShowersBackground()
                   @unknown default:
                       DefaultBackground()
                   }
               } else {
                   switch condition {
                   case .clear, .mostlyClear, .hot:
                       NightClearBackground()
                   case .partlyCloudy, .mostlyCloudy, .cloudy, .foggy, .haze:
                       NightCloudyBackground()
                   case .drizzle, .rain, .heavyRain:
                       NightRainyBackground()
                   case .flurries, .snow, .heavySnow, .sleet, .freezingDrizzle, .freezingRain, .blowingSnow, .blizzard:
                       NightSnowyBackground()
                   case .hail, .tropicalStorm, .hurricane, .isolatedThunderstorms, .scatteredThunderstorms, .strongStorms, .thunderstorms:
                       NightStormyBackground()
                   case .windy, .breezy:
                       NightWindyBackground()
                   case .blowingDust, .smoky:
                       NightDustyBackground()
                   case .frigid:
                       NightFrigidBackground()
                   case .sunFlurries, .wintryMix:
                       NightWintryBackground()
                   case .sunShowers:
                       NightSunShowersBackground()
                   @unknown default:
                       DefaultBackground()
                   }
               }
           }
       }

#Preview {
    BackgroundView(condition: .cloudy)
}


struct ClearNight: View {
    var body: some View {
      
       
        LinearGradient(colors: [Color.darkGray, Color.darkBlue], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
    }
}

#Preview {
    SunnyBackground()
}

#Preview {
    ClearNight()
}

struct SunnyBackground: View {
    var body: some View {
        RadialGradient(colors: [.teal, .mint, .white], center: .topLeading, startRadius: 400, endRadius: 70)
            .ignoresSafeArea()
    }
}

struct CloudyBackground: View {
    var body: some View {
        LinearGradient(colors: [.gray, .white], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct RainyBackground: View {
    var body: some View {
        LinearGradient(colors: [.blue, .gray], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct SnowyBackground: View {
    var body: some View {
        LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct StormyBackground: View {
    var body: some View {
        LinearGradient(colors: [.darkGray, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct WindyBackground: View {
    var body: some View {
        LinearGradient(colors: [.blue, .gray], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct DustyBackground: View {
    var body: some View {
        LinearGradient(colors: [.brown, .gray], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct FrigidBackground: View {
    var body: some View {
        LinearGradient(colors: [.cyan, .white], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct WintryBackground: View {
    var body: some View {
        LinearGradient(colors: [.white, .gray, .blue], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct SunShowersBackground: View {
    var body: some View {
        LinearGradient(colors: [.yellow, .blue], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct DefaultBackground: View {
    var body: some View {
        Color.gray
            .ignoresSafeArea()
    }
}

// Add the night-time backgrounds here
struct NightClearBackground: View {
    var body: some View {
        RadialGradient(colors: [.black, .blue], center: .center, startRadius: 400, endRadius: 70)
            .ignoresSafeArea()
    }
}

struct NightCloudyBackground: View {
    var body: some View {
        LinearGradient(colors: [.darkGray, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct NightRainyBackground: View {
    var body: some View {
        LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct NightSnowyBackground: View {
    var body: some View {
        LinearGradient(colors: [.gray, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct NightStormyBackground: View {
    var body: some View {
        LinearGradient(colors: [.black, Color.darkGray], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct NightWindyBackground: View {
    var body: some View {
        LinearGradient(colors: [.black, .blue], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct NightDustyBackground: View {
    var body: some View {
        LinearGradient(colors: [.black, .brown], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct NightFrigidBackground: View {
    var body: some View {
        LinearGradient(colors: [.black, .cyan], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct NightWintryBackground: View {
    var body: some View {
        LinearGradient(colors: [.black, .gray, .blue], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct NightSunShowersBackground: View {
    var body: some View {
        LinearGradient(colors: [.black, .yellow], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}
extension Color {
    static let darkGray = Color(red: 31/255, green: 40/255, blue: 54/255, opacity: 1.0)
}

extension Color {
    static let darkBlue = Color(red: 31/255, green: 40/255, blue: 90/255, opacity: 1.0)
}
