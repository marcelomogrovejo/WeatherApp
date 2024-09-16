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
//            let domainWeather = try await self.apiService.getCurrentWeather(latitude: latitude, longitude: longitude)
            let domainWeather = try await self.apiService.getCurrentWeatherV2(latitude: latitude, longitude: longitude)
            let combinedHourlyWeathers = domainWeather.hourlyWeatherTimes.enumerated().map { (index, time) in
                // TODO: WARNING ! isDay !!
                let weatherConditionIconName = Weather.getIconName(domainWeather.hourlyWeatherCodes[index], isDay: true)
                return HourlyWeather(time: time,
                                     weatherIcon: weatherConditionIconName,
                                     temperature: domainWeather.hourlyWeatherTemperatures[index],
                                     temperatureUnit: domainWeather.hourlyWeatherTemperatureUnit)
            }
            weather = Weather(city: "Dummy city", // TODO Now comes from the location manager ??
                              iconName: Weather.getIconName(domainWeather.weatherCode, isDay: domainWeather.isDay),
                              feelLikeTemp: domainWeather.feelLike,
                              feelLikeUnit: domainWeather.feelLikeUnit,
                              humidity: domainWeather.humidity,
                              humidityUnit: domainWeather.humidityUnit,
                              windSpeed: domainWeather.windSpeed,
                              windSpeedUnit: domainWeather.windSpeedUnit,
                              hourly: combinedHourlyWeathers,
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

}
