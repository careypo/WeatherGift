//
//  TimeInterval+format.swift
//  WeatherGift
//
//  Created by Paige Carey on 10/30/18.
//  Copyright © 2018 Paige Carey. All rights reserved.
//

import Foundation

extension TimeInterval {
    func format(timeZone: String, dateFormatter: DateFormatter) -> String {
        let usableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
}
