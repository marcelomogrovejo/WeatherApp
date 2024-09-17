//
//  Date+String.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 17/09/2024.
//

import Foundation

extension Date {

    var stringyfiedHour: String {
        getStringyfiedJustHour()
    }

    private func getJustHour() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: self)
        return calendar.date(from: components)!
    }
    
    private func getStringyfiedJustHour() -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "HH"
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])

        return dateFormatter.string(from: self)
    }

}
