//
//  ViewController+StateControl.swift
//  smartChat
//
//  Created by Artur on 23/09/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation


extension ViewController {
    
    func stateControl(methodName: String) {
        if AppConfiguration.isDebugging {
            let datetimeString = Date.getDatetime()
            print("\n\(datetimeString) Method '\(methodName)' called")
        }
    }
}
