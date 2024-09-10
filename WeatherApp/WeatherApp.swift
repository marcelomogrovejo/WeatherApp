//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 31/08/2024.
//

import SwiftUI

@main
struct WeatherApp: App {

    @StateObject var locationViewModel = LocationViewModel()

    var body: some Scene {
        WindowGroup {
            if locationViewModel.isAutorized {
                HomeView()
                    .environmentObject(locationViewModel)
            } else {
                WelcomeView()
                    .environmentObject(locationViewModel)
            }
        }
    }
}
