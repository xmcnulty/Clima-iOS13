//
//  WeatherAPI.swift
//  Clima
//
//  Created by Xavier McNulty on 3/10/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherAPI {
    private init() {}
    
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    static let token = "cb1c9a074cd767365a4754afc5e50f29"
    
    enum Units: String {
        case standard = "standard", metric = "metric", imperial = "imperial"
    }
    
    /// Generates a URL object wtih the OpenWeather API base URL, and parameters conforming to the API docs.
    /// - Parameters:
    ///   - city: city to query API for current weather
    ///   - units: optional units to specify in api request
    /// - Returns: URL for the API call based on the passed parameters
    static func citySearchURL(city: String, units: Units? = nil) -> URL? {
        var components = URLComponents(string: WeatherAPI.baseURL)
        var queryItems: [URLQueryItem] = []
        
        queryItems.append(URLQueryItem(name: WeatherAPI.Keys.apiKey, value: WeatherAPI.token))
        queryItems.append(URLQueryItem(name: WeatherAPI.Keys.query, value: city))
        
        if let u = units {
            queryItems.append(URLQueryItem(name: WeatherAPI.Keys.units, value: u.rawValue))
        }
        
        components?.queryItems = queryItems
        
        return components?.url
    }
}
