//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import Foundation
import CoreLocation
import WeatherRepoPackage

/// Source: https://www.createwithswift.com/using-the-locationbutton-in-swiftui-for-one-time-location-access/
///
@Observable
class LocationViewModel: NSObject, CLLocationManagerDelegate {

    private let manager: CLLocationManager
    private let apiService: ApiServiceProtocol

    var isLoading: Bool = false
    var coordinate: Coordinate? = nil
//    var isCurrentLocation: Bool = false

    override init() {
        self.manager = CLLocationManager()
        self.apiService = ApiService()
        super.init()
        self.manager.delegate = self
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
        print("UI Error: something went wrong on getting location", error)
        
        // TODO: 
    }

    func getLocationIfExist() async throws {
        do {
            let savedLocation = try await apiService.getCurrentLocation()
            coordinate = Coordinate(latitude: savedLocation.latitude,
                                    longitude: savedLocation.longitude)
        } catch {
            print("UI Error: something went wrong on checking location", error)
        }
    }

    func saveLocation() async throws {
//        isLoading = true

        guard let coordinate = coordinate else {
            // TODO: UIError here ??
            return
        }
        do {
            try await apiService.saveCurrentLocation(latitude: coordinate.latitude,
                                                     longitude: coordinate.longitude)
//            isLoading = false
        } catch {
            print("UI Error: unable to save the current location", error)
//            isLoading = false
        }

    }
}
