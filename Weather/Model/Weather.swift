//
//  Weather.swift
//  Weather
//
//  Created by Amardeep Kaur on 19/02/21.
//

import UIKit

struct Weather {
    var maxTemp: String
    var minTemp: String
    var desc: String
    var icon: String
    var day: String
        
    init(maxTemp: String, minTemp: String, desc: String, icon: String, day: String) {
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.desc = desc
        self.icon = icon
        self.day = day
    }
}
