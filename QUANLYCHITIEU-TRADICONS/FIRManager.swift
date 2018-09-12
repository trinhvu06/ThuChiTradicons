//
//  FIRManager.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/8/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FIRManager {
    
    static let shared: FIRManager = FIRManager()
    
    let accCount: DatabaseReference
    var userRef: DatabaseReference {
        return accCount.child("users")
    }
    
    var myUserRef :DatabaseReference{
    
        return userRef.child(UserManager.share.getCurrenUser()?.uid ?? "i")
        
    }
    
    let cost : DatabaseReference
    var userCost : DatabaseReference{
        return cost.child("cost")
    }
    
    private init() {
        accCount = Database.database().reference().child("hellofirebaseapp")
        cost = Database.database().reference().child("hellofirebaseapp")
    }
    
}
