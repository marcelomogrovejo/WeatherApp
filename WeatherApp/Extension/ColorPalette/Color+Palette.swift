//
//  Color+Palette.swift
//  WeatherApp
//
//  Created by Marcelo Mogrovejo on 07/09/2024.
//

import SwiftUI

extension Color {

    struct Background {
        static let defaultColor: Color = Color.init("bkg-default", bundle: .main)
        static let secondaryColor: Color = Color.init("bkg-secondary", bundle: .main)
    }

    struct Text {
        static let mainColor: Color = Color.init("txt-main", bundle: .main)
        static let secondaryColor: Color = Color.init("txt-secondary", bundle: .main)
    }

    struct Button {
        static let backgroundColor: Color = Color.init("btn-bkg-main", bundle: .main)
    }

}
