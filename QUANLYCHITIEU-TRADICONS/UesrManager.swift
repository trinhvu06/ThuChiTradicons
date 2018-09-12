//
//  UesrManager.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/8/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class UserManager {
    
    static let share: UserManager = UserManager()
    
    private init(){
        
    }
    
    public func getCurrenUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func signOut() {
        try! Auth.auth().signOut()
        FBSDKLoginManager().logOut()
        GIDSignIn.sharedInstance().signOut()
        
        UIManager.goToAuthenticationController()
    }
}
