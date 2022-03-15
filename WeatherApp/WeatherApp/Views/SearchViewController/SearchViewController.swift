//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by AlexKotov on 13.03.22.
//

import UIKit

class CitiesTable: UITableViewController {
    let citiesTableView: UITableView = .init(frame: .zero, style: .plain)
    
}

class SearchViewController: UIViewController {
    
    let viewModel: SearchViewModel = .init()
    
    let searchController: UISearchController = .init(searchResultsController: nil)
    let citiesTableView: UITableView = .init(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white1
        self.title = "Cities"
        setupViews()
        subscribe()
    }

}

extension SearchViewController {
    func setupViews() {
        configureNavigation()
        configureSearchController()
        createTableVIew()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search for city"
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func createTableVIew() {
        view.addSubview(citiesTableView)
        citiesTableView.dataSource = self
//        citiesTableView.delegate = self
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            citiesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            citiesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            citiesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])
        
        citiesTableView.showsVerticalScrollIndicator = false
//        citiesTableView.backgroundColor = .clear
//        citiesTableView.separatorColor = .white2
//        citiesTableView.separatorInset = UIEdgeInsets.zero
        
        citiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        let city = viewModel.cities.value[indexPath.row]
        configuration.text = city.name
        configuration.secondaryText = "\(city.country.name), \(city.adminDivision1.name)"
        cell.contentConfiguration = configuration
//        cell.textLabel?.text = "\(city.name), \(city.country.name), \(city.adminDivision1.name)"
//        cell.detailTextLabel?.text = city.country.name
        return cell
    }

}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
//        viewModel.getCities(name: text)
        viewModel.getCities(cityPrefix: text)
    }

}

// MARK: - Observing

extension SearchViewController {
    func subscribe() {
        viewModel.cities.observe(on: self) { [weak self] _ in
            guard let self = self else { return }
            self.citiesTableView.reloadData()
        }
    }

}
