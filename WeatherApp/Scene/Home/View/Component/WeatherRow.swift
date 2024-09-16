//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

struct WeatherRow: View {

    @State private var fontSize: CGFloat = 14
    @State private var fontColor: Color = Color.Text.secondaryColor

    var iconName: String
    var name: String
    var value: Double
    var unit: String?

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: iconName)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color.Background.defaultColor)
                .cornerRadius(50)

            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                    .foregroundStyle(Color.Text.secondaryColor)

                TemperatureView(fontSize: $fontSize,
                                fontColor: $fontColor,
                                temperature: value,
                                unit: unit ?? "")

            }
        }
        .onAppear {
            fontSize += 2
        }
    }
}

#Preview {
    WeatherRow(iconName: "thermometer", 
               name: "Feels like",
               value: 8.4,
               unit: "°C")
        .background(.red)
}
