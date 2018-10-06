//
//  AppConfiguration.swift
//  smartChat
//
//  Created by Artur on 23/09/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation


enum AppConfigurationState {
    
    case appStore
    case debug
    case testFlight
}


struct AppConfiguration {
    
    static var state: AppConfigurationState = .debug
    static var isDebugging: Bool {
        return state == .debug
    }
}
