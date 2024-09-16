//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

struct WeatherView: View {

    var weather: Weather

    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.city)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.Text.mainColor)

                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                        .foregroundStyle(Color.Text.mainColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack {
                    HStack {
                        VStack(alignment: .center) {
                            Image(systemName: weather.iconName ?? "questionmark")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .font(.largeTitle)
                                .frame(width: 100, height: 100)
                                .foregroundStyle(Color.Text.mainColor)

                            Text(weather.weather)
                                .foregroundStyle(Color.Text.mainColor)
                                .fontWeight(.bold)
                        }

                        Spacer()

                        Text(weather.feelLikeTemp.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.Text.mainColor)
                            .padding()
                    }
                    .padding(.vertical)

                    WeatherHourlyView(hourlyWeathers: weather.hourly)
                        .frame(width: 350, height: 90)
                        .padding(.vertical)

                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.Text.secondaryColor)
                        .padding(.vertical, 3)

                    HStack {
                        WeatherRow(iconName: "thermometer",
                                   name: "Min temp",
                                   value: weather.minTemperature.roundDouble() + "°")

                        Spacer()

                        WeatherRow(iconName: "thermometer",
                                   name: "Max temp",
                                   value: weather.maxTemperature.roundDouble() + "°")
                    }

                    HStack {
                        WeatherRow(iconName: "wind",
                                   name: "Wind speed",
                                   value: weather.windSpeed.roundDouble() + "m/s")

                        Spacer()

                        WeatherRow(iconName: "humidity",
                                   name: "Humidity",
                                   value: "\(weather.humidity)" + "%")
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
                                                 weatherIcon: "",
                                                 temperature: Double.random(in: -4...33)))
    }
    let dummyWeather = Weather(city: "Nedlands",
                               iconName: "cloud.rainbow.half",
                               feelLikeTemp: 24.9,
                               humidity: 5,
                               windSpeed: 4.5,
                               hourly: dummyHourlyWeathers,
                               weather: "Clear",
                               minTemperature: 11.2,
                               maxTemperature: 22.3,
                               sunrise: "",
                               sunset: "")
    return WeatherView(weather: dummyWeather)
}
