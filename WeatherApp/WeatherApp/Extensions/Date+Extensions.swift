//
//  Date+Extensions.swift
//  WeatherApp
//
//  Created by AlexKotov on 21.02.22.
//

import Foundation

public enum DateFormat: String {
    case hours = "HH"
    case day = "EEEE"
}

extension Date {
    func toString(format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
