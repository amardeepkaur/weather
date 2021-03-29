//
//  HomeViewModel.swift
//  Weather
//
//  Created by Amardeep Kaur on 18/02/21.
//

import UIKit

enum PError: Error {
    case invalidData
    case invalidURLPath
    case JSONSerializationError
}

class HomeViewModel {
    var weatherList = [Weather]()
    private var title = "Weather"
    
    private var cellViewModel: [WeatherCellViewModel] = []
    
    var reloadTableView: (() -> ())?
    var showActivityIndicator: (() -> ())?
    var showView: (() -> ())?
    var numberOfCells: Int {
        return weatherList.count
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
    
    init() {
        //Default initializer
        do {
            try loadWeatherItems()
        } catch {
            print("Error loading weather list: \(error)")
        }
        
    }
    
    init(weatherList: [Weather]) {
        //self.weatherList = weatherList
        
    }
    
    func loadWeatherItems() throws {
        guard let filePath = Bundle.main.path(forResource: "Weather", ofType: "json") else { throw PError.invalidURLPath }
        let url = URL(fileURLWithPath: filePath)
        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else { throw PError.invalidData }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
            throw PError.JSONSerializationError
        }
        let dictionary = json as? [String: Any]
        if let weatherForecast = dictionary?["weatherForecast"] as? [[String: Any]] {
            weatherList = weatherForecast.compactMap({ (dictionary) in
                return Weather.init(dictionary: dictionary)
            })
        }
        //self.homeViewModel = HomeViewModel.init(weatherList: weather!)
    }
    
}
