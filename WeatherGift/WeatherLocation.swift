//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Paige Carey on 10/21/18.
//  Copyright © 2018 Paige Carey. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name = ""
    var coordinates = ""
    
    func getWeather() {
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON {response in
            print(response)
        }
    }
}
