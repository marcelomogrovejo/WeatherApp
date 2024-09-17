//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import Foundation
import CoreLocation
import WeatherRepoPackage
import WidgetKit

/// Source: https://www.createwithswift.com/using-the-locationbutton-in-swiftui-for-one-time-location-access/
///
class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let manager: CLLocationManager
    private let apiService: ApiServiceProtocol
    /// source: https://gist.github.com/runys/10a01deb2b7182c674823b2d051ad271
    private var coodsContinuation: CheckedContinuation<Coordinate, Error>?
    private var locContinuation: CheckedContinuation<LocationData, Error>?

    var coordinate: Coordinate? {
        get async throws {
            return try await withCheckedThrowingContinuation { continuation in
                self.coodsContinuation = continuation
                self.manager.requestLocation()
            }
        }
    }
    var locationData: LocationData? {
        get async throws {
            guard let coordinate = try await coordinate else {
                return nil
            }
            return try await getLocationData(coordinates: coordinate)
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
        coodsContinuation?.resume(returning: coordinate)
        coodsContinuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("VM Error: something went wrong on getting location", error)

        // TODO: 


        coodsContinuation?.resume(throwing: error)
        coodsContinuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            isAutorized = true
            // If authorization status has changed to authorized
            // start updating location
            // TODO: WARINING ! It is triggering didUpdateLocation() each 5 seconds.
//            manager.startUpdatingLocation()
            /// Updates the location if the device moves 500 meters or more
//            manager.startMonitoringSignificantLocationChanges()
        } else {
            isAutorized = false
//            manager.stopUpdatingLocation()
//            manager.stopMonitoringSignificantLocationChanges()
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

    /// Fetches locaation information for the given coordinates.
    ///
    /// - Parameter coordinates: the current latitude and longitude
    /// - Returns: location data like locality, postal code, country
    ///
    func getLocationData(coordinates: Coordinate) async throws -> LocationData {
        do {
            let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            let placemarks = try await CLGeocoder().reverseGeocodeLocation(location)
            if !placemarks.isEmpty {
                if let placemark = placemarks.first {
                    return LocationData(cityName: placemark.locality,
                                        postalCode: placemark.postalCode,
                                        countryName: placemark.country,
                                        countryAbreviatedName: placemark.isoCountryCode)
                } else {
                    throw LocationError.locationDataNotFound
                }
            } else {
                throw LocationError.locationDataNotFound
            }
        } catch {
            print("Error Location Manager: \(error.localizedDescription)")
            throw LocationError.errorGettingData
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
