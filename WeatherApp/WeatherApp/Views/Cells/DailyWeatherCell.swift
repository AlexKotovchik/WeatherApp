//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by AlexKotov on 12.02.22.
//

import Foundation
import UIKit

class DailyWeatherCell: UITableViewCell {
    var dailyWeather: DailyWeather? {
        didSet {
            guard let dailyWeather = dailyWeather else { return }
            let date = Date(timeIntervalSince1970: dailyWeather.date)
            let currentDate = Date()
            if currentDate.toString(format: DateFormat.day) == date.toString(format: DateFormat.day) {
                dateLabel.text = "Today"
            } else {
                dateLabel.text = date.toString(format: DateFormat.day)
            }
            windLabel.text = dailyWeather.windSpeed.toString()?.windSpeed
            humidityLabel.text = dailyWeather.humidity.toString()?.humidity
            let dayTemp = dailyWeather.temperature.day.toString()?.temperature ?? ""
            let nightTemp = dailyWeather.temperature.night.toString()?.temperature ?? ""
            temperatureLabel.text = "\(dayTemp) / \(nightTemp)"
            weatherImageView.configure(imageName: dailyWeather.weatherType.first?.main ?? "Default", color: .white2)
            windImageView.configure(imageName: "Wind", color: .white2)
        }
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(16)
        label.textColor = .white2
        return label
    }()
    
    var windLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
//        label.font = label.font.withSize(16)
        label.textColor = .white2
        return label
    }()
    
    var windImageView: UIImageView = UIImageView()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(16)
        label.textColor = .white2
        return label
    }()
    
    var weatherImageView: UIImageView = UIImageView()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(16)
        label.textColor = .white2
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStack()
        self.backgroundColor = .clear
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DailyWeatherCell {
    func setupStack() {
        
        let dayStack = UIStackView()
        dayStack.axis = .vertical
        dayStack.alignment = .leading
        dayStack.distribution = .fill
        dayStack.addArrangedSubview(dateLabel)
        
        let temperatureStack = UIStackView()
        temperatureStack.axis = .vertical
        temperatureStack.alignment = .trailing
        temperatureStack.distribution = .fill
        temperatureStack.addArrangedSubview(temperatureLabel)
        
        let windStack = UIStackView()
        windStack.axis = .vertical
        windStack.alignment = .center
        windStack.distribution = .fillEqually
        windStack.addArrangedSubview(windImageView)
        windStack.addArrangedSubview(windLabel)
        
        let humidityStack = UIStackView()
        humidityStack.axis = .vertical
        humidityStack.alignment = .center
        humidityStack.distribution = .fillEqually
        humidityStack.addArrangedSubview(weatherImageView)
        humidityStack.addArrangedSubview(humidityLabel)

        let dailyWeatherStack = UIStackView()
        dailyWeatherStack.axis = .horizontal
        dailyWeatherStack.alignment = .center
        dailyWeatherStack.distribution = .fillEqually
        dailyWeatherStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dailyWeatherStack)
        [dayStack,
         humidityStack,
         windStack,
         temperatureStack].forEach { dailyWeatherStack.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            dailyWeatherStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dailyWeatherStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dailyWeatherStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4),
            dailyWeatherStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
}
