//
//  ViewController.swift
//  WallNewsVK
//
//  Created by User on 06.01.2021.
//



protocol AuthServiceDelegate : class {
    func vkSdkShouldPresent(controller: UIViewController)
    func vkSdkAccessAuthorizationFinished()
    func vkSdkAccessAuthorizationError()
}

import UIKit
import VK_ios_sdk
class AuthService:  NSObject, VKSdkUIDelegate, VKSdkDelegate {
    
    var  authVC = AuthViewController()
    
    weak var delegate : AuthServiceDelegate?
    
    var token : String? {
        return VKSdk.accessToken()?.accessToken
    }
    var userId: String? {
        return VKSdk.accessToken()?.userId
    }
    
    var id = "7727959"
    var vkSdk : VKSdk
    
    static let shared = AuthService()
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: id)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        SceneDelegate.shared.replaceRoot(controller: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print (#function)
        
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            let feedVC = UIStoryboard(name: "NewsfeedViewController",
                                      bundle: nil).instantiateInitialViewController() as! NewsfeedViewController
            let navVC = UINavigationController(rootViewController: feedVC)
            navVC.navigationBar.backgroundColor = .white
            SceneDelegate.shared.replaceRoot(controller: navVC)
        } else {
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
    }
    
    
    func wakeUpSession() {
        let scope = ["wall", "friends"]
        VKSdk.authorize(scope)
    }
}

