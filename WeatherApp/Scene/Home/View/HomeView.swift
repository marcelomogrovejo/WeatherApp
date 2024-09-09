//
//  HomeView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

struct HomeView: View {

    var locationViewModel = LocationViewModel()
    var weatherViewModel = WeatherViewModel()

    var body: some View {
        VStack {
            
            /*
             1. is a location saved ? => get/update weather and show WeatherView
             
             2. else, show WelcomeView()
             2.1. request location
             2.2. save location
             */
            
            if let coordinates = locationViewModel.coordinate {
                if let weather = weatherViewModel.weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                try await weatherViewModel.getWeather(latitude: coordinates.latitude, longitude: coordinates.longitude)
                            } catch {
                                print("Error getting the weather \(error.localizedDescription)")
                                
                                // TODO: 
                            }
                        }
                }
            } else {
                if locationViewModel.isLoading {
                    LoadingView()
                } else {
                    WelcomeView(locationViewModel: locationViewModel)
                }
            }
        }
        .background(Color.Background.defaultColor)
        .task {
            do {
                try await locationViewModel.getLocationIfExist()
            } catch {
                
            }
        }
    }
}

#Preview {
    HomeView()
}
