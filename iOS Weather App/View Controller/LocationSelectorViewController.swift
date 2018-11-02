//
//  LocationSelectorViewController.swift
//  iOS Weather App
//
//  Created by Mason Nesbitt on 10/26/18.
//  Copyright © 2018 Mason Nesbitt. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LocationSelectorViewController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var localSearchBar: UISearchBar!
    
    let apiManage = APIManager()
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localSearchBar.delegate = self
    }
    
    
    
    
    
    func serachBarButtonClicked(_ searchBar:UISearchBar ) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {return}
    }

    override func prepare ( for segue: UIStoryboardSegue, sender: Any?){
        if let destinationVC = segue.destination as?
            WeatherDisplayViewController, let retrievedGeocodingData = geocodingData, let retrievedWeatherData = weatherData {
                destinationVC.displayGeocodingData = retrievedGeocodingData
                destinationVC.displayWeatherData = retrievedWeatherData
        }
    }
    
    
    
    func retrieveWeatherData( latitude:Double, longitude:Double){
        apiManage.getWeather(latitude: latitude, longitude: longitude) { (weatherData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
        
        
        if let recievedError =  error {
            print( recievedError.localizedDescription)
            self.handleError()
            return
        }
        
            if let recievedData = weatherData {
                self.weatherData = recievedData
                self.performSegue(withIdentifier: "switchScreen", sender: self)
            } else {
                    self.handleError()
                    return
                }
            }
        }
    }
