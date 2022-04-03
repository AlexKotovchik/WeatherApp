//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by AlexKotov on 18.02.22.
//

import Foundation
import CoreLocation
import UIKit

enum ViewState {
    case loading
    case loaded
    case locationAccessDenied
}

class WeatherViewModel: NSObject {
    
    var weatherResponse: Observable<WeatherResponse?> = Observable(nil)
    var viewState: Observable<ViewState> = Observable(.loading)
    let networkService: NetworkService = NetworkService()
//    let locationService: LocationManager = LocationManager()
    let locationManager = CLLocationManager()
    
    var onRequestFailed: (() -> Void)?
    var onLocationDenied: (() -> Void)?
    
    var currentLocation: String = ""
    var currentCoordinates: CLLocationCoordinate2D?
    var currentCity: City? {
        willSet {
            guard let city = newValue else {
                return
            }
            let currentCoordinates = CLLocationCoordinate2D(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude)
            getWeatherResponse(coordinates: currentCoordinates)
            self.currentCoordinates = currentCoordinates
            currentLocation = city.name
        }
    }
    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        checkLocationAccess()
//        locationManager.requestWhenInUseAuthorization()
////        locationService.manager.delegate = self
////        locationService.manager.requestWhenInUseAuthorization()
//    }
    
    init(onLocationDenied: (() -> Void)? = nil) {
        super.init()
        self.onLocationDenied = onLocationDenied
        locationManager.delegate = self
        checkLocationAccess()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getWeatherResponse(coordinates: CLLocationCoordinate2D) {
        viewState.value = .loading
        networkService.getCurrentLocationWeather(latitude: coordinates.latitude, longitude: coordinates.longitude) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.viewState.value = .loaded
                switch result {
                case let .success(weatherResponse):
                    self.weatherResponse.value = weatherResponse
                case let .failure(error):
                    print(error)
                    self.onRequestFailed?()
                }
            }
        }
    }
    
    func presentSearchVC(_ vc: UIViewController) {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        searchVC.modalPresentationStyle = .fullScreen
        vc.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func checkLocationAccess() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            viewState.value = .locationAccessDenied
            onLocationDenied?()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            ()
        }
    }
    
}

extension WeatherViewModel: CLLocationManagerDelegate {
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .notDetermined:
//            manager.requestWhenInUseAuthorization()
//        case .denied, .restricted:
//            onLocationDenied?()
//        case .authorizedAlways, .authorizedWhenInUse:
//            manager.startUpdatingLocation()
//        @unknown default:
//            ()
//        }
//    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        manager.stopUpdatingLocation()
        getWeatherResponse(coordinates: location.coordinate)
        currentCoordinates = location.coordinate
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { places, error in
            guard let place = places?.first?.locality else { return }
            self.currentLocation = place
        }
    }
}

extension WeatherViewModel: SearchViewControllerDelegate {
    func setCurrentCity(_ city: City) {
        self.currentCity = city
    }
    
}
