//
//  HomeViewModel.swift
//  Weather
//
//  Created by Amardeep Kaur on 18/02/21.
//

import UIKit

class HomeViewModel {
    private var dailyWeather = [Weather]()
    private var cellViewModel: [DailyWeatherCellViewModel] = []
    var reloadTableView: (() -> ())?
    var showActivityIndicator: (() -> ())?
    var showView: (() -> ())?
    var numberOfCells: Int {
        return dailyWeather.count
    }
    
    var isLoading: Bool = false {
        didSet  {
            showActivityIndicator?()
        }
    }
    
    var hasViewAppeared: Bool = false {
        didSet {
            showView?()
        }
    }
    
}

class DailyWeatherCellViewModel {
    
}
