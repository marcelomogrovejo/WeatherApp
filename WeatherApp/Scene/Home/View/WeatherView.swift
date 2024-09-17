//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

struct WeatherView: View {

    var weather: Weather
    var locationData: LocationData?

    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(locationData?.cityName ?? "Somewhere")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.Text.mainColor)

                    // TODO: Localize !
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                        .foregroundStyle(Color.Text.mainColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack {
                    HStack {
                        VStack(alignment: .center) {
                            Image(systemName: weather.iconName ?? "cloud.rainbow.half")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .font(.largeTitle)
                                .frame(width: 100, height: 100)
                                .foregroundStyle(Color.Text.mainColor)

                            Text(weather.weatherCondition)
                                .foregroundStyle(Color.Text.mainColor)
                                .fontWeight(.bold)
                        }

                        Spacer()

                        HStack(alignment: .lastTextBaseline, spacing: 0) {
                            Text(weather.feelLikeTemp.roundDouble())
                                .font(.system(size: 90))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.Text.mainColor)

                            Text(weather.feelLikeUnit)
                                .font(.system(size: 30))
                                .foregroundStyle(Color.Text.mainColor)
                        }
                        .padding()
                    }
                    .padding(.vertical)

                    WeatherHourlyView(hourlyWeathers: weather.hourly)
                        .frame(height: 140)
                        .cornerRadius(20, corners: [.allCorners])

                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 20) {
                    // TODO: Localize !
                    Text("Weather now")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.Text.secondaryColor)
                        .padding(.vertical, 3)

                    HStack {
                        // TODO: Localize !
                        WeatherRow(iconName: "thermometer",
                                   name: "Min temp",
                                   value: weather.minTemperature,
                                   unit: weather.minTemperatureUnit)

                        Spacer()

                        // TODO: Localize !
                        WeatherRow(iconName: "thermometer",
                                   name: "Max temp",
                                   value: weather.maxTemperature,
                                   unit: weather.maxTemperatureUnit)
                    }

                    HStack {
                        // TODO: Localize !
                        WeatherRow(iconName: "wind",
                                   name: "Wind speed",
                                   value: weather.windSpeed,
                                   unit: weather.windSpeedUnit)

                        Spacer()

                        // TODO: Localize !
                        WeatherRow(iconName: "humidity",
                                   name: "Humidity",
                                   value: Double(weather.humidity),
                                   unit: weather.humidityUnit)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .background(Color.Background.secondaryColor)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.Background.defaultColor)
    }
}

#Preview {
    var dummyHourlyWeathers: [HourlyWeather] = []
    for i in 0...23 {
        let number = String(format: "%02d", i)
        dummyHourlyWeathers.append(HourlyWeather(time: "2024-09-14T\(number):00", 
                                                 weatherIcon: "cloud.rainbow.half",
                                                 temperature: Double.random(in: -4...33),
                                                 temperatureUnit: "°C"))
    }
    let dummyWeather = Weather(city: "Nedlands",
                               iconName: "cloud.rainbow.half",
                               feelLikeTemp: 24.9,
                               feelLikeUnit: "°C",
                               humidity: 5,
                               humidityUnit: "%",
                               windSpeed: 4.5,
                               windSpeedUnit: "km/h",
                               hourly: dummyHourlyWeathers,
                               weatherCondition: "Clear",
                               minTemperature: 11.2,
                               minTemperatureUnit: "°C",
                               maxTemperature: 22.3,
                               maxTemperatureUnit: "°C",
                               sunrise: "",
                               sunset: "")
    let dummyLocationData = LocationData(cityName: "Dummy City")
    return WeatherView(weather: dummyWeather, locationData: dummyLocationData)
}
