//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 08/09/2024.
//

import Foundation
import WeatherRepoPackage

@Observable
class WeatherViewModel {

    let apiService: ApiService
    var weather: Weather?

    init() {
        self.apiService = ApiService()
    }

    func getWeather(latitude: Double, longitude: Double) async throws {
        do {
            let domainWeather = try await self.apiService.getCurrentWeatherV2(latitude: latitude, longitude: longitude)
            weather = Weather(iconName: Weather.getIconName(domainWeather.weatherCode, isDay: domainWeather.isDay),
                              feelLikeTemp: domainWeather.feelLike,
                              feelLikeUnit: domainWeather.feelLikeUnit,
                              humidity: domainWeather.humidity,
                              humidityUnit: domainWeather.humidityUnit,
                              windSpeed: domainWeather.windSpeed,
                              windSpeedUnit: domainWeather.windSpeedUnit,
                              hourly: self.combineHourlyWeather(domainWeather),
                              weatherCondition: Weather.getCondition(domainWeather.weatherCode),
                              minTemperature: domainWeather.minTemperature,
                              minTemperatureUnit: domainWeather.minTemperatureUnit,
                              maxTemperature: domainWeather.maxTemperature,
                              maxTemperatureUnit: domainWeather.maxTemperatureUnit,
                              sunrise: domainWeather.sunrise,
                              sunset: domainWeather.sunset)
        } catch {
            print("Error: \(error.localizedDescription)")

            // TODO:
        }
    }

    /// <#Description#>
    /// - Parameters:
    ///   - latitude: <#latitude description#>
    ///   - longitude: <#longitude description#>
    /// - Returns: <#description#>
    func getHourlyWeather(latitude: Double?, longitude: Double?) async throws -> [HourlyWeather] {
        var hourlyWeathers: [HourlyWeather] = []

        if let weather = self.weather, !weather.hourly.isEmpty {
            hourlyWeathers = weather.hourly
        } else {
            do {
                guard let latitude = latitude, let longitude = longitude else {
                    return []
                }
                try await getWeather(latitude: latitude, longitude: longitude)
                hourlyWeathers = weather?.hourly ?? []
            } catch {
                // TODO:
            }
        }
        return hourlyWeathers
    }

    /// <#Description#>
    /// - Parameters:
    ///   - latitude: <#latitude description#>
    ///   - longitude: <#longitude description#>
    /// - Returns: <#description#>
    func getHourlyWeatherOnGo(currentTime: Date, latitude: Double?, longitude: Double?) async throws -> [HourlyWeather] {
        var hourlyWeathers: [HourlyWeather] = []

        if let weather = self.weather, !weather.hourly.isEmpty {
            hourlyWeathers = weather.hourly
        } else {
            do {
                guard let latitude = latitude, let longitude = longitude else {
                    return []
                }
                try await getWeather(latitude: latitude, longitude: longitude)
                var index = 0
                hourlyWeathers = weather?.hourly.filter { hour in
                    let timeDate = hour.time.stringyfiedDate
                    print("\(index). \(timeDate) >= \(currentTime)")
                    index += 1
                    return timeDate >= currentTime
                } ?? []
                hourlyWeathers = weather?.hourly ?? []
            } catch {
                // TODO:
            }
        }
        return hourlyWeathers
    }

    /// <#Description#>
    /// - Parameter domainWeather: <#domainWeather description#>
    /// - Returns: <#description#>
    private func combineHourlyWeather(_ domainWeather: DomainWeatherV2) -> [HourlyWeather] {
        let combinedHourlyWeathers = domainWeather.hourlyWeatherTimes.enumerated().map { (index, time) in
            let weatherConditionName = Weather.getCondition(domainWeather.hourlyWeatherCodes[index])
            // TODO: WARNING ! isDay !!
            let weatherConditionIconName = Weather.getIconName(domainWeather.hourlyWeatherCodes[index], isDay: true)
            return HourlyWeather(time: time,
                                 weatherCondition: weatherConditionName,
                                 weatherIcon: weatherConditionIconName,
                                 temperature: domainWeather.hourlyWeatherTemperatures[index],
                                 temperatureUnit: domainWeather.hourlyWeatherTemperatureUnit)
        }
        return combinedHourlyWeathers
    }
}
