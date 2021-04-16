//
//  HomeViewHeader.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import UIKit
@IBDesignable
final class HomeViewHeader: NibView {
    @IBOutlet private(set) weak var locationLabel: UILabel!
    
    func setFor(location: String) {
        locationLabel.text = location
    }
    
}
