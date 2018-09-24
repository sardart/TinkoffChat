//
//  AppDelegate+StateControl.swift
//  smartChat
//
//  Created by Artur on 23/09/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit


extension AppDelegate {
    
    func appStateControl(currentState: UIApplicationState, methodName: String) {
        let prevStateString = getAppStateString(for: self.prevState)
        let currentStateString = getAppStateString(for: currentState)
        
        if AppConfiguration.isDebugging {
            let datetimeString = Date.getDatetime()
            print("\n\(datetimeString) Method '\(methodName)' called")
            if currentStateString != prevStateString {
                print("Application moved from '\(prevStateString)' to '\(currentStateString)'")
            } else {
                print("App state still '\(currentStateString)'")
            }
        }
        
        self.prevState = currentState
    }
    
    func getAppStateString(for state: UIApplicationState?) -> String {
        guard let state = state else {
            return "Not running"
        }
        
        switch state {
        case .active:
            return "Active"
        case .background:
            return "Background"
        case .inactive:
            return "Inactive"
        }
    }
    
    
}
