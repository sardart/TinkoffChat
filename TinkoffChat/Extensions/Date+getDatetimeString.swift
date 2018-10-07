//
//  Date+getDatetimeString.swift
//  TinkoffChat
//
//  Created by Artur on 06/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation

extension Date {
    static func getDatetimeString(from date: Date?) -> String {
        guard let date = date else { return "" }
        
        let dateFormatter = DateFormatter()
        
        let currentDay = dateFormatter.calendar.component(.day, from: Date(timeIntervalSinceNow: 0))
        let currentMonth = dateFormatter.calendar.component(.month, from: Date(timeIntervalSinceNow: 0))
        let currentYear = dateFormatter.calendar.component(.year, from: Date(timeIntervalSinceNow: 0))
        
        let dateDay = dateFormatter.calendar.component(.day, from: date)
        let dateMonth = dateFormatter.calendar.component(.month, from: date)
        let dateYear = dateFormatter.calendar.component(.year, from: date)
        
        let isToday = currentDay == dateDay && currentMonth == dateMonth && currentYear == dateYear
        
        if isToday {
            dateFormatter.dateFormat = "HH:mm"
        } else {
            dateFormatter.dateFormat = "dd MMM"
        }
        
        let datetimeString = dateFormatter.string(from: date)
        
        return datetimeString
    }

    
}
