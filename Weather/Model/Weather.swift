//
//  Weather.swift
//  Weather
//
//  Created by Amardeep Kaur on 19/02/21.
//

import UIKit

struct Weather {
    var maxTemp: Int
    var minTemp: Int
    var icon: String
    var day: String
        
    init(maxTemp: Int, minTemp: Int, icon: String, day: String) {
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.icon = icon
        self.day = day
    }
    
    init?(dictionary: [String: Any]) {
        guard let day = dictionary["day"] as? String, let icon = dictionary["icon"] as? String, let min = dictionary["min"] as? Int, let max = dictionary["max"] as? Int else {
            return nil
        }
        self.day = day
        self.icon = icon
        self.maxTemp = max
        self.minTemp = min
    }
}
