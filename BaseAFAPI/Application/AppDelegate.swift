//
//  AppDelegate.swift
//  BaseAFAPI
//
//  Created by ManhLD on 10/8/20.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        realmConfig()
        return true
    }
    
    func realmConfig()  {
         let config = Realm.Configuration(
             // Set the new schema version. This must be greater than the previously used
             // version (if you've never set a schema version before, the version is 0).
             schemaVersion: 1,
             // Set the block which will be called automatically when opening a Realm with
             // a schema version lower than the one set above
             migrationBlock: { migration, oldSchemaVersion in
                 // We haven’t migrated anything yet, so oldSchemaVersion == 0
                 if (oldSchemaVersion < 1) {
                     // Nothing to do!
                     // Realm will automatically detect new properties and removed properties
                     // And will update the schema on disk automatically
                 }
             })

         // Tell Realm to use this new configuration object for the default Realm
         Realm.Configuration.defaultConfiguration = config
     }
}

