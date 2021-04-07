//
//  AppDelegate.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = ContainerController()
        window?.makeKeyAndVisible()
        return true
    }

}

