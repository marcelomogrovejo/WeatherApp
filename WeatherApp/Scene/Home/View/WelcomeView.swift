//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {

    var locationViewModel: LocationViewModel?

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the WeatherApp")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Please share your location to get the weather on your area.")
                    .padding()

                LocationButton(.shareCurrentLocation) {
                    locationViewModel?.requestLocation()
                }
                .cornerRadius(20)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
            .multilineTextAlignment(.center)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
