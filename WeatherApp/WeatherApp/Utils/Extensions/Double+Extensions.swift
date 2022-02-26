//
//  Double+Extensions.swift
//  WeatherApp
//
//  Created by AlexKotov on 19.02.22.
//

import Foundation

extension Double {
    func toString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let string = String(formatter.string(for: self) ?? "")
        return string
    }
}
