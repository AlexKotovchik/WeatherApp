//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexKotov on 12.01.22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    var viewModel = WeatherViewModel()
    
    var weatherTableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        subscribe()
    }
    
}

// MARK: - UI
extension WeatherViewController {
    func setupViews() {
        createWeatherTable()
        navigationController?.isNavigationBarHidden = true
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        let topColor = UIColor(hexString: "#B1B1B1").cgColor
        let bottomColor = UIColor(hexString: "#62B4FF").cgColor
        gradient.colors = [topColor, bottomColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
//        view.backgroundColor = .lightGray
    }
    
    func createWeatherTable() {
        view.addSubview(weatherTableView)
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])
        
        weatherTableView.backgroundColor = .clear
        weatherTableView.separatorColor = .white2
        weatherTableView.separatorInset = UIEdgeInsets.zero
        
        weatherTableView.register(DailyWeatherCell.self, forCellReuseIdentifier: "DailyWeatherCell")
        weatherTableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: "CurrentWeatherCell")
        weatherTableView.register(HourlyWeatherCell.self, forCellReuseIdentifier: "HourlyWeatherCell")
    }
}

// MARK: - TableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 7
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherCell", for: indexPath) as! CurrentWeatherCell
            cell.currentWeather = viewModel.weatherResponse.value?.currentWeather
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyWeatherCell", for: indexPath) as! HourlyWeatherCell
            cell.hourlyWeather = viewModel.weatherResponse.value?.hourlyWeather
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as! DailyWeatherCell
            cell.dailyWeather = viewModel.weatherResponse.value?.dailyWeather[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }

}

// MARK: - TableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        case 1:
            return 100
        case 2:
            return 60
        default:
            return 100
        }
    }
}

// MARK: - Methods

extension WeatherViewController {
    func subscribe() {
        viewModel.weatherResponse.observe(on: self) { [weak self] _ in
            self?.weatherTableView.reloadData()
        }
    }
}

