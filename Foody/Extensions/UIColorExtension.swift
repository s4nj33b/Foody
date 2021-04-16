//
//  UIColorExtension.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let rgbValue = Utility.intFromHexString(hexStr: hex)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }

    
}
