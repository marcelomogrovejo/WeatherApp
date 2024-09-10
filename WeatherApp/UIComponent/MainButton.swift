//
//  MainButton.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 10/09/2024.
//

import SwiftUI

struct MainButton: View {

    var title: String
    var iconName: String
    var action: () -> Void

    var body: some View {
        Button(title, systemImage: iconName, action: action)
            .padding()
            .tint(.Button.backgroundColor)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 20))
    }
}

#Preview {
    MainButton(title: "Main button", iconName: "lightbulb.fill", action: {})
}
