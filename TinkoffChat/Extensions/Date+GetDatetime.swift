//
//  Date+getTime.swift
//  smartChat
//
//  Created by Artur on 23/09/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation


extension Date {
    
    static func getDatetime() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let nanosecond = calendar.component(.nanosecond, from: date)
        
        let timeString = "\(hour):\(minute):\(second):\(nanosecond)"
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let dateString = "\(year)-\(month)-\(day)"
        
        let datetimeString = "\(dateString) \(timeString)"
        
        return datetimeString
    }
}
