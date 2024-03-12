//
//  WeatherManager.swift
//  Clima
//
//  Created by Xavier McNulty on 3/9/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

//MARK: - Weather Manager Delegate

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ manager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ manager: WeatherManager, error: Error)
}

//MARK: - Weather Manager

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate? = nil
    
    func fetchWeatherByCity(with city: String) {
        if let url = WeatherAPI.citySearchURL(city: city) {
            performRequest(with: url)
        }
    }
    
    func fetchWeatherByPosition(latitude: Double, longitude: Double) {
        if let url = WeatherAPI.coordinateSearchURL(lat: latitude, lon: longitude) {
            performRequest(with: url)
        }
    }
    
    private func performRequest(with url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // check for and handle client error
            if let error = error {
                handleClientError(error)
                return
            }
            
            // check for and handle server errors
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                handleServerError(response: response)
                
                return
            }
            
            // extract data from response
            if let safeData = data {
                do {
                    let model = try WeatherAPI.Response.parseJSONResponse(safeData)
                    
                    self.delegate?.didUpdateWeather(self, weather: model)
                } catch {
                    handleClientError(error)
                }
            }
        }
        
        task.resume()
    }
    
    private func handleClientError(_ error: Error) {
        print("Client error occurred: ")
        print(error.localizedDescription)
    }
    
    private func handleServerError(response: URLResponse?) {
        print("Server error occurred:")
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Server sent non-HTTP response")
            
            return
        }
        
        print("Server responded with code \(httpResponse.statusCode)")
    }
}
