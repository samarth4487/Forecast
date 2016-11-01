//
//  FutureWeatherData.swift
//  Forecast
//
//  Created by Samarth Paboowal on 01/11/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit
import Alamofire

class FutureWeatherData {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemperature: String!
    private var _lowTemperature: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemperature: String {
        if _highTemperature == nil {
            _highTemperature = ""
        }
        
        return _highTemperature
    }
    
    var lowTemperature: String {
        if _lowTemperature == nil {
            _lowTemperature = ""
        }
        
        return _lowTemperature
    }
    
    init(weatherDict: Dictionary<String, Any>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {
            
            if let min = temp["min"] as? Double {
                let alternateMin = min - 273.15
                self._lowTemperature = "\(round(alternateMin*100) / 100)"
            }
            
            if let max = temp["max"] as? Double {
                let alternateMax = max - 273.15
                self._highTemperature = "\(round(alternateMax*100) / 100)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "EEEE"
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
}

extension Date {
    
    func dayOfTheWeek() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}
