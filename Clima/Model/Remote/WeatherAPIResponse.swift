//
//  WeatherAPIResponse.swift
//  Clima
//
//  Created by Xavier McNulty on 3/10/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

extension WeatherAPI {
    struct Response {
        private init() {}
        
        static func parseJSONResponse(_ weatherData: Data) throws -> WeatherModel {
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                
                let model = WeatherModel(conditionId: decodedData.weather[0].id, cityName: decodedData.name, temp: decodedData.main.temp)
                
                return model
            } catch {
                throw error
            }
        }
    }
}
