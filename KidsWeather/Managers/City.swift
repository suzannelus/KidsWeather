//
//  City.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 10/06/2024.
//

import Foundation
import CoreLocation

struct City: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var cLlocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
