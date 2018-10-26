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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultUI()
        let apiKeys = APIKeys()
        
        let darkSkyUrl = "https://api.darksky.net/forecast/"
        let darkSkyKey = apiKeys.darkSkyKey
        let latitude = "37.004842"
        let longitude = "-85.925876"
        
        let url = darkSkyUrl + darkSkyKey + "/" + latitude + "," + longitude
        
        let request = Alamofire.request(url)
        
        
        request.responseJSON { response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
        let googleBaseUrl = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let googleRequestURL =  googleBaseUrl + "Lexington,+Kentucky" + "&key=" + apiKeys.googleKey
        
        let googleRequest = Alamofire.request(googleRequestURL)
        
        googleRequest.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupDefaultUI() {
        locationLabel.text = " "
        emojiPic.text = "💩"
        currentTempLabel.text = " "
        highLabel.text = "-"
        lowLabel.text = "-"

    }



}

