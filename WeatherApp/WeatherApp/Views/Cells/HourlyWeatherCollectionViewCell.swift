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
            let time = hourlyWeather?.date ?? 0
            let date = Date(timeIntervalSince1970: time)
            let currentDate = Date()
            if currentDate.toString(format: DateFormat.hours) == date.toString(format: DateFormat.hours) {
                dateLabel.text = "Now"
            } else {
                dateLabel.text = date.toString(format: DateFormat.hours)
            }
            
            let temperature = hourlyWeather?.temperature
            temperatureLabel.text = temperature?.toString()?.temperature
        }
    }
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textAlignment = .center
        return label
    }()
    
    var weatherImageView: UIImageView = {
        let image = UIImage(named: "wind")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
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
