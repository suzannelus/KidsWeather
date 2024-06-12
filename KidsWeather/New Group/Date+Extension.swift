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
}
