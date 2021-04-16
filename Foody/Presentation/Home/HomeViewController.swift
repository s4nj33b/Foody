//
//  HomeViewController.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private(set) weak var header: HomeViewHeader!
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var collectionContentView: UIView!
    @IBOutlet private(set) weak var indicator: UIActivityIndicatorView!
    
    
    var nearbyRestaurants: [NearbyRestaurants] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var offers: [Offer] = [
        Offer(brand: "theobroma", title: "40%", subTitle: "Off", thumbnailImage: UIImage(named: "ice")!),
        Offer(brand: "H & M", title: "Buy 1", subTitle: "Get 1 Free", thumbnailImage: UIImage(named: "hnm")!),
        Offer(brand: "taj hotel", title: "₹1000", subTitle: "Cashback", thumbnailImage: UIImage(named: "taj")!)
    ]
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(HomeCollectionViewCell.nib, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 10,
                                           bottom: 10,
                                           right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 6
        layout.itemSize = CGSize(width: 120, height: 140)
        
        return layout
    }
    
    private func setupCollectionViewUI() {
        self.collectionContentView.removeAllSubviews()
        self.collectionContentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.collectionContentView.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.collectionContentView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.collectionContentView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.collectionContentView.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RestaurantTableViewCell.nib, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        setupCollectionViewUI()
        getLocationAndFetchDataFromServer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        let restaurantWrapper : NearbyRestaurants = nearbyRestaurants[indexPath.row]
        if let restaurant = restaurantWrapper.restaurant {
            cell.setFor(restaurant: restaurant)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantWrapper : NearbyRestaurants = nearbyRestaurants[indexPath.row]
        if let restaurant = restaurantWrapper.restaurant {
            let data = DetailViewController.Data(restaurant: restaurant)
            let vc = DetailViewController(data: data)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
}
extension HomeViewController {
    func getLocationAndFetchDataFromServer() {
        indicator.startAnimating()
        LocationService.shared.determineCurrentLocation { [unowned self] (lat, long) in
            hitServiceToFetchNearbyRestaurants(forLat: lat, andLong: long) { [unowned self] (response) in
                response.callBlocks { (error) in
                    indicator.stopAnimating()
                    DLog("Error: \(error.localizedDescription)")
                } successblock: { (result) in
                    indicator.stopAnimating()
                    if let address = result.location?.title {
                        header.setFor(location: address)
                    }
                    if let nearbyRestaurantsV = result.nearbyRestaurants {
                        nearbyRestaurants = nearbyRestaurantsV
                    }
                }

            }
        } andErrorHandler: { (err) in
            DLog("Err: \(err)")
        }

    }
    
    func hitServiceToFetchNearbyRestaurants(forLat lat : String, andLong long:String, response: @escaping ResponseBlock<SearchResult>){
        
        let headerDic : [String : String] = [
            "user-key" : UrlConstant.zomationUserkey
        ]
        let urlString = UrlConstant.getRestrauntsUrlBasedOn(lat: lat, long: long)
        
        SessionService.shared.sendRequest(forUrl: urlString, requestType: "GET", headers: headerDic) { (responseV) in
            responseV.callBlocks { (error) in
                response(.error(value: error))
            } successblock: { (data) in
                do {
                    let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    response(.object(value: result))
                } catch {
                    response(.error(value: error))
                }
            }

        }

    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func dataAt(item: Int) -> Offer {
        return offers[item]
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }

        let item = dataAt(item: indexPath.item)
        cell.setFor(offer: item)
        return cell
    }
    
    
}
