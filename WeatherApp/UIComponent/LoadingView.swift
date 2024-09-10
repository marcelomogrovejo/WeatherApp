//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

struct LoadingView: View {

    var isLoadingMessage: Bool = true
    var message: String?

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))

            if isLoadingMessage {
                Text(message ?? "Loading...")
                    .font(.footnote)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView(isLoadingMessage: false)
}
