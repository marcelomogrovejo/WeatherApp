//
//  WeatherAppWidget.swift
//  WeatherAppWidget
//
//  Created by Marcelo Mogrovejo on 31/08/2024.
//

import WidgetKit
import SwiftUI



/// Source: https://swiftsenpai.com/development/getting-started-widgetkit/



// 1. Entry
struct WeatherEntry: TimelineEntry {
    var date: Date
    var currentWeather: Weather
}

struct Weather {
    let condition: WeatherCondition
    let location: String
    let degrees: Int
    let degreesType: DegreesType?

    init(condition: WeatherCondition, location: String, degrees: Int, degreesType: DegreesType? = .celsius) {
        self.condition = condition
        self.location = location
        self.degrees = degrees
        self.degreesType = degreesType
    }
}

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
                Text("\(entry.currentWeather.condition.rawValue)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(config.conditionTextColor)
            }

            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text("\(entry.currentWeather.degrees)")
                    .font(.system(size: 70, weight: .heavy))
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

// 3. Timeline Provider
struct WeatherTimelineProvider: TimelineProvider {
    typealias Entry = WeatherEntry

    // providing dummy data to the system to render a placeholder UI while waiting for the widget to get ready
    func placeholder(in context: Context) -> WeatherEntry {
        let dummyWeather = Weather(condition: .cloudy, location: "Adelaide", degrees: 18)
        return WeatherEntry(date: .now, currentWeather: dummyWeather)
    }

    // provides the data required by the system to render the widget in the widget gallery
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        let dummyWeather = Weather(condition: .sunny, location: "Perth", degrees: 25)
        let snapshotEntry = WeatherEntry(date: .now, currentWeather: dummyWeather)
        completion(snapshotEntry)
    }

    // provides an array of timeline entries for the current time and, optionally, any future times to update a widget
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        let weather = Weather(condition: .cloudy, location: "Hong Kong", degrees: 15)
        let entry = WeatherEntry(date: .now, currentWeather: weather)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

}

// 4. Configuration
// Using StaticConfiguration means that our widget does not have any user-configurable properties.
// We will need to use IntentConfiguration instead if we would to add any user-configurable properties to our widget.
struct WeatherAppWidget: Widget {
    let kind: String = "WeatherAppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherTimelineProvider()) { entry in
            WeatherWidgetView(entry: entry)
        }
        // Gallery title
        .configurationDisplayName("WeatherApp Widget")
        // Gallery suptitler
        .description("This is a demo widget.")
        .supportedFamilies([.systemSmall])
    }

}

#Preview(as: .systemSmall) {
    WeatherAppWidget()
} timeline: {
    let currentWeather = Weather(condition: .windy, location: "Hong Kong", degrees: 7)
    WeatherEntry(date: .now, currentWeather: currentWeather)
}
