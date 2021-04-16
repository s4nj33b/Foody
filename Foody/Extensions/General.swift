//
//  General.swift
//  Foody
//
//  Created by Sanjeeb on 13/04/21.
//

import Foundation

public func DLog(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(items, separator: separator, terminator: terminator)
    #endif
}
