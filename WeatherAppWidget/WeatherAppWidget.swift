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
    let status: String
    let emoji: String
    let location: String
    let degrees: Int
    let degreesType: DegreesType
}

enum DegreesType: String {
    case celsius = "°C"
    case fahrenheit = "°F"
}

// 2. View
struct WeatherWidgetView: View {

    var entry: WeatherEntry

    var body: some View {
        VStack(alignment: .center) {
            // Show provider info
            Text("\(entry.currentWeather.location)")
                .font(.title)
                .fontWeight(.bold)

            HStack(alignment: .lastTextBaseline) {
                Text("\(entry.currentWeather.degrees)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("\(entry.currentWeather.degreesType.rawValue)")
                    .font(.title2)
            }
            .border(Color.black)

            Text("\(entry.currentWeather.emoji) \(entry.currentWeather.status)")
                .font(.footnote)
                .fontWeight(.bold)
        }
        .border(Color.black)
        /// Source: https://swiftsenpai.com/development/widget-container-background/
        .containerBackground(for: .widget) {
            Color.green
        }
    }
}

// 3. Timeline Provider
struct WeatherTimelineProvider: TimelineProvider {
    typealias Entry = WeatherEntry

    // providing dummy data to the system to render a placeholder UI while waiting for the widget to get ready
    func placeholder(in context: Context) -> WeatherEntry {
        let dummyWeather = Weather(status: "Cloudy", emoji: "🌤️", location: "Nedlands", degrees: 18, degreesType: .celsius)
        return WeatherEntry(date: .now, currentWeather: dummyWeather)
    }

    // provides the data required by the system to render the widget in the widget gallery
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        let dummyWeather = Weather(status: "Sunny", emoji: "☀️", location: "Hong Kong", degrees: 19, degreesType: .celsius)
        let snapshotEntry = WeatherEntry(date: .now, currentWeather: dummyWeather)
        completion(snapshotEntry)
    }

    // provides an array of timeline entries for the current time and, optionally, any future times to update a widget
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        let weather = Weather(status: "Mostly Cloudy", emoji: "☁️", location: "Adelaide", degrees: 15, degreesType: .celsius)
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
