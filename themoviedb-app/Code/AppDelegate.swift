//
//  AppDelegate.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        getStart()
        return true
    }
    
    func getStart() {
        window = UIWindow()
        let navigationController = UINavigationController()
        let dataProvider = DataProvider()
        self.window?.rootViewController = navigationController
        let searchCoordinator = SearchCoordinator(navigationController: navigationController, dataProvider: dataProvider)
        searchCoordinator.start()
        window?.makeKeyAndVisible()
    }

}

