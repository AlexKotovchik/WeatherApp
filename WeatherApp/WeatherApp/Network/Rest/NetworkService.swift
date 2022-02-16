//
//  NetworkService.swift
//  WeatherApp
//
//  Created by AlexKotov on 14.01.22.
//

import Foundation

public typealias JSONDict = [String: Any]

enum Endpoint: String {
    case weather = "weather"
    case oneCall = "onecall"
}

struct Config {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    static let apiKey = "9dc80b6192ed77a55e4d6482bc58f43f"
}

class NetworkService {
    func getCurrentLocationWeather(latitude: Double,
                                   longitude: Double,
                                   completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        getData(endpoint: .oneCall,
                parameters: [
                    "lat": latitude,
                    "lon": longitude,
                    "appid": Config.apiKey,
                    "units": "metric",
                    "exclude": "minutely"],
                completion: completion)
    }
    
}

extension NetworkService {
    func getData<T: Decodable>(endpoint: Endpoint,
                               parameters: JSONDict,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL.url(with: Config.baseUrl, endpoint: endpoint, queryParams: parameters) else {
            completion(.failure(.badUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                      completion(.failure(.notFound))
                      return
                  }
            guard let data = data,
                  let jsonString = String(data: data, encoding: .utf8),
                  let model = try? JSONDecoder().decode(T.self, from: data) else {
                      completion(.failure(.badJSON))
                      return
                  }
            print(jsonString)
            completion(.success(model))
        }
        task.resume()
    }
}
