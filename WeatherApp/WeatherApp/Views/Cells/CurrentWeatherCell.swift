//
//  CurrentWeatherCell.swift
//  WeatherApp
//
//  Created by AlexKotov on 17.02.22.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
    
    var weatherTypeStack = UIStackView()
    var weatherImageView = UIImageView()
    var weatherDescriptionLabel = UILabel()
    var temperatureLabel = UILabel()
    var feelsLikeTemperatureLabel = UILabel()
    var currentWeatherStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
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
    func setupCell() {
        setupWeatherTypeStack()
        setupTemperatureLabel()
        setupFeelsLikeTemperatureLabel()
        setupCurrentWeatherStack()
    }
    
    func setupWeatherTypeStack() {
        let weatherImage = UIImage(named: "wind")
        weatherImageView.image = weatherImage
        weatherImageView.contentMode = .scaleAspectFill
        
        weatherDescriptionLabel.text = "overcast clouds"
        weatherDescriptionLabel.textAlignment = .center
        
        weatherTypeStack.axis = .horizontal
        weatherTypeStack.spacing = 4
        weatherTypeStack.alignment = .center
        weatherTypeStack.distribution = .equalSpacing
        weatherTypeStack.addArrangedSubview(weatherImageView)
        weatherTypeStack.addArrangedSubview(weatherDescriptionLabel)
    }
    
    func setupTemperatureLabel() {
        temperatureLabel.text = "5°C"
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = temperatureLabel.font.withSize(64)
    }
    
    func setupFeelsLikeTemperatureLabel() {
        feelsLikeTemperatureLabel.text = "Feels like 4°C"
        feelsLikeTemperatureLabel.textAlignment = .center
        feelsLikeTemperatureLabel.font = feelsLikeTemperatureLabel.font.withSize(12)
    }
    
    func setupCurrentWeatherStack() {
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
