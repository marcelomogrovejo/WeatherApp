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
    var config: WeatherConfig

    init(entry: WeatherEntry) {
        self.entry = entry
        self.config = WeatherConfig.determineConfig(from: entry.currentWeather.condition)
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack(spacing: 4) {
                Text(config.emojiText)
                    .font(.title)
                Text("\(entry.currentWeather.condition.description)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(config.conditionTextColor)
            }

            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text("\(entry.currentWeather.degrees)")
                    .font(.system(size: 50, weight: .heavy))
                    .foregroundColor(config.conditionTextColor)
                Text("\(entry.currentWeather.degreesType?.rawValue ?? "°C")")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(config.conditionTextColor)
            }

            Text(entry.currentWeather.location)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(config.conditionTextColor)
        }
        /// Source: https://swiftsenpai.com/development/widget-container-background/
        .containerBackground(for: .widget) {
            config.backgroundColor
        }
    }
}

#Preview() {
    VStack {
        WeatherWidgetView(entry: WeatherEntry.randomEntry(date: .now))
    }
    .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
}

