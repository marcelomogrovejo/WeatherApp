//
//  WeatherConfig.swift
//  WeatherAppWidgetExtension
//
//  Created by Marcelo Mogrovejo on 31/08/2024.
//

import SwiftUI

struct WeatherConfig {
    let backgroundColor: Color
    let emojiText: String
    let locationTextColor: Color
    let conditionTextColor: Color

    /// Fetches a weather configuration depending on the weather condition
    ///
    /// - Parameter weatherCondition: current weather condition.
    /// - Returns: configuration.
    ///
    static func determineConfig(from weatherCondition: WeatherCondition) -> WeatherConfig {
        switch weatherCondition {
        case .sunny:
            WeatherConfig(backgroundColor: .gray,
                          emojiText: "☀️",
                          locationTextColor: .black.opacity(0.6),
                          conditionTextColor: .white.opacity(0.8))
        case .cloudy:
            WeatherConfig(backgroundColor: .palePink,
                          emojiText: "⛅️",
                          locationTextColor: .black.opacity(0.5),
                          conditionTextColor: .pink.opacity(0.8))
        case .rainy:
            WeatherConfig(backgroundColor: .paleGreen,
                          emojiText: "☔️",
                          locationTextColor: .black.opacity(0.7),
                          conditionTextColor: .darkGreen.opacity(0.8))
        case .windy:
            WeatherConfig(backgroundColor: .paleBlue,
                          emojiText: "💨",
                          locationTextColor: .black.opacity(0.5),
                          conditionTextColor: .purple.opacity(0.8))
        case .snowy:
            WeatherConfig(backgroundColor: .paleYellow,
                          emojiText: "❄️",
                          locationTextColor: .black.opacity(0.5),
                          conditionTextColor: .pink.opacity(0.7))
        case .foggy:
            WeatherConfig(backgroundColor: .skyBlue,
                          emojiText: "🌫️",
                          locationTextColor: .black.opacity(0.5),
                          conditionTextColor: .paleYellow.opacity(0.8))
        case .stormy:
            WeatherConfig(backgroundColor: .blue,
                          emojiText: "⛈️",
                          locationTextColor: .black.opacity(0.5),
                          conditionTextColor: .paleBlue.opacity(0.8))
        case .hot:
            WeatherConfig(backgroundColor: .paleOrange,
                          emojiText: "🔥",
                          locationTextColor: .black.opacity(0.5),
                          conditionTextColor: .darkOrange.opacity(0.8))
        case .cold:
            WeatherConfig(backgroundColor: .paleRed,
                          emojiText: "🥶",
                          locationTextColor: .black.opacity(0.5),
                          conditionTextColor: .paleYellow.opacity(0.9))
        case .humid:
            WeatherConfig(backgroundColor: .black,
                          emojiText: "🥵",
                          locationTextColor: .white.opacity(0.6),
                          conditionTextColor: .orange.opacity(0.8))
        }

        /*
    case 11:
            return MonthConfig(backgroundColor: .paleBrown,
                               emojiText: "🦃",
                               weekdayTextColor: .black.opacity(0.6),
                               dayTextColor: .black.opacity(0.6))
        case 12:
            return MonthConfig(backgroundColor: .paleRed,
                               emojiText: "🎄",
                               weekdayTextColor: .white.opacity(0.9),
                               dayTextColor: .darkGreen.opacity(0.7))
        default:
            return MonthConfig(backgroundColor: .gray,
                               emojiText: "🗓️",
                               weekdayTextColor: .black.opacity(0.6),
                               dayTextColor: .white.opacity(0.8))
        }
         */
    }
}
