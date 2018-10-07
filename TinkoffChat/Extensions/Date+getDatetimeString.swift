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
        
        
        let today = dateFormatter.calendar.component(.day, from: Date(timeIntervalSinceNow: 0))
        let dateDay = dateFormatter.calendar.component(.day, from: date)
        
        if today == dateDay {
            dateFormatter.dateFormat = "HH:mm"
        } else {
            dateFormatter.dateFormat = "dd MMM"
        }
        
        let datetimeString = dateFormatter.string(from: date)
        
        return datetimeString
    }

    
}
