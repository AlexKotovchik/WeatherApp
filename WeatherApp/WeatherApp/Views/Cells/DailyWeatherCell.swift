//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by AlexKotov on 12.02.22.
//

import Foundation
import UIKit

class DailyWeatherCell: UITableViewCell {
    let dailyWeatherStack = UIStackView()
    let dateLabel = UILabel()
    let windStack = UIStackView()
    let windLabel = UILabel()
    let windImageView = UIImageView()
    let humidityStack = UIStackView()
    let humidityLabel = UILabel()
    let weatherUIImage = UIImageView()
    let temperatureStack = UIStackView()
    let temperatureLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DailyWeatherCell {
    func setupCell() {
        setupWindStack()
        setupHumidityStack()
        setupDailyWeatherStack()
    }
    
    func setupWindStack() {
        windLabel.text = "100km/h"
        windLabel.textAlignment = .center

        let windImage = UIImage(named: "wind")
        windImageView.image = windImage
        windImageView.contentMode = .scaleAspectFill

        windStack.axis = .vertical
        windStack.spacing = 4
        windStack.alignment = .center
        windStack.distribution = .equalSpacing
        windStack.addArrangedSubview(windImageView)
        windStack.addArrangedSubview(windLabel)
    }
    
    func setupHumidityStack() {
        humidityLabel.text = "80%"
        humidityLabel.textAlignment = .center

        let weatherImage = UIImage(named: "wind")
        weatherUIImage.image = weatherImage
        weatherUIImage.contentMode = .scaleAspectFill

        humidityStack.axis = .vertical
        humidityStack.spacing = 4
        humidityStack.alignment = .center
        humidityStack.distribution = .equalSpacing
        humidityStack.addArrangedSubview(weatherUIImage)
        humidityStack.addArrangedSubview(humidityLabel)
    }
    
    func setupDailyWeatherStack() {
        dateLabel.text = "Monday"
        dateLabel.textAlignment = .center

        temperatureLabel.text = "5°C/-2°C"
        temperatureLabel.textAlignment = .center

        dailyWeatherStack.axis = .horizontal
        dailyWeatherStack.alignment = .center
        dailyWeatherStack.distribution = .fillProportionally
        dailyWeatherStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dailyWeatherStack)
        [dateLabel,
         humidityStack,
         windStack,
         temperatureLabel].forEach { dailyWeatherStack.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            dailyWeatherStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dailyWeatherStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4),
            dailyWeatherStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4),
            dailyWeatherStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4)
        ])
    }
}
