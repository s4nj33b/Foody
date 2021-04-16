//
//  SearchResult.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation


public final class SearchResult: NSObject, NSCoding {
    
    private struct SerializationKeys {
        static let link = "link"
        static let popularity = "popularity"
        static let location = "location"
        static let nearbyRestaurants = "nearby_restaurants"
    }
    
    public var link: String?
    public var popularity: Popularity?
    public var location: Location?
    public var nearbyRestaurants: [NearbyRestaurants]?
    
    init(link: String?, popularity: Popularity?, location: Location?, nearbyRestaurants: [NearbyRestaurants]?) {
        self.link = link
        self.popularity = popularity
        self.location = location
        self.nearbyRestaurants = nearbyRestaurants
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.link = aDecoder.decodeObject(forKey: SerializationKeys.link) as? String
        self.popularity = aDecoder.decodeObject(forKey: SerializationKeys.popularity) as? Popularity
        self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? Location
        self.nearbyRestaurants = aDecoder.decodeObject(forKey: SerializationKeys.nearbyRestaurants) as? [NearbyRestaurants]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(link, forKey: SerializationKeys.link)
        aCoder.encode(popularity, forKey: SerializationKeys.popularity)
        aCoder.encode(location, forKey: SerializationKeys.location)
        aCoder.encode(nearbyRestaurants, forKey: SerializationKeys.nearbyRestaurants)
    }
}

extension SearchResult : Decodable {
    
    enum SearchResultSerializationKeys : String, CodingKey {
        case link = "link"
        case popularity = "popularity"
        case location = "location"
        case nearbyRestaurants = "nearby_restaurants"
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchResultSerializationKeys.self)
        
        let link = try container.decodeIfPresent(String.self, forKey: .link)
        let popularity = try container.decodeIfPresent(Popularity.self, forKey: .popularity)
        let location = try container.decodeIfPresent(Location.self, forKey: .location)
        let nearbyRestaurants = try container.decodeIfPresent([NearbyRestaurants].self, forKey: .nearbyRestaurants)
        
        self.init(link: link, popularity: popularity, location: location, nearbyRestaurants: nearbyRestaurants)
    }
}
