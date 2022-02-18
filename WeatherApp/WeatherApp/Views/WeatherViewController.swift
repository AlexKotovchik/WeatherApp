//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexKotov on 12.01.22.
//

import UIKit

class WeatherViewController: UIViewController {
    var weatherTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
        NetworkService().getCurrentLocationWeather(latitude: 84.0354, longitude: 27.4142) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(weatherResponse):
                    print(weatherResponse.timezone)
                case let .failure(error):
                    print(error)
                }
                
            }
        }
    }
    
}

// MARK: - UI
extension WeatherViewController {
    func setupViews() {
        createWeatherTable()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .lightGray
    }
    
    func createWeatherTable() {
        view.addSubview(weatherTableView)
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8)
        ])
        
        weatherTableView.register(DailyWeatherCell.self, forCellReuseIdentifier: "DailyWeatherCell")
        weatherTableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: "CurrentWeatherCell")
        weatherTableView.register(HourlyWeatherCell.self, forCellReuseIdentifier: "HourlyWeatherCell")
    }
}

// MARK: - TableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyWeatherCell", for: indexPath) as! HourlyWeatherCell
//        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

}

// MARK: - TableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

