//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

struct WelcomeView: View {

    @EnvironmentObject var locationViewModel: LocationViewModel

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the WeatherApp")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Please share your location to get the weather on your area.")
                    .padding()

                MainButton(title: "Share my location", iconName: "location.fill") {
                    locationViewModel.checkAuthorization()
                }
            }
            .multilineTextAlignment(.center)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Background.defaultColor)
    }
}


#Preview {
    WelcomeView()
}
