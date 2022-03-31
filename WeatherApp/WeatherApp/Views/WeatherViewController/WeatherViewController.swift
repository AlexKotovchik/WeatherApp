//
//  ViewController.swift
//  WeatherApp
//
//  Created by AlexKotov on 12.01.22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    var viewModel = WeatherViewModel {
        self.showLocationDeniedAlert()
    }
    
    var weatherTableView: UITableView = .init(frame: .zero, style: .plain)
    var spinnerView: UIView?
    var locationLabel: UILabel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        subscribe()
        weatherTableView.tableHeaderView = UIView()
        viewModel.onLocationDenied = {
            self.showLocationDeniedAlert()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigation()
    }
    
}

// MARK: - UI
extension WeatherViewController {
    func setupViews() {
        createWeatherTable()
        createLocationLabel()
        configureNavigation()
        showActivityIndicator()
        
        view.backgroundColor = .white
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.tintColor = .white1
        navigationController?.navigationBar.prefersLargeTitles = false        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"), style: .plain, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    @objc func refresh() {
//        viewModel.locationManager.startUpdatingLocation()
        viewModel.checkLocationAccess()
    }
    
    @objc func search() {
        viewModel.presentSearchVC(self)
    }
    
    func setGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        let currentdate = Date().timeIntervalSince1970
        guard let sunrise = viewModel.weatherResponse.value?.currentWeather.sunrise else { return }
        guard let sunset = viewModel.weatherResponse.value?.currentWeather.sunset else { return }
        if currentdate > sunrise && currentdate < sunset {
            gradient.colors = [UIColor.dayBottomColor, UIColor.dayTopColor]
        } else {
            gradient.colors = [UIColor.nightTopColor, UIColor.nightBottomColor]
        }
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func createLocationLabel() {
        locationLabel.textAlignment = .center
        locationLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        locationLabel.textColor = .white1
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            locationLabel.bottomAnchor.constraint(equalTo: weatherTableView.topAnchor, constant: -8)
        ])

    }
    
    func createWeatherTable() {
        view.addSubview(weatherTableView)
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            weatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
        
        weatherTableView.showsVerticalScrollIndicator = false
        weatherTableView.backgroundColor = .clear
        weatherTableView.separatorColor = .white2
        weatherTableView.separatorInset = UIEdgeInsets.zero
        weatherTableView.allowsSelection = false
        
        weatherTableView.register(DailyWeatherCell.self, forCellReuseIdentifier: "DailyWeatherCell")
        weatherTableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: "CurrentWeatherCell")
        weatherTableView.register(HourlyWeatherCell.self, forCellReuseIdentifier: "HourlyWeatherCell")
    }
    
    func showActivityIndicator() {
        let spinnerView = UIView()
        spinnerView.backgroundColor = .black.withAlphaComponent(0.5)
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
     
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        spinnerView.addSubview(spinner)
        view.addSubview(spinnerView)
        
        NSLayoutConstraint.activate([
            spinnerView.topAnchor.constraint(equalTo: view.topAnchor),
            spinnerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spinnerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            spinnerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            spinner.topAnchor.constraint(equalTo: spinnerView.topAnchor),
            spinner.trailingAnchor.constraint(equalTo: spinnerView.trailingAnchor),
            spinner.bottomAnchor.constraint(equalTo: spinnerView.bottomAnchor),
            spinner.leadingAnchor.constraint(equalTo: spinnerView.leadingAnchor),
        ])
        
        self.spinnerView = spinnerView
    }
    
    func setLocationlableText() {
        let imageAttachment = NSTextAttachment()
        let image = UIImage(named: "Location")?.withRenderingMode(.alwaysTemplate)
        imageAttachment.image = image
        imageAttachment.image?.withTintColor(.white1)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let labeltext = NSMutableAttributedString(string: "")
        let locationtext = NSAttributedString(string: viewModel.currentLocation)
        labeltext.append(attachmentString)
        labeltext.append(locationtext)
        locationLabel.attributedText = labeltext
    }
    
    func showLocationDeniedAlert() {
        let alert = UIAlertController(title: "Location", message: "The app have no access to locations", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }

                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    }
        }))
        alert.addAction(UIAlertAction(title: "Cancell", style: .cancel))
        present(alert, animated: true)
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
            return 120
        case 2:
            return 60
        default:
            return 100
        }
    }
}

// MARK: - Observing

extension WeatherViewController {
    func subscribe() {
        viewModel.weatherResponse.observe(on: self) { [weak self] _ in
            self?.weatherTableView.reloadData()
            self?.setGradient()
        }
        
        viewModel.viewState.observe(on: self) { [weak self] state in
            switch state {
            case .loading:
                self?.spinnerView?.isHidden = false
                self?.navigationController?.navigationBar.isHidden = true
            case .loaded:
                self?.spinnerView?.isHidden = true
                self?.setLocationlableText()
                self?.navigationController?.navigationBar.isHidden = false
            }
        }
    }

}

