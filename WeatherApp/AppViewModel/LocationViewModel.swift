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
class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let manager: CLLocationManager
    private let apiService: ApiServiceProtocol
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

    @Published var isAutorized: Bool = false

    // MARK: - Init

    override init() {
        self.manager = CLLocationManager()
        self.manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        self.apiService = ApiService()
        super.init()
        self.manager.delegate = self
    }

    // MARK: - CLLocation delegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locations = locations.last else {
            return
        }
        let coordinate = Coordinate(latitude: locations.coordinate.latitude,
                                    longitude: locations.coordinate.longitude)
        print("Coords: \(coordinate.latitude), \(coordinate.longitude)")
        continuation?.resume(returning: coordinate)
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("VM Error: something went wrong on getting location", error)

        // TODO: 


        continuation?.resume(throwing: error)
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            isAutorized = true
            // If authorization status has changed to authorized
            // start updating location
            // TODO: WARINING ! It is triggering didUpdateLocation() each 5 seconds.
//            manager.startUpdatingLocation()
        } else {
            isAutorized = false
        }
    }

    // MARK: - Public methods

    /// Request Authorization to access the User Location
    ///
    func checkAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            return
        }
    }

    /*
    /// <#Description#>
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

    /// <#Description#>
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
     */
}
