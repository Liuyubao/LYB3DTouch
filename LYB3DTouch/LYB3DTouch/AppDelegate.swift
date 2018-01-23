//
//  AppDelegate.swift
//  LYB3DTouch
//
//  Created by 柳玉豹 on 2018/1/23.
//  Copyright © 2018年 xinghaiwulian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let itemIcon1 = UIApplicationShortcutIcon(templateImageName: "AIcon")
        let item1 = UIApplicationShortcutItem.init(type: "type1", localizedTitle: "short 兴", localizedSubtitle: "subTitle1", icon: itemIcon1, userInfo: nil)
        
        let itemIcon2 = UIApplicationShortcutIcon.init(templateImageName: "rightIcon")
        let item2 = UIApplicationShortcutItem.init(type: "type2", localizedTitle: "short 海", localizedSubtitle: "subTitle2", icon: itemIcon2, userInfo: nil)
        
        let itemIcon3 = UIApplicationShortcutIcon.init(type: .add)
        let item3 = UIApplicationShortcutItem.init(type: "type3", localizedTitle: "short 物", localizedSubtitle: "subTitle3", icon: itemIcon3, userInfo: nil)
        
        let itemIcon4 = UIApplicationShortcutIcon(type: .add)
        let item4 = UIApplicationShortcutItem.init(type: "type4", localizedTitle: "short 联", localizedSubtitle: "subTitle4", icon: itemIcon4, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [item4, item3, item2, item1]
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

