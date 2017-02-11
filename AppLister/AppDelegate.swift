//
//  AppDelegate.swift
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014-2017 BlueDino Software. 
//  Availble under the MIT License. See the file, LICENSE, for details.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        return true
    }
  
  // MARK: - Split view
  
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
    if let secondaryAsNavController = secondaryViewController as? UINavigationController,
      let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController,
        topAsDetailController.detailItem == nil {
          return true
    }
    return false
  }
  
}

