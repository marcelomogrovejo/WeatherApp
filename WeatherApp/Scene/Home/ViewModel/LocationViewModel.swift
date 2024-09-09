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

    /// source: https://gist.github.com/runys/10a01deb2b7182c674823b2d051ad271
    private var continuation: CheckedContinuation<Coordinate, Error>?

    var coordinate: Coordinate? {
        get async throws {
            return try await withCheckedThrowingContinuation { continuation in
                self.continuation = continuation
                self.manager.requestLocation()
            }
        }
    }
//    var isCurrentLocation: Bool = false

    var isAutorized: Bool = false

    // MARK: - Init

    override init() {
        self.manager = CLLocationManager()
        self.manager.requestWhenInUseAuthorization()
        self.apiService = ApiService()
        super.init()
        self.manager.delegate = self
    }

    /// Request Authorization to access the User Location
    /// 
    func checkAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            isAutorized = false
            manager.requestWhenInUseAuthorization()
        default:
            isAutorized = true
            return
        }
    }

    // MARK: - CLLocation delegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locations = locations.last else {
//            isLoading = false
            return
        }
        let coordinate = Coordinate(latitude: locations.coordinate.latitude,
                                    longitude: locations.coordinate.longitude)
        continuation?.resume(returning: coordinate)
        continuation = nil
//        isLoading = false
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
//        isLoading = false
        print("UI Error: something went wrong on getting location", error)
        
        // TODO: 
//        coordinate = nil
        
        continuation?.resume(throwing: error)
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            // If authorization status has changed to authorized
            // start updating location
            manager.startUpdatingLocation()
        }
    }

    // MARK: - Public methods

    func getLocationIfExist() async throws {
        do {
            if let savedLocation = try await apiService.getPersistedCurrentLocation() {
                let savedCoordinate = Coordinate(latitude: savedLocation.latitude,
                                                 longitude: savedLocation.longitude)
                continuation?.resume(returning: savedCoordinate)
                continuation = nil
            } else {
                // TODO: continuation throws ??
            }
        } catch {
            print("UI Error: something went wrong on getting location", error)
        }
    }

    func saveLocation() async throws {
//        isLoading = true

        guard let coordinate = try await coordinate else {
//            isLoading = false
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
