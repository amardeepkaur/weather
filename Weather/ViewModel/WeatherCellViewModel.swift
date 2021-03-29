//
//  DailyWeatherCellViewModel.swift
//  Weather
//
//  Created by Amardeep Kaur on 24/03/21.
//

import Foundation

class WeatherCellViewModel {
    var day: String
    var icon: String
    var max: Int
    var min: Int
    
    init(day: String, icon: String, max: Int, min: Int) {
        self.day = day
        self.icon = icon
        self.max = max
        self.min = min
    }
//    init?(dictionary: [String: Any]) {
//        guard let day = dictionary["day"] as? String, let icon = dictionary["icon"] as? String, let min = dictionary["min"] as? Int, let max = dictionary["max"] as? Int else {
//            return nil
//        }
//        self.day = day
//        self.icon = icon
//        self.max = max
//        self.min = min
//    }
}
