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

//    init(entry: WeatherEntry) {
//        self.entry = entry
//        self.config = WeatherConfig.determineConfig(from: entry.currentWeather.condition)
//    }

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 3) {

                // TODO: Temp... to see the 23 entries update ref
                Text("\(entry.index)")

                Text(entry.currentLocation)
                    .font(.caption)

                Image(systemName: "location")
//                    .resizable()
//                    .scaledToFit()
            }

            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text("\(entry.currentWeather.temperature)")
                    .font(.system(size: 18, weight: .heavy))

                Text(entry.currentWeather.temperatureUnit)
                    .font(.system(size: 14, weight: .bold))
            }

            Image(systemName: entry.currentWeather.weatherIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
//                    .foregroundStyle(Color.Text.mainColor)

            Text(entry.currentWeather.weatherCondition)
                .font(.footnote)
                .fontWeight(.bold)
                .minimumScaleFactor(0.6)
//                    .foregroundColor(config.conditionTextColor)
        }
        /// Source: https://swiftsenpai.com/development/widget-container-background/
        .containerBackground(for: .widget) {
//            config.backgroundColor
        }
    }
}

#Preview() {
    let previewHourlyWeather = HourlyWeather(time: "\(Date.now)",
                                             weatherCondition: "Clear",
                                             weatherIcon: "rainbow",
                                             temperature: 23.4,
                                             temperatureUnit: "°C")
    let previewWeatherEntry = WeatherEntry(date: .now,
                                           currentLocation: "Thailand",
                                           currentWeather: previewHourlyWeather,
                                           index: 0)
    return VStack {
        WeatherWidgetView(entry: previewWeatherEntry)
//        WeatherWidgetView(entry: WeatherEntry.randomEntry(date: .now))
    }
    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
}

