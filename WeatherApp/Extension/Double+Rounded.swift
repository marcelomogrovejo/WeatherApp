//
//  Double+Rounded.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 08/09/2024.
//

import Foundation

extension Double {

    /// Rounds to 0 decimal
    ///
    /// - Returns: a rounded double
    func roundDouble() -> String {
        String(format: "%.0f", self)
    }
}
