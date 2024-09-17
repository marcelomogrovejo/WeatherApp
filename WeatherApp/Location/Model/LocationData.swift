//
//  LocationData.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 17/09/2024.
//

import Foundation

struct LocationData {
    let cityName: String?
    let postalCode: String?
    let countryName: String?
    let countryAbreviatedName: String?

    init(cityName: String?,
         postalCode: String? = "",
         countryName: String? = "",
         countryAbreviatedName: String? = "") {
        self.cityName = cityName
        self.postalCode = postalCode
        self.countryName = countryName
        self.countryAbreviatedName = countryAbreviatedName
    }
}
