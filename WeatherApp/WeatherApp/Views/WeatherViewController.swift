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

extension WeatherViewController {
    func setupViews() {
        createWeatherTable()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .lightGray
    }
    
    func createWeatherTable() {
        view.addSubview(weatherTableView)
        weatherTableView.dataSource = self
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
        
        weatherTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

}

