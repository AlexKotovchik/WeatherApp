//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by AlexKotov on 13.03.22.
//

import UIKit

protocol SearchViewControllerDelegate {
    func setCurrentCity(_ city: City)
}

class SearchViewController: UIViewController {
    
    var searchController: UISearchController?
    
    var city: City? {
        willSet {
            guard let city = newValue else { return }
            delegate?.setCurrentCity(city)
            navigationController?.popViewController(animated: true)
        }
    }
    
    var delegate: SearchViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white1
        self.title = "Cities"
        setupViews()
    }

}

extension SearchViewController {
    func setupViews() {
        configureNavigation()
        configureSearchController()
    }
    
    @objc func tap() {
        guard let city = city else { return }
        delegate?.setCurrentCity(city)
        navigationController?.popViewController(animated: true)
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureSearchController() {
        let resultController = SearchCitiesTableView()
        resultController.delegate = self
        searchController = UISearchController(searchResultsController: resultController)
        searchController?.searchResultsUpdater = resultController
        searchController?.searchBar.sizeToFit()
        searchController?.searchBar.placeholder = "Search for city"
        searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension SearchViewController: SearchCitiesTableViewDelegate {
    func setNewCity(_ city: City) {
        self.city = city
    }

}

