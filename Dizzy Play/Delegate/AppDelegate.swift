//
//  AppDelegate.swift
//  Dizzy Play
//
//  Created by ジャチン on 2017/11/15.
//  Copyright © 2017 ジャチン. All rights reserved.
//

import UIKit
import Pastel


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let colors = [UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                  UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                  UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                  UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                  UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                  UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                  UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        _ = Int(arc4random_uniform(UInt32(colors.count)))
        //UINavigationBar.appearance().barTintColor = UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0)
        //UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red:1.00, green:0.07, blue:0.18, alpha:1.00)]
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

