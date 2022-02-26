//
//  HourlyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by AlexKotov on 18.02.22.
//

import UIKit


class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    var hourlyWeather: Weather? {
        didSet {
            guard let hourlyWeather = hourlyWeather else { return }
            let time = hourlyWeather.date
            let date = Date(timeIntervalSince1970: time)
            let currentDate = Date()
            if currentDate.toString(format: DateFormat.hours) == date.toString(format: DateFormat.hours) {
                dateLabel.text = "Now"
            } else {
                dateLabel.text = date.toString(format: DateFormat.hours)
            }
            let temperature = hourlyWeather.temperature
            temperatureLabel.text = temperature.toString()?.temperature
            weatherImageView.configure(imageName: hourlyWeather.weatherType.first?.main ?? "Default", color: .white1)
        }
    }
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white1
        return label
    }()
    
    var weatherImageView: UIImageView = UIImageView()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HourlyWeatherCollectionViewCell {
    func setupViews() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(weatherImageView)
        stack.addArrangedSubview(temperatureLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
