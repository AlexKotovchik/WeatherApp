//
//  PlaceResponse.swift
//  WeatherApp
//
//  Created by AlexKotov on 13.03.22.
//

import Foundation
import UIKit

struct Place: Decodable {
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case latitude = "lat"
        case longitude = "lon"
        case country = "country"
        case state = "state"
    }
    
//    init(from decoder: Decoder) throws {
//        var container = try decoder.unkeyedContainer()
//        name = try container.decode(String.self)
//        latitude = try container.decode(Double.self)
//        longitude = try container.decode(Double.self)
//        country = try container.decode(String.self)
//        state = try container.decode(String.self)
//    }
}

struct CityResponse: Decodable {
    let data: [City]
}

struct City: Decodable {
    let name: String
    let country: Country
    let adminDivision1: State
    let coordinates: Coordinates
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
