//
//  AppDelegate.swift
//  BaseAFAPI
//
//  Created by ManhLD on 10/8/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }


}

