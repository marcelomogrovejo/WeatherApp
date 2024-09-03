//
//  ContentView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 31/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "ic-app-logo")!)
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            Text("🚧 Under construction 🚧")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
