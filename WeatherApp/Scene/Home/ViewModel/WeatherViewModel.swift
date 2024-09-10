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
            let domainWeather = try await self.apiService.getCurrentWeather(latitude: latitude, longitude: longitude)
            // TODO: Warning !! Change for generic weather images cz it is imposible to have an image from every city world wide
            let imageUrl = "https://a.travel-assets.com/findyours-php/viewfinder/images/res70/499000/499351-western-australia.jpg"
            weather = Weather(city: domainWeather.cityName,
                              weather: domainWeather.weather,
                              feelLikeTemp: domainWeather.feelLike,
                              imageUrl: imageUrl,
                              minTemperature: domainWeather.minTemperature,
                              maxTemperature: domainWeather.maxTemperature,
                              windSpeed: domainWeather.windSpeed,
                              humidity: domainWeather.humidity)
        } catch {
            print("Error: \(error.localizedDescription)")
            
            // TODO:
        }
    }

}
