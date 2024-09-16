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
                              // TODO: get the weather from the code
                              weatherIcon: weatherConditionIconName,
                              temperature: domainWeather.hourlyWeatherTemperatures[index])
            }
            weather = Weather(city: "Dummy city", // TODO Now comes from the location manager ??
                              iconName: Weather.getIconName(domainWeather.weatherCode, isDay: domainWeather.isDay),
                              feelLikeTemp: domainWeather.feelLike,
                              humidity: domainWeather.humidity,
                              windSpeed: domainWeather.windSpeed,
                              hourly: combinedHourlyWeathers,
                              // TODO: get the weather from the code
                              weather: "Dummy weather",
                              minTemperature: domainWeather.minTemperature,
                              maxTemperature: domainWeather.maxTemperature,
                              sunrise: domainWeather.sunrise,
                              sunset: domainWeather.sunset)
        } catch {
            print("Error: \(error.localizedDescription)")
            
            // TODO:
        }
    }

}
