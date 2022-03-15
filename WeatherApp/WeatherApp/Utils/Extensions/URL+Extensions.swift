//
//  URL+Extensions.swift
//  WeatherApp
//
//  Created by AlexKotov on 14.01.22.
//

import Foundation
extension URL {
    static func url(with path: String,
                    endpoint: Endpoint,
                    queryParams: JSONDict) -> URL? {
        guard let url = URL(string: path)?.appendingPathComponent(endpoint.rawValue),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil}
        urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0, value: "\($1)")}
        debugPrint(urlComponents.url)
        return urlComponents.url
    }
}
