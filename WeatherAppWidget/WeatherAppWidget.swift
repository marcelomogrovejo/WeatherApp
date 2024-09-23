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
    var currentLocation: String
    var currentWeather: HourlyWeather
    var index: Int
}

// 3. Timeline Provider
struct WeatherTimelineProvider: TimelineProvider {

    typealias Entry = WeatherEntry

    var locationViewModel: LocationViewModel?
    var weatherViewModel: WeatherViewModel?

    init(locationViewModel: LocationViewModel = LocationViewModel(),
         weatherViewModel: WeatherViewModel = WeatherViewModel()) {
        self.locationViewModel = locationViewModel
        self.weatherViewModel = weatherViewModel
    }

    // providing dummy data to the system to render a placeholder UI while waiting for the widget to get ready
    func placeholder(in context: Context) -> WeatherEntry {
        let placeholderHourlyWeather = HourlyWeather(time: "\(Date.now)",
                                                     weatherCondition: "Clear",
                                                     weatherIcon: "rainbow",
                                                     temperature: 23.4,
                                                     temperatureUnit: "°C")
        return WeatherEntry(date: .now, currentLocation: "Mendoza", currentWeather: placeholderHourlyWeather, index: 0)
    }

    // provides the data required by the system to render the widget in the widget gallery
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        let snapshotHourlyWeather = HourlyWeather(time: "\(Date.now)",
                                                  weatherCondition: "Clear",
                                                  weatherIcon: "rainbow",
                                                  temperature: 23.4,
                                                  temperatureUnit: "°C")
        let snapshotEntry = WeatherEntry(date: .now, currentLocation: "Hong Kong", currentWeather: snapshotHourlyWeather, index: 0)
        completion(snapshotEntry)
    }

    /// Provides an array of timeline entries for the current time and, optionally, any future times to update a widget
    ///
    /// info> Have to request permission to CLLocationManager as well in info.plist
    /// `<key>NSWidgetWantsLocation</key>`
    /// `<true/>`
    /// `<key>NSLocationUsageDescription</key>`
    /// `<string>Put some text here</string>`
    /// Source: https://forums.developer.apple.com/forums/thread/658686
    ///
    /// info> Have to return the value on a completion handler:
    /// Source: https://augmentedcode.io/2023/03/20/async-await-and-completion-handler-compatibility-in-swift/
    ///
    /// - Parameters:
    ///   - context: timeline provider context
    ///   - completion: a timeline or weather entries
    ///
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        Task {
            do {
                var entries: [WeatherEntry] = []
                let currentDate: Date = .now
                var index: Int = 0

                let coordinte = try await locationViewModel?.coordinate
                let currentCity = try await locationViewModel?.locationData?.cityName

                guard let hourlyWeathers = try await weatherViewModel?.getHourlyWeatherOnGo(currentTime: currentDate, latitude: coordinte?.latitude, longitude: coordinte?.longitude) else {
                    // TODO:
                    return
                }

                for hourlyWeather in hourlyWeathers {
                    let entryDate = Calendar.current.date(byAdding: .second, value: index, to: currentDate)!
                    // TODO: Localize
                    entries.append(WeatherEntry(date: entryDate, currentLocation: currentCity ?? "Unknown city", currentWeather: hourlyWeather, index: index))
                    index += 1
                }
                let timeline = Timeline(entries: entries, policy: .atEnd)
                await MainActor.run {
                    completion(timeline)
                }
            } catch {
                await MainActor.run {
                    // TODO:
                }
            }
        }
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
    let dummyHourlyWeather = HourlyWeather(time: "\(Date.now)",
                                           weatherCondition: "Clear",
                                           weatherIcon: "rainbow",
                                           temperature: 23.4,
                                           temperatureUnit: "°C")
    WeatherEntry(date: .now, currentLocation: "Perth", currentWeather: dummyHourlyWeather, index: 0)
}
