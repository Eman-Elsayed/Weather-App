//
//  MapViewController.swift
//  Weather Assignment
//
//  Created by Eman Elsayed on 9/13/18.
//  Copyright © 2018 Eman Elsayed. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate {
    
    var citiesVC = BookmarksViewController()
    @IBOutlet weak var mapView: MKMapView!
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Pin Your Location"
        setLongPressGesture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
      
  
    /// make Long Press Gesture to  select location on Map
    
    private func setLongPressGesture() -> Void {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(gesture:)))
        longPressGesture.minimumPressDuration = 0.4
        self.mapView.addGestureRecognizer(longPressGesture)
    }
    
    /* Add Annotation ON Map On LongPress
         Show Alert that ask user to confirm or cancle making annotations
         If user confirm add annotation , save it in Bookmarks and CoreData
         If user cancle adding annotation , don't add it
     */
    @objc func addAnnotationOnLongPress(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .ended {
            let point = gesture.location(in: self.mapView)
            let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
            print(coordinate)
            
    ///Now use this coordinate to add annotation on map.
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = coordinate
            self.mapView.addAnnotation(pointAnnotation)
            
            let loc = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.showAlert(title: "ERROR", message: (error?.localizedDescription)!, actions: nil)
                } else {
                    let placemark = placemarks?.first
                    /****
                     If Placemark not equal nil
                         then a message with city and country will showed to user
                         user can confirm or cancle to save place in bookmarks
                     ****/
                    if placemark?.administrativeArea != nil && placemark?.country != nil {
                        let annotation = Annotation(withCoordinate: coordinate)
                        annotation.title = placemark?.administrativeArea
                        annotation.subtitle = placemark?.country
                        annotation.coordinate.latitude = pointAnnotation.coordinate.latitude
                        annotation.coordinate.longitude = pointAnnotation.coordinate.longitude
                        self.hideActivityIndicator(superView: self.view)
                        
                        /// Define action when pressing cancle or confirm
                        
                        let cancleAction = UIAlertAction.init(title: "Cancle", style: .cancel, handler: { (action) in
                            self.mapView.removeAnnotation(pointAnnotation)
                        })
                        let confirmAction = UIAlertAction.init(title: "Confirm", style: .default, handler: { (action) in
                            self.mapView.addAnnotation(pointAnnotation)
                            
                          /* IF User press Confirm
                             Save Annotation of place in DB called StoredPlace
                              Core Data
                          */
                            
                            var newCity:StoredPlace?
                            newCity = StoredPlace(context:context)
                            newCity?.city = annotation.title!
                            newCity?.country = annotation.subtitle!
                            newCity?.latitude = annotation.coordinate.latitude
                            newCity?.longitude = annotation.coordinate.longitude
                            
                            do{
                                ad.saveContext()
                                print("Place has been saved in DB")
                              }
                        })
                        /// The message when user longpress on place
                        let message = "Would you like to bookmark this location?"
                        let title = annotation.title! + ", " + annotation.subtitle!
                        self.showAlert(title: title, message: message, actions: [cancleAction, confirmAction])
                    }
                        /*
                         the second state if the placemark not identified correctly
                         Alert to tell user to select another or trying again
                         */
                    else {
                        self.hideActivityIndicator(superView: self.view)
                        let cancleAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: { (action) in
                            self.mapView.removeAnnotation(pointAnnotation)
                        })
                        self.showAlert(title: "Sorry!!", message: "Unable to identify location. Plz place pin at correct location.", actions: [cancleAction])
                    }
                }
            })
        }
    }
}


extension MapViewController{
    
    /// Function : Show Alert
    func showAlert(title: String, message: String, actions:[UIAlertAction]?) {
        let vc = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actionArray = actions {
            for action in actionArray {
                alert.addAction(action)
            }
        } else {
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
        }
        vc?.present(alert, animated: true, completion: nil)
    }
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param superView - add activity indicator to this view
     */
    func showActivityIndicator(superView: UIView) {
        container.frame = superView.frame
        container.center = superView.center
        container.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = superView.center
        let rgbVal : Float = 68.0/255.0
        loadingView.backgroundColor = UIColor(red: CGFloat(rgbVal), green: CGFloat(rgbVal), blue: CGFloat(rgbVal), alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,
                                           y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        superView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param superView - remove activity indicator from this view
     */
    func hideActivityIndicator(superView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
}


