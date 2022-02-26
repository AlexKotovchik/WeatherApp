//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by AlexKotov on 18.02.22.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject {
    
    var weatherResponse: Observable<WeatherResponse?> = Observable(nil)
    let networkService: NetworkService = NetworkService()
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getWeatherResponse(coordinates: CLLocationCoordinate2D) {
        networkService.getCurrentLocationWeather(latitude: coordinates.latitude, longitude: coordinates.longitude) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(weatherResponse):
                    self.weatherResponse.value = weatherResponse
                    debugPrint(weatherResponse)
                    debugPrint(self.weatherResponse.value)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
}

extension WeatherViewModel: CLLocationManagerDelegate {
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

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        manager.stopUpdatingLocation()
        getWeatherResponse(coordinates: location.coordinate)
    }
}
