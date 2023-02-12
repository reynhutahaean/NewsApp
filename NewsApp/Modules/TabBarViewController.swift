//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Reynaldo Cristinus Hutahaean on 11/02/23.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController,UITabBarControllerDelegate {
    let homeTab: HomeViewController = HomeRouter().createModule(data: nil) as! HomeViewController
    let sourcesTab: SourcesViewController = SourceRouter().createModule(data: nil) as! SourcesViewController
    
    var homeNavigationViewController : UINavigationController!
    var sourcesNavigationViewController : UINavigationController!
    
    var overlayView : UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlayView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0
        overlayView.isUserInteractionEnabled = false
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        //Home
        homeNavigationViewController = UINavigationController(rootViewController : homeTab)
        homeNavigationViewController.isNavigationBarHidden = true
    
        //Sources
        sourcesNavigationViewController = UINavigationController(rootViewController : sourcesTab)
        sourcesNavigationViewController.isNavigationBarHidden = true
        
        viewControllers = [homeNavigationViewController, sourcesNavigationViewController]
        
        let attributes = [convertFromNSAttributedStringKey(NSAttributedString.Key.font):UIFont.systemFont(ofSize: 10)]
        
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = #colorLiteral(red: 1, green: 0.3310913146, blue: 0.4058706164, alpha: 1)
        
        tabBar.items?[0].image = UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate)
        tabBar.items?[0].selectedImage = UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysTemplate)
        tabBar.items?[0].title = "Home"
        tabBar.items?[0].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        tabBar.items?[0].setTitleTextAttributes(convertToOptionalNSAttributedStringKeyDictionary(attributes), for: .normal)

        tabBar.items?[1].image = UIImage(systemName: "newspaper")?.withRenderingMode(.alwaysTemplate)
        tabBar.items?[1].selectedImage = UIImage(named: "newspaper.fill")?.withRenderingMode(.alwaysTemplate)
        tabBar.items?[1].title = "Sources"
        tabBar.items?[1].titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        tabBar.items?[1].setTitleTextAttributes(convertToOptionalNSAttributedStringKeyDictionary(attributes), for: .normal)
        
        self.tabBar.items?[0].imageInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0);
        self.tabBar.items?[1].imageInsets = UIEdgeInsets.init(top: -3, left: 0, bottom: 3, right: 0);
        
        homeNavigationViewController.tabBarItem =  tabBar.items?[0]
        sourcesNavigationViewController.tabBarItem = tabBar.items?[1]
        
        selectedViewController = homeNavigationViewController
        selectedIndex = 0
        
        self.tabBar.isTranslucent = false
        self.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBar.invalidateIntrinsicContentSize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTitle()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as! UIGestureRecognizerDelegate
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func setTitle() {
        tabBar.items?[0].title = "Home"
        tabBar.items?[1].title = "Sources"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

