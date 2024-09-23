//
//  String+Date.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 23/09/2024.
//

import Foundation

extension String {

    var stringyfiedDate: Date {
        getStringyfiedDate()
    }

    private func getStringyfiedDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
//        "2024-09-23T00:00"
        let date = dateFormatter.date(from: self)!
        return date
    }
}
