//
//  WeatherManager.swift
//  Clima
//
//  Created by Xavier McNulty on 3/9/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    func fetchWeather(city: String) {
        if let url = WeatherAPI.citySearchURL(city: city, units: .metric) {
            performRequest(url: url)
        }
    }
    
    private func performRequest(url: URL) {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            // if there was an error, print it and return
            error.map { e in
                print(e.localizedDescription)
                return
            }
            
            // extract data from response
            if let safeData = data {
                if let weatherData = WeatherAPI.Response.parseJSONResponse(weatherData: safeData) {
                    
                    let model = WeatherModel(
                        conditionId: weatherData.weather[0].id,
                        cityName: weatherData.name,
                        temp: weatherData.main.temp
                    )
                    
                    print(model.conditionName)
                    print(model.temperatureString)
                }
            }
        }
        
        task.resume()
    }
}
