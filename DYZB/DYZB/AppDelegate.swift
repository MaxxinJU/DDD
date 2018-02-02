//
//  AppDelegate.swift
//  DYZB
//
//  Created by maxine on 2018/1/19.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit
//第一部分（大数据）：http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1517390457881
//第二部分（热门）：http://capi.douyucdn.cn/api/v1/getVerticalRoom
//第三部分（多个组）：http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&amp;offset=0&amp;time=1474252024
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow.init()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = DTabbarController()
        window?.makeKeyAndVisible()
        
        //tabbar的设置
        UITabBar.appearance().tintColor = UIColor.orange
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

