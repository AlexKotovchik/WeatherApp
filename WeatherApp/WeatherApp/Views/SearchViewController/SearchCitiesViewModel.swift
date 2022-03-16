//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by AlexKotov on 13.03.22.
//

import Foundation

class SearchCitiesViewModel: NSObject {
    var cities: Observable<[City]> = Observable([])

    let networkService: NetworkService = .init()
    
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
            }
        }
    }
}
