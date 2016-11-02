//
//  UserLocation.swift
//  Forecast
//
//  Created by Samarth Paboowal on 02/11/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import CoreLocation

class UserLocation {
    
    static var sharedInstance = UserLocation()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
