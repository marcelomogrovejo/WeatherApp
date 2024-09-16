//
//  Weather.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 08/09/2024.
//

import Foundation
import WeatherRepoPackage

struct Weather {
    // TODO: get it from lat and lon
    let city: String
    let iconName: String?
    let feelLikeTemp: Double
    let humidity: Int
    let windSpeed: Double
    let hourly: [HourlyWeather]
    // TODO: change code by localizable string
    let weather: String
    let minTemperature: Double
    let maxTemperature: Double
    // TODO: convert to Date
    let sunrise: String
    // TODO: convert to Date
    let sunset: String

    // MARK: - Public helper

    static func getIconName(_ weatherCode: Int, isDay: Bool) -> String {
        let weatherType = WeatherType(rawValue: weatherCode)
        switch weatherType {
        case .clear:
            return isDay ? "sun.max" : "moon"
        default:
            return isDay ? "cloud.sun" : "cloud.moon"
        }
    }
    /*
    static func getLocalIcon(_ iconName: String) -> String {
        let icon = IconType(rawValue: iconName)
        switch icon {
        case .clearDay: return "sun.max"
        case .clearNight: return "moon"
        case .fewCloudsDay: return "cloud.sun"
        case .fewCloudsNight: return "cloud.moon"
        case .scatteredCloudsDay: return "smoke"
        case .scatteredCloudsNight: return "smoke"
        case .brokenCloudsDay: return "smoke"
        case .brokenCloudsNight: return "smoke"
        case .showerRainDay: return "cloud.sun.rain"
        case .showerRainNight: return "cloud.moon.rain"
        case .rainDay: return "cloud.heavyrain"
        case .rainNight: return "cloud.heavyrain"
        case .thunderStormDay: return "cloud.sun.bolt"
        case .thunderStormNight: return "cloud.moon.bolt"
        case .snowDay: return "snowflake"
        case .snowNight: return "snowflake"
        case .mistDay: return "cloud.fog"
        case .mistNight: return "cloud.fog"
        case .none:
            return "sun.min"
        }
    }
*/
}

struct HourlyWeather: Identifiable {
    let id = UUID()
    // TODO: convert to Date
    let time: String
    // TODO: change code by localizable string
    let weatherIcon: String
    let temperature: Double
}
