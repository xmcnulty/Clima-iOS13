//
//  WeatherModel.swift
//  Clima
//
//  Created by Xavier McNulty on 3/10/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temp: Float
    
    var temperatureString: String {
        return String(Int(temp.rounded()))
    }
    
    var conditionName: String {
        switch conditionId {
        case 200..<300:
            return "cloud.bolt"
        case 300..<400:
            return "cloud.drizzle"
        case 511:
            return "cloud.sleet"
        case 500..<600:
            return "cloud.rain"
        case 600..<700:
            return "cloud.snow"
        case 700..<800:
            return "sun.haze"
        case 800:
            return "sun.max"
        case 801..<900:
            return "cloud"
        default:
            return "sun.min"
        }
    }
}
