//
//  CurrentWeatherCell.swift
//  WeatherApp
//
//  Created by AlexKotov on 17.02.22.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
    
    var currentWeather: Weather? {
        didSet {
            weatherDescriptionLabel.text = currentWeather?.weatherType.first?.description
            let temperature = currentWeather?.temperature
            temperatureLabel.text = temperature?.toString()?.temperature
            let feelsLikeTemperature = currentWeather?.feelsLikeTemp
            feelsLikeTemperatureLabel.text = feelsLikeTemperature?.toString()?.feelsLikeTemperature
        }
    }
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "wind")?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor.red
        return imageView
    }()
    
    var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(64)
        return label
    }()
    
    var feelsLikeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        return label
    }()
                                                                                 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStacks()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CurrentWeatherCell {
    
    func setupStacks() {
        let weatherTypeStack = UIStackView()
        weatherTypeStack.axis = .horizontal
        weatherTypeStack.spacing = 4
        weatherTypeStack.alignment = .center
        weatherTypeStack.distribution = .equalSpacing
        weatherTypeStack.addArrangedSubview(weatherImageView)
        weatherTypeStack.addArrangedSubview(weatherDescriptionLabel)
        
        let currentWeatherStack = UIStackView()
        currentWeatherStack.axis = .vertical
        currentWeatherStack.spacing = 4
        currentWeatherStack.alignment = .center
        currentWeatherStack.distribution = .fillProportionally
        currentWeatherStack.addArrangedSubview(weatherTypeStack)
        currentWeatherStack.addArrangedSubview(temperatureLabel)
        currentWeatherStack.addArrangedSubview(feelsLikeTemperatureLabel)
        currentWeatherStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currentWeatherStack)
        NSLayoutConstraint.activate([
            currentWeatherStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currentWeatherStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currentWeatherStack.heightAnchor.constraint(equalToConstant: 150),
            currentWeatherStack.widthAnchor.constraint(equalToConstant: 300)
        ])

    }
}
