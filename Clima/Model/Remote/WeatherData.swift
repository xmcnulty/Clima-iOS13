//
//  WeatherData.swift
//  Clima
//
//  Created by Xavier McNulty on 3/10/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: WeatherData.Main
    let weather: [WeatherData.Weather]
    
    struct Main: Decodable {
        let temp: Float
    }
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
    }
}
