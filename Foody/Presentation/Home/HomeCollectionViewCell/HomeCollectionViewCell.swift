//
//  HomeCollectionViewCell.swift
//  Foody
//
//  Created by Sanjeeb on 15/04/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cardBrandLabel: UILabel!
    @IBOutlet var cardOfferTitle: UILabel!
    @IBOutlet var cardOfferSubTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setFor(offer: Offer) {
        cardOfferTitle.text = offer.title
        imageView.image = offer.thumbnailImage
        cardBrandLabel.text = offer.brand.uppercased()
        cardOfferSubTitle.text = offer.subTitle
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    

}
