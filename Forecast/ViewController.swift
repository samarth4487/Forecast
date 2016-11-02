//
//  ViewController.swift
//  Forecast
//
//  Created by Samarth Paboowal on 24/10/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var todayTemperature: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var todayWeather: UILabel!
    @IBOutlet weak var todayWeatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeatherData = CurrentWeatherData()
    var futureWeatherDataValues = [FutureWeatherData]()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopMonitoringSignificantLocationChanges()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationAuthStatus()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            UserLocation.sharedInstance.latitude = currentLocation.coordinate.latitude
            UserLocation.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(UserLocation.sharedInstance.latitude, UserLocation.sharedInstance.longitude)
            
            currentWeatherData.downloadCurrentWeatherDetails {
                self.downloadFutureWeatherDetails {
                    self.updateMainUI()
                }
            }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
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
                    self.futureWeatherDataValues.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return futureWeatherDataValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weather", for: indexPath) as? FutureWeatherDataCell {
            
            let futureWeatherDataValue = futureWeatherDataValues[indexPath.row]
            cell.configureCell(futureWeatherData: futureWeatherDataValue)
            
            return cell
        } else {
            
            return FutureWeatherDataCell()
        }
        
    }
    
    func updateMainUI() {
        
        todayDate.text = currentWeatherData.date
        todayTemperature.text = "\(currentWeatherData.currentTemperature)°"
        todayWeather.text = currentWeatherData.weatherType
        place.text = currentWeatherData.cityName
        todayWeatherImageView.image = UIImage(named: currentWeatherData.weatherType)
    }

}

