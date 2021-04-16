//
//  RestaurantTableViewCell.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @objc dynamic var restaurant : Restaurant? = nil

    var restaurantImageUrl : String = ""
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantCuisine: UILabel!
    @IBOutlet weak var restaurantCostForTwo: UILabel!
    @IBOutlet weak var restaurantRating: UIButton!
    
    func setFor(restaurant: Restaurant) {
        self.restaurantName.text = restaurant.name
        self.restaurantCuisine.text = restaurant.cuisines
        self.restaurantCostForTwo.text = "₹ \(restaurant.averageCostForTwo ?? 0) for two persons"
        self.restaurantRating.setTitle(restaurant.userRating?.aggregateRating  ?? "", for: .normal)
        self.restaurantRating.backgroundColor = UIColor.init(hex: "#\(restaurant.userRating?.ratingColor ?? "#008000")")
        restaurantImage.roundCorners(corners: [.topLeft, .bottomLeft], radius: 6)
        restaurantImage.image = UIImage(named: "ImgPlaceholder")
        if let thumbUrl = restaurant.thumb {
            DispatchQueue.global(qos: .userInitiated).async {
                let url = thumbUrl.replacingOccurrences(of: "?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A", with: "")
                CacheManager.shared.getImageFromLocalCache(forUrl: url) { [weak self] (response) in
                    response.callBlocks { (error) in
                        DLog("Error: \(error)")
                    } successblock: { (image) in
                        DispatchQueue.main.async { [weak self] in
                            self?.restaurantImage.image = image
                        }
                    }

                }
            }
            
        }
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    
}
extension UIImageView {
    func loadThumbnailImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
