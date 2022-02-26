//
//  UIImage+Extensions.swift
//  WeatherApp
//
//  Created by AlexKotov on 24.02.22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func configure(imageName: String, color: UIColor) {
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        self.image = image
        self.contentMode = .scaleAspectFit
        self.tintColor = color
    }
}
