//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by AlexKotov on 15.01.22.
//

import Foundation

struct Weather: Decodable {
    let date: Double
    let sunrise: Double?
    let sunset: Double?
    let temperature: Double
    let feelsLikeTemp: Double
    let pressure: Double
    let humidity: Double
    let dewPoint: Double
    let clouds: Double
    let visibility: Double
    let windSpeed: Double
    let windDegrees: Double
    let weatherType: [WeatherType]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temperature = "temp"
        case feelsLikeTemp = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dewPoint = "dew_point"
        case clouds = "clouds"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case windDegrees = "wind_deg"
        case weatherType = "weather"
    }
}
