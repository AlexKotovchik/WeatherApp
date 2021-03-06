//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by AlexKotov on 18.02.22.
//

import UIKit

class HourlyWeatherCell: UITableViewCell {
    
    var hourlyWeather: [Weather]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: "HourlyWeatherCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension HourlyWeatherCell {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4)
        ])
        collectionView.backgroundColor = .clear
    }
}

extension HourlyWeatherCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCollectionViewCell", for: indexPath) as! HourlyWeatherCollectionViewCell
        cell.hourlyWeather = hourlyWeather?[indexPath.row]
        return cell
    }
}

extension HourlyWeatherCell: UICollectionViewDelegate {
    
}
