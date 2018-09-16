//
//  Weather.swift
//  Weather Assignment
//
//  Created by Eman Elsayed on 9/14/18.
//  Copyright © 2018 Eman Elsayed. All rights reserved.
//

import Foundation
import  UIKit

class Weather {
    var temperature: Float?
    var minTemp: Float?
    var maxTemp: Float?
    var weatherStatus: String?
    var windDegree: Float?
    var humidity:Float?
    var weatherMain : String?
    
    /// Date of today's weather
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        return "\(currentDate)"
    }
    
    /// Image that represents weather status
    var weatherImage : UIImage {
        
        switch weatherMain {
            
        case "Clouds":
            
            return UIImage(named:"cloudy_big")!
            
        case "Clear":
            
            return UIImage(named:"sun_big")!
            
        case "Rain":
            
            return UIImage(named:"rain_cells")!
            
        default:
            
            return UIImage(named:"default")!
            
        }
    }
    /// init_Function
    ///
    init(_temperature : Float , _minTemp: Float , _maxTemp : Float , _weatherStatus : String , _windDegree : Float , _humidity : Float, _weatherMain: String , _weatherDate: String) {
         temperature = _temperature
         minTemp = _minTemp
         maxTemp = _maxTemp
         weatherStatus = _weatherStatus
         windDegree = _windDegree
         humidity = _humidity
         weatherMain = _weatherMain  
    }
    
}
