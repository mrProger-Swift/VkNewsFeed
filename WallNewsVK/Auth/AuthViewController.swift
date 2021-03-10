//
//  AuthViewController.swift
//  WallNewsVK
//
//  Created by User on 07.01.2021.
//

import UIKit
import VK_ios_sdk
class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn(_ sender: Any) {
        AuthService.shared.wakeUpSession()
    }
}
