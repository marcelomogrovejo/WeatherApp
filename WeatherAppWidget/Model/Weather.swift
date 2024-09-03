//
//  Weather.swift
//  WeatherAppWidgetExtension
//
//  Created by Marcelo Mogrovejo on 03/09/2024.
//

import Foundation

struct Weather {
    let condition: WeatherCondition
    let location: String
    let degrees: Int
    let degreesType: DegreesType?

    init(condition: WeatherCondition, location: String, degrees: Int, degreesType: DegreesType? = .celsius) {
        self.condition = condition
        self.location = location
        self.degrees = degrees
        self.degreesType = degreesType
    }
}
