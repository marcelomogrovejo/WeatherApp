//
//  TemperatureView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 16/09/2024.
//

import SwiftUI

struct TemperatureView: View {

    @Binding var fontSize: CGFloat
    @Binding var fontColor: Color
    private let fontSizeMultiplier: CGFloat = 1.4

    var temperature: Double
    var unit: String

    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 3) {
            Text(temperature.roundDouble())
                .font(.system(size: fontSize * fontSizeMultiplier))
                .fontWeight(.bold)

            Text(unit)
                .font(.system(size: fontSize))
        }
        .foregroundStyle(fontColor)
    }
}

#Preview {
    TemperatureView(fontSize: .constant(14), 
                    fontColor: .constant(Color.Text.mainColor),
                    temperature: 33.4,
                    unit: "°C")
        .background(Color.Background.defaultColor)
}
