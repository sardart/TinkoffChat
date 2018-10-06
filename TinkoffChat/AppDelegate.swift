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
    var prevState: UIApplicationState?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        appStateControl(currentState: UIApplication.shared.applicationState, methodName: #function)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        appStateControl(currentState: UIApplication.shared.applicationState, methodName: #function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        appStateControl(currentState: UIApplication.shared.applicationState, methodName: #function)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        appStateControl(currentState: UIApplication.shared.applicationState, methodName: #function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        appStateControl(currentState: UIApplication.shared.applicationState, methodName: #function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        appStateControl(currentState: UIApplication.shared.applicationState, methodName: #function)
    }


}

