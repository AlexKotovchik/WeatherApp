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
        return "Feels like" + self + "°C"
    }
    
    var windSpeed: String {
        return self + "km/h"
    }
    
    var humidity: String {
        return self + "%"
    }
}
