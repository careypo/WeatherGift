//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Paige Carey on 10/30/18.
//  Copyright © 2018 Paige Carey. All rights reserved.
//

import Foundation


class WeatherLocation: Codable {
    var name: String
    var coordinates: String
    
    init(name: String, coordinates: String) {
        self.name = name
        self.coordinates = coordinates
    }
}
