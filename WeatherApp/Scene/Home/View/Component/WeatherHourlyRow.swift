//
//  WeatherHourlyRow.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 15/09/2024.
//

import SwiftUI

struct WeatherHourlyRow: View {

    @State private var fontSize: CGFloat = 14
    @State private var fontColor: Color = Color.Text.mainColor

    var hour: String
    var iconName: String
    var temperature: Double
    var temperatureUnit: String

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(hour)
                .font(.footnote)
                .padding(.bottom, 8)
                .foregroundStyle(Color.Text.mainColor)

            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.Text.mainColor)

            TemperatureView(fontSize: $fontSize, 
                            fontColor: $fontColor,
                            temperature: temperature,
                            unit: temperatureUnit)
                .padding(.top, 8)
        }
        .padding(20)
    }
}

#Preview {
    WeatherHourlyRow(hour: "Now",
                     iconName: "cloud.rainbow.half",
                     temperature: 23.4,
                     temperatureUnit: "°C")
    .background(Color.Background.defaultColor)
}
