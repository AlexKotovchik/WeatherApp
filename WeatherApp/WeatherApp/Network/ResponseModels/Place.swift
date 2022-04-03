//
//  PlaceResponse.swift
//  WeatherApp
//
//  Created by AlexKotov on 13.03.22.
//

import Foundation
import UIKit

struct City: Decodable {
    let name: String
    let country: Country
    let adminDivision1: State
    let coordinates: Coordinates
    let localizedName: String?
}

struct Country: Decodable {
    let name: String
}

struct State: Decodable {
    let name: String
}

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
}
