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
            let date = Date(timeIntervalSince1970: dailyWeather?.date ?? 0)
            let currentDate = Date()
            if currentDate.toString(format: DateFormat.day) == date.toString(format: DateFormat.day) {
                dateLabel.text = "Today"
            } else {
                dateLabel.text = date.toString(format: DateFormat.day)
            }
            
            windLabel.text = dailyWeather?.windSpeed.toString()?.windSpeed
            humidityLabel.text = dailyWeather?.humidity.toString()?.humidity
            let dayTemp = dailyWeather?.temperature.day.toString()?.temperature ?? ""
            let nightTemp = dailyWeather?.temperature.night.toString()?.temperature ?? ""
            temperatureLabel.text = "\(dayTemp)/\(nightTemp)"
        }
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var windLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var windImageView: UIImageView = {
        let image = UIImage(named: "wind")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var weatherImageView: UIImageView = {
        let image = UIImage(named: "wind")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStack()
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
        dayStack.backgroundColor = .green
        
        let temperatureStack = UIStackView()
        temperatureStack.axis = .vertical
        temperatureStack.alignment = .leading
        temperatureStack.distribution = .fill
        temperatureStack.addArrangedSubview(temperatureLabel)
        temperatureStack.backgroundColor = .red
        
        let windStack = UIStackView()
        windStack.axis = .vertical
//        windStack.spacing = 4
        windStack.alignment = .center
        windStack.distribution = .fill
        windStack.addArrangedSubview(windImageView)
        windStack.addArrangedSubview(windLabel)
        windStack.backgroundColor = .yellow
        
        let humidityStack = UIStackView()
        humidityStack.axis = .vertical
//        humidityStack.spacing = 4
        humidityStack.alignment = .center
        humidityStack.distribution = .fill
        humidityStack.addArrangedSubview(weatherImageView)
        humidityStack.addArrangedSubview(humidityLabel)
        humidityStack.backgroundColor = .blue

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
