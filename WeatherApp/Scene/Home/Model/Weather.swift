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
    let feelLikeUnit: String
    let humidity: Int
    let humidityUnit: String
    let windSpeed: Double
    let windSpeedUnit: String
    let hourly: [HourlyWeather]
    // TODO: change code by localizable string
    let weatherCondition: String
    let minTemperature: Double
    let minTemperatureUnit: String
    let maxTemperature: Double
    let maxTemperatureUnit: String
    // TODO: convert to Date
    let sunrise: String
    // TODO: convert to Date
    let sunset: String

    // MARK: - Public helper

    // TODO: WARNING !
    // change isDay for sunrise and sunset and calculate if day or night depending on that.
    /// Returns a weather condition icon name from a weather code.
    ///
    /// - Parameters:
    ///   - weatherCode: weather condition code.
    ///   - isDay:
    /// - Returns: an weather icon
    ///
    static func getIconName(_ weatherCode: Int, isDay: Bool) -> String {
        /*
         case clear = 0
         case mostlyClear = 1
         case partlyCloudy = 2
         case cloudy = 3
         case fog = 45
         case freezingFog = 48
         case lightDrizzle = 51
         case drizzle = 53
         case heavyDrizzle = 55
         case lightFreezingDrizzle = 56
         case freezingDrizzle = 57
         case lightRain = 61
         case rain = 63
         case heavyRain = 65
         case lightfreezingRain = 66
         case freezingRain = 67
         case lightSnow = 71
         case snow = 73
         case heavySnow = 75
         case snowGrains = 77
         case lightRainShower = 80
         case rainShower = 81
         case heavyRainShower = 82
         case snowShower = 85
         case heavySnowShower = 86
         case thunderstorm = 95
         case hailstorm = 96
         case heavyHailstorm = 99
         */
        let weatherType = WeatherType(rawValue: weatherCode)
        switch weatherType {
        case .clear, .mostlyClear:
            return isDay ? "sun.max" : "moon"
        case .partlyCloudy:
            return "cloud"
        case .cloudy:
            return isDay ? "cloud.sun" : "cloud.moon"
        case .fog, .freezingFog:
            return "cloud.fog"
        case .lightDrizzle, .drizzle, .heavyDrizzle, .lightFreezingDrizzle, .freezingDrizzle, .lightRainShower, .rainShower, .heavyRainShower:
            return isDay ? "cloud.sun.rain" : "cloud.moon.rain"
        case .lightRain, .lightfreezingRain, .freezingRain:
            return isDay ? "cloud.sun.rain" : "cloud.moon.rain"
        case .rain, .heavyRain:
            return "cloud.heavyrain"
        case .lightSnow, .snow, .snowShower, .heavySnowShower:
            return "cloud.snow.fill"
        case .heavySnow, .snowGrains:
            return "snowflake"
        case .thunderstorm:
            return isDay ? "cloud.sun.bolt" : "cloud.moon.bolt"
        case .hailstorm, .heavyHailstorm:
            return "cloud.hail"
        default:
            return "cloud.rainbow.half"
        }
    }
    
    /// Returns a localized weather condition from a weather code.
    ///
    /// - Parameter weatherCode: weather condition code.
    /// - Returns: a localized weather condition.
    ///
    /// >https://www.timeanddate.com/weather/glossary.html
    /// >https://www.learn-japanese-adventure.com/japanese-weather.html
    ///
    static func getCondition(_ weatherCode: Int) -> String {
        let weatherType = WeatherType(rawValue: weatherCode)
        switch weatherType {
        case .clear: return NSLocalizedString("weather-confition-clear", comment: "Clear")
        case .mostlyClear: return NSLocalizedString("weather-confition-mostly-clear", comment: "Mostly Clear")
        case .partlyCloudy: return NSLocalizedString("weather-confition-partly-cloudy", comment: "Partly Cloudy")
        case .cloudy: return NSLocalizedString("weather-confition-cloudy", comment: "Cloudy")
        case .fog: return NSLocalizedString("weather-confition-fog", comment: "Fog")
        case .freezingFog: return NSLocalizedString("weather-confition-freezing-fog", comment: "Freezing Fog")
        case .lightDrizzle: return NSLocalizedString("weather-confition-light-drizzle", comment: "Light Drizzle")
        case .drizzle: return NSLocalizedString("weather-confition-drizzle", comment: "Drizzle")
        case .heavyDrizzle: return NSLocalizedString("weather-confition-heavy-drizzle", comment: "Heavy Drizzle")
        case .lightFreezingDrizzle: return NSLocalizedString("weather-confition-light-freezing-drizzle", comment: "Light Freezing Drizzle")
        case .freezingDrizzle: return NSLocalizedString("weather-confition-freezing-drizzle", comment: "Freezing Drizzle")
        case .lightRain: return NSLocalizedString("weather-confition-light-rain", comment: "Light Rain")
        case .rain: return NSLocalizedString("weather-confition-rain", comment: "Rain")
        case .heavyRain: return NSLocalizedString("weather-confition-heavy-rain", comment: "Heavy Rain")
        case .lightfreezingRain: return NSLocalizedString("weather-confition-light-freezing-rain", comment: "Light Freezing Rain")
        case .freezingRain: return NSLocalizedString("weather-confition-freezing-rain", comment: "Freezing Rain")
        case .lightSnow: return NSLocalizedString("weather-confition-light-snow", comment: "Light Snow")
        case .snow: return NSLocalizedString("weather-confition-snow", comment: "Snow")
        case .heavySnow: return NSLocalizedString("weather-confition-heavy-snow", comment: "Heavy Snow")
        case .snowGrains: return NSLocalizedString("weather-confition-snow-grains", comment: "Snow Grains")
        case .lightRainShower: return NSLocalizedString("weather-confition-light-rain-shower", comment: "Light Rain Shower")
        case .rainShower: return NSLocalizedString("weather-confition-rain-shower", comment: "Rain Shower")
        case .heavyRainShower: return NSLocalizedString("weather-confition-heavy-rain-shower", comment: "Heavy Rain Shower")
        case .snowShower: return NSLocalizedString("weather-confition-show-shower", comment: "Snow Shower")
        case .heavySnowShower: return NSLocalizedString("weather-confition-heavy-snow-shower", comment: "Heavy Snow Shower")
        case .thunderstorm: return NSLocalizedString("weather-confition-thunderstorm", comment: "Thunderstorm")
        case .hailstorm: return NSLocalizedString("weather-confition-hailstorm", comment: "Hailstorm")
        case .heavyHailstorm: return NSLocalizedString("weather-confition-heavy-hailstorm", comment: "Heavy Hailstorm")
        default: return NSLocalizedString("weather-condition-default", comment: "")
        }
    }
}

struct HourlyWeather: Identifiable {
    let id = UUID()
    // TODO: convert to Date
    let time: String
    // TODO: change code by localizable string
    let weatherIcon: String
    let temperature: Double
    let temperatureUnit: String
}
