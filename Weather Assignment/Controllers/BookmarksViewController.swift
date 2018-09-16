//
//  BookmarksViewController.swift
//  Weather Assignment
//
//  Created by Eman Elsayed on 9/13/18.
//  Copyright © 2018 Eman Elsayed. All rights reserved.
//

import UIKit
import CoreData

class BookmarksViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var listOfCities=[StoredPlace]()
    @IBOutlet weak var citiesTableView: UITableView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCities()
        citiesTableView.delegate=self
        citiesTableView.dataSource=self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       loadCities()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listOfCities.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:cityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for:indexPath) as! cityTableViewCell
            cell.setCity(city: listOfCities[indexPath.row])
            return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /* Swap to left to delete a specific city
        delete it from DB
    */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
          let fetchRequest:NSFetchRequest<StoredPlace> = StoredPlace.fetchRequest()
          do {
                   listOfCities = try context.fetch(fetchRequest)
                   context.delete(listOfCities[indexPath.row] )
                   try context.save()
                   loadCities()
                         print("deleted row -------------")
             }
          catch let error as NSError  {
            print("Could not delete \(error), \(error.userInfo)")
        }
          catch{
            
        }
       
    }
        
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let weatherdetailsVC = storyBoard.instantiateViewController(withIdentifier: "WeatherDetailsVC") as! WeatherDetailsViewController
        weatherdetailsVC.latitude = listOfCities[indexPath.row].latitude
        weatherdetailsVC.longitude = listOfCities[indexPath.row].longitude
        weatherdetailsVC.title = listOfCities[indexPath.row].city! + " Weather"
        self.navigationController?.pushViewController(weatherdetailsVC, animated: true)
  }

    //func to load the bookmarks table view with data stored in DB
    
    func loadCities(){
        
        let fetchRequest:NSFetchRequest<StoredPlace> = StoredPlace.fetchRequest()
        do{
            listOfCities = try context.fetch(fetchRequest)
            self.citiesTableView?.reloadData()
        }catch{
            print("cannot read from database")
        }
    }

}

