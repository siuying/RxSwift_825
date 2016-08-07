//
//  AppDelegate.swift
//  RxDataSourcesExample
//
//  Created by Chan Fai Chong on 7/8/2016.
//  Copyright © 2016 Time Based Technology Limited. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = ViewController(nibName: nil, bundle: nil)
        window!.makeKeyAndVisible()
        return true
    }
}

