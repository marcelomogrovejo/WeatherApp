//
//  WeatherWidgetView.swift
//  WeatherAppWidgetExtension
//
//  Created by Marcelo Mogrovejo on 03/09/2024.
//

import SwiftUI
import WidgetKit

// 2. View
struct WeatherWidgetView: View {

    var entry: WeatherEntry
//    var config: WeatherConfig

    init(entry: WeatherEntry) {
        self.entry = entry
//        self.config = WeatherConfig.determineConfig(from: entry.currentWeather.condition)
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack(spacing: 4) {
//                Text(config.emojiText)
                Text(entry.currentWeather.icon ?? "rainbow")
                    .font(.title)
//                Text("\(entry.currentWeather.condition.description)")
                Text(entry.currentWeather.weather)
                    .font(.title3)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.6)
//                    .foregroundColor(config.conditionTextColor)
            }

            HStack(alignment: .lastTextBaseline, spacing: 2) {
//                Text("\(entry.currentWeather.degrees)")
                Text("\(entry.currentWeather.feelLikeTemp)")
                    .font(.system(size: 50, weight: .heavy))
//                    .foregroundColor(config.conditionTextColor)
//                Text("\(entry.currentWeather.degreesType?.rawValue ?? "°C")")
//                    .font(.system(size: 20, weight: .bold))
//                    .foregroundColor(config.conditionTextColor)
            }

//            Text(entry.currentWeather.location)
            Text(entry.currentWeather.city)
                .font(.footnote)
                .fontWeight(.bold)
//                .foregroundColor(config.conditionTextColor)
        }
        /// Source: https://swiftsenpai.com/development/widget-container-background/
        .containerBackground(for: .widget) {
//            config.backgroundColor
        }
    }
}

#Preview() {
    let previewWeather = Weather(city: "Preview City",
                                 weather: "Rainbow",
                                 icon: "rainbow",
                                 feelLikeTemp: 32.0,
                                 imageUrl: "",
                                 minTemperature: 21.6,
                                 maxTemperature: 39.9,
                                 windSpeed: 8.5,
                                 humidity: 10)
    let previewWeatherEntry = WeatherEntry(date: .now, currentWeather: previewWeather)
    return VStack {
        WeatherWidgetView(entry: previewWeatherEntry)
//        WeatherWidgetView(entry: WeatherEntry.randomEntry(date: .now))
    }
    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
}

