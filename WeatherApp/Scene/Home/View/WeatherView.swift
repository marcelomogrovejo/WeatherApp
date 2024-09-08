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
                        VStack(spacing: 20) {
                            // TODO:
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                                .foregroundStyle(Color.Text.mainColor)

                            Text(weather.weather)
                                .foregroundStyle(Color.Text.mainColor)
                        }
                        .frame(width: 150, alignment: .leading)

                        Spacer()

                        Text(weather.feelLikeTemp.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.Text.mainColor)
                            .padding()
                    }

                    AsyncImage(url: URL(string: weather.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }

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
                        .fontWeight(.bold)
                        .foregroundStyle(Color.Text.secondaryColor)
                        .padding(.bottom)

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
                              feelLikeTemp: 18.9,
                              imageUrl: "https://www.nicheliving.com.au/wp-content/uploads/2021/11/nedlands-blog-hero-img.jpg",
                              minTemperature: 11.2,
                              maxTemperature: 22.3,
                              windSpeed: 4.5,
                              humidity: 5)
    return WeatherView(weather: fakeWeather)
}
