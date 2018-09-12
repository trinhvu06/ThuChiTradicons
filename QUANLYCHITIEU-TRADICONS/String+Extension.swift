//
//  String+Extension.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/8/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import Foundation
extension String {
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
}
