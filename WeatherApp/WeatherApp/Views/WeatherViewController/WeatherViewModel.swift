//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by AlexKotov on 18.02.22.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    
    var weatherResponse: WeatherResponse?
    let networkService: NetworkService = NetworkService()
    let manager = CLLocationManager()
    
    
    
    init() {
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            ()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            ()
        }
    }
    
    func getWeatherResponse(completion: ((WeatherResponse) -> Void)?) {
        networkService.getCurrentLocationWeather(latitude: 84.0354, longitude: 27.4142) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(weatherResponse):
                    self.weatherResponse = weatherResponse
                    completion?(weatherResponse)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
}

extension WeatherViewModel: CLLocationManagerDelegate {
    
}
