//
//  UIManager.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/8/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import Foundation
import UIKit

class UIManager {
    
    static func goToAuthenticatedController() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as? MainViewController
        {
            UIApplication.shared.keyWindow?.rootViewController = controller
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }

    }
    
    static func goToAuthenticationController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        {
            UIApplication.shared.keyWindow?.rootViewController = vc
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }

    }
    
}
