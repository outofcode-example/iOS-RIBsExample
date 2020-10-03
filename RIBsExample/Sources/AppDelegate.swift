//
//  AppDelegate.swift
//  RIBsExample
//
//  Created by outofcode on 2020/10/03.
//  Copyright © 2020 outofcode. All rights reserved.
//

import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    lazy var launchRouter: LaunchRouting = MainBuilder().build()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        launchRouter.launch(from: window!)
        return true
    }
}
