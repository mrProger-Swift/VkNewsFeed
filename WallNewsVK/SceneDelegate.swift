//
//  SceneDelegate.swift
//  WallNewsVK
//
//  Created by User on 06.01.2021.
//

import UIKit
import VK_ios_sdk
class SceneDelegate: UIResponder, UIWindowSceneDelegate { 
    
    var window: UIWindow?
    
    static var shared: SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sd: SceneDelegate = ((scene?.delegate as! SceneDelegate))
        return sd
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url =  URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
            
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        if VKSdk.accessToken() == nil {
            let authVC = UIStoryboard(name: "Auth",
                                      bundle: nil).instantiateInitialViewController() as! AuthViewController
            window?.rootViewController = authVC
            window?.makeKeyAndVisible()
        }
    }
    
    public func replaceRoot(controller: UIViewController) {
        window?.rootViewController = controller
    }
}
