//
//  ViewController.swift
//  iOS Weather App
//
//  Created by Mason Nesbitt on 10/25/18.
//  Copyright © 2018 Mason Nesbitt. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // Do any additional setup after loading the view, typically from a nib.
    }



}

