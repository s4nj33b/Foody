//
//  DetailViewController.swift
//  Foody
//
//  Created by Sanjeeb on 15/04/21.
//

import UIKit
import MapKit

final class DetailViewController: UIViewController {
    
    struct Data {
        let restaurant: Restaurant
    }
    
    @IBOutlet private(set) weak var restaurantImageView: UIImageView!
    @IBOutlet private(set) weak var restaurantName: UILabel!
    @IBOutlet private(set) weak var restaurantLocalityVerbose: UILabel!
    @IBOutlet private(set) weak var restaurantRatingButton: UIButton!
    @IBOutlet private(set) weak var restaurantHasOnlineDeliveryImageView: UIImageView!
    @IBOutlet private(set) weak var restaurantHasTableBookingImageView: UIImageView!
    @IBOutlet private(set) weak var restaurantCuisines: UILabel!
    @IBOutlet private(set) weak var restaurantAverageCost: UILabel!
    @IBOutlet private(set) weak var restaurantAddress: UILabel!
    
    let data: Data
    
    init(data: Data) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
        loadViewIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func didTapOnBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnGetDirection() {
        guard let lat = data.restaurant.location?.latitude,
              let long = data.restaurant.location?.longitude
        else {
            return
        }
        
        let latitude: CLLocationDegrees =  Double(lat)!
        let longitude: CLLocationDegrees =  Double(long)!
        
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = data.restaurant.name ?? "Restaurant"
        mapItem.openInMaps(launchOptions:options)
        
    }
}
extension DetailViewController{
    
    func setupUI() {
        let restaurant = data.restaurant
        let imageUrl = (restaurant.featuredImage ?? "").replacingOccurrences(of: "?output-format=webp", with: "")
        DispatchQueue.global(qos: .userInitiated).async {
            CacheManager.shared.getImageFromLocalCache(forUrl: imageUrl) { [weak self] (response) in
                response.callBlocks { (error) in
                    DLog("Error: \(error)")
                } successblock: { (image) in
                    DispatchQueue.main.async { [weak self] in
                        self?.restaurantImageView.image = image
                    }
                }
                
            }
        }
        
        if let name = restaurant.name {
            self.restaurantName.text = name
        }
        
        if let localityVerbose = restaurant.location?.localityVerbose {
            self.restaurantLocalityVerbose.text = localityVerbose
        }
        
        if let rating = restaurant.userRating?.aggregateRating {
            let votes = restaurant.userRating?.votes ?? 0
            self.restaurantRatingButton.setTitle("\(rating)★ | \(votes) ", for: .normal)
        }
        
        if let ratingColor = restaurant.userRating?.ratingColor {
            self.restaurantRatingButton.backgroundColor = UIColor.init(hex: "#\(ratingColor)")
        } else {
            self.restaurantRatingButton.backgroundColor = UIColor.init(hex: "#008000")
        }
        
        if let cuisines = restaurant.cuisines {
            self.restaurantCuisines.text = cuisines
        }
        
        if let cost = restaurant.averageCostForTwo{
            self.restaurantAverageCost.text = "₹ \(cost) for two (approx.)"
        }
        
        if let address = restaurant.location?.address{
            self.restaurantAddress.text = address
        }
        if restaurant.hasOnlineDelivery == 1 {
            self.restaurantHasOnlineDeliveryImageView.image = UIImage(named: "check")
        } else {
            self.restaurantHasOnlineDeliveryImageView.image = UIImage(named: "cross")
        }
        if restaurant.hasTableBooking == 1 {
            self.restaurantHasTableBookingImageView.image = UIImage(named: "check")
        } else {
            self.restaurantHasTableBookingImageView.image = UIImage(named: "cross")
        }
    }
    
}
