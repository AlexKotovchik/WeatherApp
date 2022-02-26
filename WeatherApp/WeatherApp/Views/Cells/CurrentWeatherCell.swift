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
            guard let currentWeather = currentWeather else { return }
            weatherDescriptionLabel.text = currentWeather.weatherType.first?.description
            let temperature = currentWeather.temperature
            temperatureLabel.text = temperature.toString()?.temperature
            let feelsLikeTemperature = currentWeather.feelsLikeTemp
            feelsLikeTemperatureLabel.text = feelsLikeTemperature.toString()?.feelsLikeTemperature
            weatherImageView.configure(imageName: currentWeather.weatherType.first?.main ?? "Default", color: .white2)
            weatherImageView.contentMode = .scaleAspectFill
        }
    }
    
    var weatherImageView: UIImageView = UIImageView()
    
    var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.textColor = .white1
        return label
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(96)
        label.textColor = .white1
        return label
    }()
    
    var feelsLikeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.textColor = .white2
        return label
    }()
                                                                                 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStacks()
        self.backgroundColor = .clear
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
        weatherTypeStack.spacing = 0
        weatherTypeStack.alignment = .center
        weatherTypeStack.distribution = .fillProportionally
        weatherTypeStack.addArrangedSubview(weatherImageView)
        weatherTypeStack.addArrangedSubview(weatherDescriptionLabel)
        
        let currentWeatherStack = UIStackView()
        currentWeatherStack.axis = .vertical
        currentWeatherStack.spacing = 16
        currentWeatherStack.alignment = .center
        currentWeatherStack.distribution = .fillProportionally
        
        currentWeatherStack.addArrangedSubview(temperatureLabel)
        currentWeatherStack.addArrangedSubview(feelsLikeTemperatureLabel)
        currentWeatherStack.addArrangedSubview(weatherTypeStack)

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
