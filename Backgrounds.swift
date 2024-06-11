//
//  Backgrounds.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 10/06/2024.
//

import SwiftUI

struct SunnyBackground: View {
    var body: some View {
        RadialGradient(colors: [.teal, .mint, .white], center: .topLeading, startRadius: 400, endRadius: 70)
            .ignoresSafeArea()
    }
}

struct ClearNight: View {
    var body: some View {
      
       
        LinearGradient(colors: [Color.darkGrey, Color.darkBlue], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
    }
}

#Preview {
    SunnyBackground()
}

#Preview {
    ClearNight()
}


extension Color {
    static let darkGrey = Color(red: 31/255, green: 40/255, blue: 54/255, opacity: 1.0)
}

extension Color {
    static let darkBlue = Color(red: 31/255, green: 40/255, blue: 90/255, opacity: 1.0)
}
