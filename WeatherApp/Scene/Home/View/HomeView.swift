//
//  HomeView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

struct HomeView: View {
 
    @EnvironmentObject var locationViewModel: LocationViewModel
    var weatherViewModel = WeatherViewModel()

    // TODO: try locationViewMdel.coordinates ?
    @State var coordinate: Coordinate?

    var body: some View {
        VStack {
            if let coordinate = coordinate {
                if let weather = weatherViewModel.weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView(message: "Getting the weather...")
                        .task {
                            do {
                                try await weatherViewModel.getWeather(latitude: coordinate.latitude,
                                                                      longitude: coordinate.longitude)
                            } catch {
                                print("V Error getting the weather \(error.localizedDescription)")
                                
                                // TODO:
                            }
                        }
                }
            } else {
                LoadingView(message: "Getting your location...")
            }
        }
        .background(Color.Background.defaultColor)
        .task {
            do {
                self.coordinate = try await locationViewModel.coordinate
            } catch {
                print("V Error getting location \(error.localizedDescription)")

                // TODO:
            }
        }
    }
}

#Preview {
    HomeView()
}
