//
//  AppDelegate.swift
//  Example
//
//  Created by Beles on 10/08/2019.
//  Copyright © 2019 ETTextField. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ExampleController()
        window?.makeKeyAndVisible()
        return true
    }
}

