//
//  WeatherDetailsViewController.swift
//  Weather Assignment
//
//  Created by Eman Elsayed on 9/13/18.
//  Copyright © 2018 Eman Elsayed. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var tempDeg: UILabel!
    @IBOutlet weak var minMaxTemp: UILabel!
    @IBOutlet weak var weatherStatus: UILabel!
    @IBOutlet weak var humedity: UILabel!
    @IBOutlet weak var windDegr: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    var annotation : Annotation?
    var currentWeather : Weather!
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnWeatherInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /// function to fetch weather info from API
    func returnWeatherInfo(){
        WeatherAPI.fetchWeatherData(orLatitude : self.latitude, Longitude : self.longitude){ (error, result) in
            if(error == nil){
                self.currentWeather = result as! Weather
                self.updateCurrentWeather(self.currentWeather)
            }
        }
        print("inside fetchweather")
   }
    
   /// function to update the Weather details UI with data from API
    
    func updateCurrentWeather(_ weather: Weather) {
 
        self.tempDeg.text = "\(weather.temperature!)º"
        self.humedity.text = "\(weather.humidity!)"
        self.minMaxTemp.text = "\(weather.minTemp!)º /" + "\(weather.maxTemp!)º"
        self.weatherStatus.text = weather.weatherStatus!
        self.windDegr.text = "\(weather.windDegree!)"
        self.weatherImg.image = weather.weatherImage
        self.todayDate.text = weather.date
    }

}
