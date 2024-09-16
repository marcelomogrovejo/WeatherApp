//
//  WeatherAppWidget.swift
//  WeatherAppWidget
//
//  Created by Marcelo Mogrovejo on 31/08/2024.
//

import WidgetKit
import SwiftUI

/// Sources:
/// * https://swiftsenpai.com/development/getting-started-widgetkit/
/// * https://www.youtube.com/watch?v=jucm6e9M6LA

// 1. Entry
struct WeatherEntry: TimelineEntry {
    var date: Date
    var currentWeather: Weather

    /// Generates a random Weather entry
    ///
    /// At this point that is needed in order to test. When the Weather base app is done, the api call will get the real date.
    /// 
    /// - Parameter date: a date
    /// - Returns: a Weather entry
    ///
//    static func randomEntry(date: Date) -> WeatherEntry {
//        let locations = ["Perth", "Adelaide", "Sydney", "Melbourne", "Hobart", "Cairns", "Darwin", "Camberra", "New Castle", "Mendoza"]
//        let randomLocation = locations[Int.random(in: 0..<locations.count)]
//        let randomDegrees = Int.random(in: -30..<44)
//        guard let randomWeatherCondition = WeatherCondition.randomCondition() else {
//            let dummyWeather = Weather(condition: .cloudy, location: randomLocation, degrees: randomDegrees)
//            return WeatherEntry(date: date, currentWeather: dummyWeather)
//        }
//        let randomWeather = Weather(condition: randomWeatherCondition,
//                                    location: randomLocation,
//                                    degrees: randomDegrees)
//        return WeatherEntry(date: date, currentWeather: randomWeather)
//    }
}

// 3. Timeline Provider
struct WeatherTimelineProvider: TimelineProvider {
    typealias Entry = WeatherEntry

    // providing dummy data to the system to render a placeholder UI while waiting for the widget to get ready
    func placeholder(in context: Context) -> WeatherEntry {
        let dummyWeather = Weather(city: "Placeholder City",
                                   iconName: "sun.max.fill",
                                   feelLikeTemp: 19.4,
                                   humidity: 20,
                                   windSpeed: 6.2,
                                   hourly: [],
                                   weather: "Clear",
                                   minTemperature: 18.0,
                                   maxTemperature: 22.2,
                                   sunrise: "",
                                   sunset: "")
//        Weather(condition: .cloudy, location: "Adelaide", degrees: 18)
        return WeatherEntry(date: .now, currentWeather: dummyWeather)
    }

    // provides the data required by the system to render the widget in the widget gallery
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        let dummyWeather = Weather(city: "Snapshot City",
                                   iconName: "cloud.rain",
                                   feelLikeTemp: 17.6,
                                   humidity: 15,
                                   windSpeed: 2.8,
                                   hourly: [],
                                   weather: "Rainy",
                                   minTemperature: 14.0,
                                   maxTemperature: 20.0,
                                   sunrise: "",
                                   sunset: "")
//        Weather(condition: .sunny, location: "Perth", degrees: 25)
        let snapshotEntry = WeatherEntry(date: .now, currentWeather: dummyWeather)
        completion(snapshotEntry)
    }

    // provides an array of timeline entries for the current time and, optionally, any future times to update a widget
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        var entries: [WeatherEntry] = []
        let currentDate: Date = .now
        for hourOffset in 0..<15 {
            // !!!
            // TODO: Warning !!
            // Change to update by hours instead of minutes
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
//            let entry = WeatherEntry.randomEntry(date: entryDate)
            // TODO: WARNING !
            // Figure out how to get the Weather from the main app
            let temp = Weather(city: "Snapshot City",
                               iconName: "cloud.rain",
                               feelLikeTemp: 17.6,
                               humidity: 15,
                               windSpeed: 2.8,
                               hourly: [],
                               weather: "Rainy",
                               minTemperature: 14.0,
                               maxTemperature: 20.0,
                               sunrise: "",
                               sunset: "")
            let entry = WeatherEntry(date: .now, currentWeather: temp)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
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
    WeatherEntry(date: .now,
                 currentWeather: Weather(city: "Snapshot City",
                                         iconName: "cloud.rain",
                                         feelLikeTemp: 17.6,
                                         humidity: 15,
                                         windSpeed: 2.8,
                                         hourly: [],
                                         weather: "Rainy",
                                         minTemperature: 14.0,
                                         maxTemperature: 20.0,
                                         sunrise: "",
                                         sunset: "")
    )
}
