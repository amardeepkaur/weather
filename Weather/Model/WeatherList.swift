//
//  WeatherList.swift
//  Weather
//
//  Created by Amardeep Kaur on 21/03/21.
//

import Foundation

struct WeatherList {
    var list: [Weather] = [Weather]()
    var title: String = "List"
    
    init(list: [Weather]) {
        self.list = list
    }
}
