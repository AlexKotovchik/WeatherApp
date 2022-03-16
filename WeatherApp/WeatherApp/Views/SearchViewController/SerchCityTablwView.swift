//
//  SerchCityTablwView.swift
//  WeatherApp
//
//  Created by AlexKotov on 16.03.22.
//

import Foundation
import UIKit

protocol SearchCitiesTableViewDelegate {
    func setNewCity(_ city: City)
}

class SearchCitiesTableView: UITableViewController {
    let viewModel: SearchCitiesViewModel = .init()
    let citiesTableView: UITableView = .init(frame: .zero, style: .plain)
    
    var delegate: SearchCitiesTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white1
        createTableVIew()
        subscribe()
    }
    
    func createTableVIew() {
        view.addSubview(citiesTableView)
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            citiesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            citiesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            citiesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])
        citiesTableView.showsVerticalScrollIndicator = false
        citiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        let city = viewModel.cities.value[indexPath.row]
        configuration.text = city.name
        configuration.secondaryText = "\(city.country.name), \(city.adminDivision1.name)"
        cell.contentConfiguration = configuration
        cell.textLabel?.text = "\(city.name), \(city.country.name), \(city.adminDivision1.name)"
        cell.detailTextLabel?.text = city.country.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap")
        let city = viewModel.cities.value[indexPath.row]
        delegate?.setNewCity(city)
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func subscribe() {
        viewModel.cities.observe(on: self) { [weak self] _ in
            guard let self = self else { return }
            self.citiesTableView.reloadData()
        }
    }
    
}

extension SearchCitiesTableView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.getCities(cityPrefix: text)
    }

}
