//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

struct WelcomeView: View {

    var locationViewModel: LocationViewModel?

    /// Source: Gemini
    /// Source: https://medium.gonzalofuentes.com/obtaining-user-location-with-swift-and-swiftui-a-step-by-step-guide-3987ba401782
    @Binding var coordinate: Coordinate?

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the WeatherApp")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Please share your location to get the weather on your area.")
                    .padding()

                // TODO: Move to UIComponent !
                Button("Share my location", systemImage: "location.fill") {
                    Task {
                        do {
                            coordinate = try await locationViewModel?.coordinate
                        } catch {
                            // TODO: -
                        }
                    }
                }
                .padding()
                .tint(.Button.backgroundColor)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 20))
            }
            .multilineTextAlignment(.center)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    let coordinate = Coordinate(latitude: 1.111, longitude: 2.222)
    return WelcomeView(coordinate: .constant(coordinate))
}
