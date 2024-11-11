//
//  LocationManager.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 08/11/24.
//

import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? {
        didSet {
            NotificationCenter.default.post(name: .locationUpdated, object: nil)
        }
    }

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
    }

    func getDistance(to location: CLLocation) -> CLLocationDistance? {
        guard let currentLocation = currentLocation else { return nil }
        return currentLocation.distance(from: location)
    }
}

extension Notification.Name {
    static let locationUpdated = Notification.Name("locationUpdated")
}
