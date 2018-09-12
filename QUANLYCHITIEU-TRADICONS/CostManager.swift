//
//  costManager.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/10/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import Foundation
import Firebase


class CostManager {
    
    static let shared: CostManager = CostManager()
    
    private init(){
        
    }
    
    public func getCurrenUser() -> User? {
        return Auth.auth().currentUser
    }
    
}
