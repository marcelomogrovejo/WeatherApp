//
//  LocationError.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 17/09/2024.
//

import Foundation

enum LocationError: LocalizedError {
    case errorGettingData
    case locationDataNotFound

    var errorDescription: String? {
        switch self {
        case .errorGettingData:
            return NSLocalizedString("error-location-data", comment: "Error Getting Location Data")
        case .locationDataNotFound:
            return NSLocalizedString("error-location-not-found", comment: "Error Location Not Found")
        }
    }
}
