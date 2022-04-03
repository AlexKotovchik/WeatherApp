//
//  NetworkService.swift
//  WeatherApp
//
//  Created by AlexKotov on 14.01.22.
//

import Foundation

public typealias JSONDict = [String: Any]
public typealias HeadersDict = [String: String]

enum Endpoint: String {
    case weather = "weather"
    case oneCall = "onecall"
    case city = "places"
}

struct Config {
    static let weatherUrl = "https://api.openweathermap.org/data/2.5/"
    static let geoUrl = "http://api.openweathermap.org/geo/1.0/"
    static let cityUrl = "https://spott.p.rapidapi.com/"
    static let apiKey = "9dc80b6192ed77a55e4d6482bc58f43f"
    
    static let cityhHeaders = [
        "x-rapidapi-host": "spott.p.rapidapi.com",
        "x-rapidapi-key": "a419aaab77msh50eb8838810e2cdp1736f4jsna40189e9c02a"
    ]
    
    static let currentLanguage = String(Locale.preferredLanguages.first?.prefix(2) ?? "en")
    
}

class NetworkService {
    func getCurrentLocationWeather(latitude: Double,
                                   longitude: Double,
                                   completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        getData(baseUrl: Config.weatherUrl,
                endpoint: .oneCall,
                parameters: [
                    "lat": latitude,
                    "lon": longitude,
                    "appid": Config.apiKey,
                    "units": "metric",
                    "exclude": "minutely",
                    "lang": Config.currentLanguage],
                headers: [:],
                completion: completion)
    }
    
    func getCities(cityPrefix: String,
                   completion: @escaping (Result<[City], NetworkError>) -> Void) {
        getData(baseUrl: Config.cityUrl,
                  endpoint: .city,
                  parameters: [
                    "type": "City",
                    "skip": "0",
                    "limit": "10",
                    "q": cityPrefix,
                    "language": Config.currentLanguage],
                  headers: Config.cityhHeaders,
                  completion: completion)
    }
    
    
}

extension NetworkService {
    func getData<T: Decodable>(baseUrl: String,
                               endpoint: Endpoint,
                               parameters: JSONDict,
                               headers: HeadersDict,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL.url(with: baseUrl, endpoint: endpoint, queryParams: parameters) else {
            completion(.failure(.badUrl))
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                      completion(.failure(.notFound))
                      return
                  }
            guard let data = data,
                  let model = try? JSONDecoder().decode(T.self, from: data) else {
                      completion(.failure(.badJSON))
                      return
            }
            completion(.success(model))
        }
        task.resume()
    }

}
