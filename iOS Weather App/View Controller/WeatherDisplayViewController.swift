//
//  WeatherDisplayViewController.swift
//  iOS Weather App
//
//  Created by Mason Nesbitt on 10/25/18.
//  Copyright © 2018 Mason Nesbitt. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherDisplayViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var emojiPic: UILabel!
    @IBOutlet weak var changeLocationButton: UIBarButtonItem!
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    var displayWeatherData: WeatherData! {
        didSet{
            emojiPic.text =
                displayWeatherData.condition.icon
                currentTempLabel.text = " \(displayWeatherData.temperature) º"
                highLabel.text = "\(displayWeatherData.highTemp) º"
                lowLabel.text = "\(displayWeatherData.lowTemp) º"
        }
    }
    
    
    
    var displayGeocodingData: GeocodingData!
    
    override func viewDidLoad() {
        
        func setupDefaultUI() {
            locationLabel.text = " "
            emojiPic.text = "☔️"
            currentTempLabel.text = " "
            highLabel.text = "-"
            lowLabel.text = "-"
            
        }
        
        super.viewDidLoad()
        
        let weatherData = 
        
        setupDefaultUI()
        
        let apiManager = APIManager()
        
        apiManager.geocode(address: "Glasgow,+Kentucky")
        { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
        
            print(data.formattedAddress)
            print(data.latitude)
            print(data.longitude)
    }
        apiManager.getWeather(latitude: 37.004842, longitude: -85.925876) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                return
                
            }
            guard let data = data else {
                return
            }
            
            print(data.temperature  )
            print(data.highTemp)
            print(data.lowTemp)
            print(data.condition.icon)
        }





}

}
