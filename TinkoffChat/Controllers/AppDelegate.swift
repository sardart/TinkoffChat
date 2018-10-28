//
//  AppDelegate.swift
//  smartChat
//
//  Created by Artur on 23/09/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loadSavedTheme()
        
        return true
    }

    func loadSavedTheme() {
        guard let theme = UserDefaults.standard.color(forKey: "theme") else { return }
        UINavigationBar.appearance().backgroundColor = theme
    }
    
}

