//
//  WeatherData.swift
//  Forecast
//
//  Created by Samarth Paboowal on 29/10/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeatherData {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemperature: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemperature: Double {
        if _currentTemperature == nil {
            _currentTemperature = 0.0
        }
        
        return _currentTemperature
    }
    
    func downloadCurrentWeatherDetails(completed: @escaping DownloadComplete) {
        
        let downloadURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(downloadURL!).responseJSON {
            response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main
                        print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any> {
                    if let temp = main["temp"] as? Double {
                        let alternateTemperature = temp - 273.15
                        self._currentTemperature = (round(alternateTemperature*100))/100
                        print(self._currentTemperature)
                    }
                }
            }
            completed()
        }
    }
}
