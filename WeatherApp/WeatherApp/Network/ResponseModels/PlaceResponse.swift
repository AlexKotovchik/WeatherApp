//
//  PlaceResponse.swift
//  WeatherApp
//
//  Created by AlexKotov on 13.03.22.
//

import Foundation

struct PlaceResponse: Decodable {
    let places: [Place]
    
//    init(from decoder: Decoder) throws {
//        var container = try decoder.unkeyedContainer()
//        places = try container.decode([Place].self) // Decode just first element
//    }
}
