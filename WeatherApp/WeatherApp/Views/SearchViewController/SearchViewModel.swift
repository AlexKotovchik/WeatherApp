//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by AlexKotov on 13.03.22.
//

import Foundation

class SearchViewModel: NSObject {
    var places: Observable<[Place]> = Observable([])
    var cities: Observable<[City]> = Observable([])

    let networkService: NetworkService = .init()
    
    func getCities(name: String) {
        networkService.getPlaces(city: name) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(places):
                    self.places.value = places
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func getCities(cityPrefix: String) {
        networkService.getCities(cityPrefix: cityPrefix){ [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(cities):
                    self.cities.value = cities
                case let .failure(error):
                    print(error)
                }
                print(result)
            }
        }
    }
}
