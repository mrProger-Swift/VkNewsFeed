//
//  AppDelegate.swift
//  WallNewsVK
//
//  Created by User on 06.01.2021.
//

import UIKit
import VK_ios_sdk
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url,
                          fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

