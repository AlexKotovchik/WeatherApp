//
//  NetworkError.swift
//  WeatherApp
//
//  Created by AlexKotov on 14.01.22.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case notFound
    case badJSON
}
