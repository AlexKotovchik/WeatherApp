//
//  String+Extensions.swift
//  WeatherApp
//
//  Created by AlexKotov on 19.02.22.
//

import Foundation

extension String {
    var temperature: String {
        return self + "°C"
    }
    
    var feelsLikeTemperature: String {
        return "feels_like_temp_label".localized + " " + self + "°C"
    }
    
    var windSpeed: String {
        return self + "wind_label".localized
    }
    
    var humidity: String {
        return self + "%"
    }
    
    var localized: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }
    
}
