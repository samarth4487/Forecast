//
//  FutureWeatherDataCell.swift
//  Forecast
//
//  Created by Samarth Paboowal on 02/11/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit

class FutureWeatherDataCell: UITableViewCell {

    @IBOutlet weak var futureWeatherImageView: UIImageView!
    @IBOutlet weak var futureDay: UILabel!
    @IBOutlet weak var futureWeatherType: UILabel!
    @IBOutlet weak var highTemperature: UILabel!
    @IBOutlet weak var lowTemperature: UILabel!
    
    func configureCell(futureWeatherData: FutureWeatherData) {
        
        highTemperature.text = futureWeatherData.highTemperature
        lowTemperature.text = futureWeatherData.lowTemperature
        futureWeatherType.text = futureWeatherData.weatherType
        futureDay.text = futureWeatherData.date
        futureWeatherImageView.image = UIImage(named: futureWeatherData.weatherType)
    }

}
