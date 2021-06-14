//
//  AppDelegate.swift
//  Albert_t
//
//  Created by Pavle Mijatovic on 14.6.21..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRootVC()

        return true
    }
    
    // MARK: - Helper
    private func setRootVC() {
        let nc = UINavigationController()
        coordinator = MainCoordinator(navigationController: nc)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
}
