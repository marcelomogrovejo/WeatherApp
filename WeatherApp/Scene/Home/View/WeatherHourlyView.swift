//
//  WeatherHourlyView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 15/09/2024.
//

import SwiftUI

struct WeatherHourlyView: View {

    var hourlyWeathers: [HourlyWeather]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(hourlyWeathers) { hourlyWeather in
                    WeatherHourlyRow(hour: hourlyWeather.time,
                                     iconName: hourlyWeather.weatherIcon,
                                     temperature: hourlyWeather.temperature)
                }
            }
        }
        .background(Color.Background.defaultColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    var dummyHourlyWeathers: [HourlyWeather] = []
    for i in 1...24 {
        let number = String(format: "%02d", i)
        dummyHourlyWeathers.append(HourlyWeather(time: "2024-09-14T\(number):00",
                                                 weatherIcon: "...",
                                                 temperature: Double.random(in: -4...33)))
    }
    return WeatherHourlyView(hourlyWeathers: dummyHourlyWeathers)
}
