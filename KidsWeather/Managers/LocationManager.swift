//
//  LocationManager.swift
//  KidsWeather
//
//  Created by Suzanne Lustenhouwer on 08/06/2024.
//
import Foundation
import CoreLocation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var userLocation: CLLocation?
    var currentLocation: City?
    var isAuthorized = false
    

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func startLocationServices() {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            isAuthorized = true
        } else {
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        if let userLocation {
            Task {
                let name = await getLocationName(for: userLocation)
                currentLocation = City(name: name, latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            }
        }
        
    }
    
    func getLocationName(for location: CLLocation) async -> String {
        let name = try? await CLGeocoder().reverseGeocodeLocation(location).first?.locality
        return name ?? ""
    }
    
    func locationManager(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            manager.requestLocation()
        case .notDetermined:
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        case .denied:
            isAuthorized = false
        default:
            startLocationServices()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    
}
