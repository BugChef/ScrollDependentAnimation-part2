//
//  AppDelegate.swift
//  ScrollDependentAnimation-part2
//
//  Created by Ilia Kovalchuk on 13.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let rootViewController = EnterViewController(nibName: nil, bundle: nil)
        let navController = UINavigationController(rootViewController: rootViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}
