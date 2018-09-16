//
//  cityTableViewCell.swift
//  Weather Assignment
//
//  Created by Eman Elsayed on 9/14/18.
//  Copyright © 2018 Eman Elsayed. All rights reserved.
//

import UIKit

class cityTableViewCell: UITableViewCell {
    
   // let weathervc = WeatherDetailsViewController()
    var lat : Double = 0.0
    var long : Double = 0.0
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// return Cities from DB and show them in Bookmarks view
    
    func setCity(city:StoredPlace){
        
        self.title.text=city.city!
        self.subtitle.text=city.country!
        self.lat = city.latitude
        self.long = city.longitude
//        weathervc.annotation?.coordinate.latitude = city.latitude
//       weathervc.annotation?.coordinate.longitude = city.longitude
//       weathervc.annotation?.title = city.city
    }
//    func returnCoordinate(city:StoredPlace){
//
//        lat = city.latitude
//        long = city.longitude
//    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


