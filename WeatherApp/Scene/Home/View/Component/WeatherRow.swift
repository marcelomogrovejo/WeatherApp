//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color.Background.defaultColor)
                .cornerRadius(50)

            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                    .foregroundStyle(Color.Text.secondaryColor)

                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.Text.secondaryColor)
            }
        }
    }
}

#Preview {
    WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
}
