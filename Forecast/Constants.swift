//
//  Constants.swift
//  Forecast
//
//  Created by Samarth Paboowal on 29/10/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import Foundation

var BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
var LATITUDE = "lat="
var LONGITUDE = "&lon="
var APP_ID = "&appid="
var API_KEY = "582934f0e2a6be45ea54600ee74c3cbe"

typealias DownloadComplete = () -> ()

var CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(UserLocation.sharedInstance.latitude!)\(LONGITUDE)\(UserLocation.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

var FUTURE_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(UserLocation.sharedInstance.latitude!)&lon=\(UserLocation.sharedInstance.longitude!)&cnt=10&mode=json&appid=582934f0e2a6be45ea54600ee74c3cbe"
