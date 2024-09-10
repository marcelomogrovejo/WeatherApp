//
//  ImageView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 10/09/2024.
//

import SwiftUI

struct ImageView: View {

    var imageUrl: String

    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .failure:
                Image(systemName: "questionmark")
                    .font(.largeTitle)
            case .success(let image):
                image
                    .resizable()
            default:
                LoadingView(isLoadingMessage: false)
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    let fakeImageUrl = "https://openweathermap.org/img/wn/10d@2x.png"
    return ImageView(imageUrl: fakeImageUrl)
}
