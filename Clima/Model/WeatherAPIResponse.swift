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
        
        static func parseJSONResponse(weatherData: Data) -> WeatherData? {
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                
                return decodedData
            } catch {
                print(error)
            }
            
            return nil
        }
    }
}
