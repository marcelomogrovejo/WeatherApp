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
    @State var coordinate: Coordinate?

    var body: some View {
        VStack {
            Text("isAuthorized: \(locationViewModel.isAutorized)")

            if let coordinate = coordinate {
                //                LoadingView()
                //                    .task {
                //                        do {
                //                            try await locationViewModel.saveLocation()
                //                        } catch {
                //
                //                        }
                //                    }
                if let weather = weatherViewModel.weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                try await weatherViewModel.getWeather(latitude: coordinate.latitude,
                                                                      longitude: coordinate.longitude)
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
                    WelcomeView(locationViewModel: locationViewModel, 
                                coordinate: $coordinate)
                        .onChange(of: coordinate) { oldValue, newValue in
                            self.coordinate = newValue
                        }
                }
            }
        }
        .background(Color.Background.defaultColor)
        .task {
            locationViewModel.checkAuthorization()
        }
    }
}

#Preview {
    HomeView()
}
