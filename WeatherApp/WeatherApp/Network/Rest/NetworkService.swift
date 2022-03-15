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
    case directGeocoding = "direct"
    case reverseGeocoding = "reverse"
    case city = "places"
}

struct Config {
    static let weatherUrl = "https://api.openweathermap.org/data/2.5/"
    static let geoUrl = "http://api.openweathermap.org/geo/1.0/"
    static let cityUrl = "https://spott.p.rapidapi.com/"
    static let apiKey = "9dc80b6192ed77a55e4d6482bc58f43f"
    
    static let cityhHeaders = [
        "x-rapidapi-host": "spott.p.rapidapi.com",
        "x-rapidapi-key": "436505aa62mshbc908ed0a735910p1e93c3jsn9551210e0d4a"
    ]
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
                    "exclude": "minutely"],
                completion: completion)
    }
    
    func getPlaces(city: String,
                  completion: @escaping (Result<[Place], NetworkError>) -> Void) {
        getDataa(baseUrl: Config.geoUrl,
                endpoint: .directGeocoding,
                parameters: [
                    "q": city,
                    "appid": Config.apiKey,
                    "limit": 10],
                completion: completion)
    }
    
    func getCities(cityPrefix: String,
                   completion: @escaping (Result<[City], NetworkError>) -> Void) {
        getDataaa(baseUrl: Config.cityUrl,
                  endpoint: .city,
                  parameters: [
                    "type": "City",
                    "skip": "0",
                    "limit": "10",
                    "q": cityPrefix],
                  headers: Config.cityhHeaders,
                  completion: completion)
    }
    
    
}

extension NetworkService {
    func getData<T: Decodable>(baseUrl: String,
                               endpoint: Endpoint,
                               parameters: JSONDict,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL.url(with: baseUrl, endpoint: endpoint, queryParams: parameters) else {
            completion(.failure(.badUrl))
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [:]
        
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
    
    func getDataa<T: Decodable>(baseUrl: String,
                               endpoint: Endpoint,
                               parameters: JSONDict,
                               completion: @escaping (Result<[T], NetworkError>) -> Void) {
        guard let url = URL.url(with: baseUrl, endpoint: endpoint, queryParams: parameters) else {
            completion(.failure(.badUrl))
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                      completion(.failure(.notFound))
                      return
                  }
            guard let data = data,
                  let model = try? JSONDecoder().decode([T].self, from: data) else {
                      completion(.failure(.badJSON))
                      return
            }
            completion(.success(model))
        }
        task.resume()
    }
    
    func getDataaa<T: Decodable>(baseUrl: String,
                                 endpoint: Endpoint,
                                 parameters: JSONDict,
                                 headers: HeadersDict,
                                 completion: @escaping (Result<[T], NetworkError>) -> Void) {
        guard let url = URL.url(with: baseUrl, endpoint: endpoint, queryParams: parameters) else {
            completion(.failure(.badUrl))
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                      completion(.failure(.notFound))
                      return
                  }
            guard let data = data,
                  let model = try? JSONDecoder().decode([T].self, from: data) else {
                      completion(.failure(.badJSON))
                      return
            }
            completion(.success(model))
        }
        task.resume()
    }
}
