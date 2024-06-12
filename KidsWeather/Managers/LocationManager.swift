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
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                // Location services are already authorized
                isAuthorized = true
                manager.startUpdatingLocation()
            case .notDetermined:
                // Request authorization to use location services when the app is in use
                manager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                // Location services are not authorized
                isAuthorized = false
            default:
                // Fallback case for other states
                isAuthorized = false
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                // Start updating location when authorized
                isAuthorized = true
                manager.startUpdatingLocation()
            } else if status == .notDetermined {
                // Request authorization if not determined
                manager.requestWhenInUseAuthorization()
            } else {
                // Handle denied or restricted cases
                isAuthorized = false
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
    
    func getTimezone(for location: CLLocation) async -> TimeZone {
        let timezone = try? await CLGeocoder().reverseGeocodeLocation(location).first?.timeZone
        return timezone ?? .current
        
    }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
    }
