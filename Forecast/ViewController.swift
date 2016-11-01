//
//  ViewController.swift
//  Forecast
//
//  Created by Samarth Paboowal on 24/10/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var todayTemperature: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var todayWeather: UILabel!
    @IBOutlet weak var todayWeatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeatherData = CurrentWeatherData()
    var futureWeatherDataValues = [FutureWeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        currentWeatherData.downloadCurrentWeatherDetails {
            self.downloadFutureWeatherDetails {
                self.updateMainUI()
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func downloadFutureWeatherDetails(completed: @escaping DownloadComplete) {
        
        let forecastURL = URL(string: FUTURE_WEATHER_URL)
        Alamofire.request(forecastURL!).responseJSON {
            response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    
                    for obj in list {
                        let futureWeatherData = FutureWeatherData(weatherDict: obj)
                        self.futureWeatherDataValues.append(futureWeatherData)
                    }
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weather", for: indexPath)
        
        return cell
    }
    
    func updateMainUI() {
        
        todayDate.text = currentWeatherData.date
        todayTemperature.text = "\(currentWeatherData.currentTemperature)°"
        todayWeather.text = currentWeatherData.weatherType
        place.text = currentWeatherData.cityName
        todayWeatherImageView.image = UIImage(named: currentWeatherData.weatherType)
    }

}

