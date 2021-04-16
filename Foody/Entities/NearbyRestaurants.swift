//
//  NearbyRestaurants.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation

public final class NearbyRestaurants : NSObject, NSCoding {
    
    private struct SerializationKeys {
        static let restaurant = "restaurant"
    }

    public var restaurant: Restaurant?
    
    init(restaurant: Restaurant?) {
        self.restaurant = restaurant
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.restaurant = aDecoder.decodeObject(forKey: SerializationKeys.restaurant) as? Restaurant
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(restaurant, forKey: SerializationKeys.restaurant)
    }
}

extension NearbyRestaurants : Decodable {
    
    enum NearbyRestaurantsSerializationKeys : String, CodingKey {
        case restaurant = "restaurant"
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NearbyRestaurantsSerializationKeys.self)
        
        let restaurant = try container.decodeIfPresent(Restaurant.self, forKey: .restaurant)
        self.init(restaurant: restaurant)
    }
    
}


