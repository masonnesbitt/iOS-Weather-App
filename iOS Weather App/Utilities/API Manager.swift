//
//  API Manager.swift
//  iOS Weather App
//
//  Created by Mason Nesbitt on 10/29/18.
//  Copyright © 2018 Mason Nesbitt. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    private let darkSkyUrl = "https://api.darksky.net/forecast/"
    
    private let googleBaseUrl = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    private let apiKeys = APIKeys()
    
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    func getWeather(latitude: Double, longitude: Double, onCompletion: @escaping (WeatherData?, Error?)-> Void) {
        
        let url = darkSkyUrl + apiKeys.darkSkyKey + "/" + "\(latitude)" + "," + "\(longitude)"
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print(json)
                
                if  let weatherData = WeatherData(json: json) {
                    onCompletion(weatherData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                    
                }
            case .failure(let error):
                onCompletion(nil, error)
                
                
            }
        }
        
    }

    func geocode(address: String, onCompletion: @escaping(GeocodingData?, Error?) -> Void) {
        
        let url = googleBaseUrl + address + apiKeys.googleKey
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if  let geocodingData = GeocodingData(json: json) {
                    onCompletion(geocodingData, nil)
                } else {
                    onCompletion(nil, APIErrors.invalidData)
                    
                }
            case .failure(let error):
                onCompletion(nil, error)
                
                
            }
        }
    }
}
