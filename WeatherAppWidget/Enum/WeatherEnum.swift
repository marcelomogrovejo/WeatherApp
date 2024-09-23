//
//  WeatherEnum.swift
//  WeatherAppWidgetExtension
//
//  Created by Marcelo Mogrovejo on 31/08/2024.
//


// TODO: DEPRECATE ?!?

import Foundation

enum DegreesType: String {
    case celsius = "°C"
    case fahrenheit = "°F"
}

enum WeatherCondition: Int, CaseIterable {
    case sunny
    case cloudy
    case rainy
    case windy
    case snowy
    case foggy
    case stormy
    case hot
    case cold
    case humid

    var description: String {
        get {
            switch(self) {
            case .sunny: NSLocalizedString("weather-confition-sunny", comment: "Sunny")
            case .cloudy: NSLocalizedString("weather-confition-cloudy", comment: "Cloudy")
            case .rainy: NSLocalizedString("weather-confition-rainy", comment: "Rainy")
            case .windy: NSLocalizedString("weather-confition-windy", comment: "Windy")
            case .snowy: NSLocalizedString("weather-confition-snowy", comment: "Snowy")
            case .foggy: NSLocalizedString("weather-confition-foggy", comment: "Foggy")
            case .stormy: NSLocalizedString("weather-confition-stormy", comment: "Stormy")
            case .hot: NSLocalizedString("weather-confition-hot", comment: "Hot")
            case .cold: NSLocalizedString("weather-confition-cold", comment: "Cold")
            case .humid: NSLocalizedString("weather-confition-humid", comment: "Humid")
            }
        }
    }

    static func randomCondition() -> WeatherCondition? {
        let totalConditions = WeatherCondition.allCases.count
        let randomConditionIdx = Int.random(in: 0..<totalConditions)
        return WeatherCondition(rawValue: randomConditionIdx)
    }
}
