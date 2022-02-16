//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by AlexKotov on 15.01.22.
//

import Foundation

struct WeatherResponse: Decodable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currentWeather: Weather
    let hourlyWeather: [Weather]
    let dailyWeather: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case timezone = "timezone"
        case currentWeather = "current"
        case hourlyWeather = "hourly"
        case dailyWeather = "daily"
    }
}
