//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import Foundation
import CoreLocation

/// Source: https://www.createwithswift.com/using-the-locationbutton-in-swiftui-for-one-time-location-access/
///
@Observable
class LocationViewModel: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()
    var isLoading: Bool = false
    var coordinate: Coordinate? = nil

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locations = locations.first else {
            isLoading = false
            return
        }
        coordinate = Coordinate(latitude: locations.coordinate.latitude,
                                longitude: locations.coordinate.longitude)
        isLoading = false
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        isLoading = false
        print("Error getting location", error)
        
        // TODO: 
    }

}
