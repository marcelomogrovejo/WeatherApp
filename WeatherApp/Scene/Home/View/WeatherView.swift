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
                            // TODO: https://openweathermap.org/weather-conditions
                            ImageView(imageUrl: weather.iconUrl ?? "")
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

                    ImageView(imageUrl: weather.imageUrl)
                        .frame(width: 350)
                        .cornerRadius(20, corners: .allCorners)

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
                        WeatherRow(logo: "thermometer",
                                   name: "Min temp",
                                   value: weather.minTemperature.roundDouble() + "°")

                        Spacer()

                        WeatherRow(logo: "thermometer",
                                   name: "Max temp",
                                   value: weather.maxTemperature.roundDouble() + "°")
                    }

                    HStack {
                        WeatherRow(logo: "wind",
                                   name: "Wind speed", 
                                   value: weather.windSpeed.roundDouble() + "m/s")

                        Spacer()

                        WeatherRow(logo: "humidity",
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
    let fakeWeather = Weather(city: "Nedlands",
                              weather: "Clear",
                              iconUrl: "https://openweathermap.org/img/wn/10d@2x.png",
                              feelLikeTemp: 24.9,
                              imageUrl: "https://www.nicheliving.com.au/wp-content/uploads/2021/11/nedlands-blog-hero-img.jpg",
                              minTemperature: 11.2,
                              maxTemperature: 22.3,
                              windSpeed: 4.5,
                              humidity: 5)
    return WeatherView(weather: fakeWeather)
}
