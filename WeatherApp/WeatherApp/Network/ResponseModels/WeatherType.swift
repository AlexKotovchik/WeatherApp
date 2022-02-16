//
//  WeatherType.swift
//  WeatherApp
//
//  Created by AlexKotov on 15.01.22.
//

import Foundation

struct WeatherType: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
