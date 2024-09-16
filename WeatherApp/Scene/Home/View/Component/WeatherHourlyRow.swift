//
//  WeatherHourlyRow.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 15/09/2024.
//

import SwiftUI

struct WeatherHourlyRow: View {

    var hour: String
    var iconName: String
    var temperature: Double

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

            Text(temperature.roundDouble())
                .padding(.top, 8)
                .foregroundStyle(Color.Text.mainColor)
        }
        .padding(8)
    }
}

#Preview {
    WeatherHourlyRow(hour: "Now", iconName: "rainbow", temperature: 23.4)
        .background(.red)
}
