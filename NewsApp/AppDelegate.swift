//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 23/01/23.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainNavigationController: UINavigationController?
    var globalTabBarController: TabBarViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        handleFirstScreen()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        return true
    }
    
    func handleFirstScreen() {
        let home = HomeRouter.init().createModule()
        let navigationController = UINavigationController(rootViewController: home)

        navigationController.isNavigationBarHidden = true
        navigationController.navigationBar.shadowImage = nil
        navigationController.navigationBar.isTranslucent = true

        mainNavigationController = navigationController

        self.window?.rootViewController = mainNavigationController
        self.window?.backgroundColor = UIColor.init(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        
        tabBarController()
    }
    
    func tabBarController(){
        globalTabBarController = TabBarViewController()
        globalTabBarController.selectedIndex = 0
        mainNavigationController?.pushViewController(globalTabBarController, animated: true)
    }
}

