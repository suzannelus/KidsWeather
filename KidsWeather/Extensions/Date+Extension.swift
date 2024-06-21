//
//  Date+Extension.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 12/06/2024.
//

import SwiftUI
import Foundation

extension Date {
    func localDate(for timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = timezone
        
        return dateFormatter.string(from: self)
    }
    
    func localTime(for timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = timezone
        
        return dateFormatter.string(from: self)
    }
    
    func formattedHour(for timezone: TimeZone) -> String {
            var calendar = Calendar.current
            calendar.timeZone = timezone
            let hour = calendar.component(.hour, from: self)
            let hour12 = hour % 12
            return hour12 == 0 ? "12" : "\(hour12)"
        }
    
}

   
