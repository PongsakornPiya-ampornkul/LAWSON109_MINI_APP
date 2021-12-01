//
//  AppDelegate.swift
//  LAWSON109_MINI_APP
//
//  Created by Pongsakorn Piya-ampornkul on 26/11/2564 BE.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        rootViewController()
        return true
    }

    func rootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabbarViewController()
        window?.makeKeyAndVisible()
    }

}

