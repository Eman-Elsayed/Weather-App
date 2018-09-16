//
//  WeatherAPI.swift
//  Weather Assignment
//
//  Created by Eman Elsayed on 9/14/18.
//  Copyright © 2018 Eman Elsayed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherAPI {
    /// Fecthing Weather API
    ///
    /// - Parameters:
    ///   - lat: Latitude
    ///   - long: Longitude
   static let apiKey = "f9f89e3f8df9497aef7f3556f912f872"
   static  let units = "metric"
    
    /* function to fetch info about weather from api
    using Alamofire
    swiftyJson
      */
    
   static  func fetchWeatherData (orLatitude lat: Double, Longitude long: Double,completion:@escaping (_ error:String?,_ result:Any?)->Void){
      
        let baseURL = "http://api.openweathermap.org/data/2.5/weather"
        let paramString = "?lat=\(lat)&lon=\(long)&appid=\(apiKey)&units=\(units)"
        let url = baseURL + paramString
        print(url)
    
    ///Using Alamofire TO fetch data
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON {
                response in
                switch response.result{
                case .failure:
                    completion(response.error?.localizedDescription,false)
                case .success:
                    
                    let json = JSON(response.value!)
                    print(json)
                    let tempDegree = json["main"]["temp"].floatValue
                    let tempMin = json["main"]["temp_min"].floatValue
                    let tempMax = json["main"]["temp_max"].floatValue
                    let status = json["weather"][0]["description"].stringValue
                    let windDegree = json["wind"]["deg"].floatValue
                    let humidity = json["main"]["humidity"].floatValue
                    let WeatherMain = json["weather"][0]["main"].stringValue
                    let weatherDate = json["dt_txt"].stringValue
                    let weather = Weather(_temperature : tempDegree,
                                          _minTemp: tempMin,
                                          _maxTemp: tempMax,
                                          _weatherStatus: status,
                                          _windDegree: windDegree,
                                          _humidity : humidity,
                                          _weatherMain : WeatherMain,
                                          _weatherDate : weatherDate
                                        )
                 completion(nil,weather)
                }
        }
    }
}


