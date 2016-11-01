//
//  ViewController.swift
//  Forecast
//
//  Created by Samarth Paboowal on 24/10/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var todayTemperature: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var todayWeather: UILabel!
    @IBOutlet weak var todayWeatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeatherData = CurrentWeatherData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        currentWeatherData.downloadCurrentWeatherDetails {
            // Setup the UI after the download is completed
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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

}

