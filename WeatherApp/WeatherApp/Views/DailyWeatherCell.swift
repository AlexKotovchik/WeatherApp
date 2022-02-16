//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by AlexKotov on 12.02.22.
//

import Foundation
import UIKit

class DailyWeatherCell: UITableViewCell {
    let dateLabel = UILabel()
    let windStack = UIStackView()
    let windLabel = UILabel()
    let humidityStack = UIStackView()
    let humidityLabel = UILabel()
    let temperatureStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension DailyWeatherCell {
    func setupCell() {
        
    }
}
