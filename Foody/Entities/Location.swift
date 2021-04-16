//
//  Location.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation

public final class Location: NSObject, NSCoding {
    
    private struct SerializationKeys {
        static let cityId = "city_id"
        static let locality = "locality"
        static let city = "city"
        static let latitude = "latitude"
        static let localityVerbose = "locality_verbose"
        static let address = "address"
        static let countryId = "country_id"
        static let longitude = "longitude"
        static let zipcode = "zipcode"
        static let title = "title"
    }
   
    public var cityId: Int?
    public var locality: String?
    public var city: String?
    public var latitude: String?
    public var localityVerbose: String?
    public var address: String?
    public var countryId: Int?
    public var longitude: String?
    public var zipcode: String?
    public var title: String?

    init(cityId: Int?, locality: String?, city: String?, latitude: String?, localityVerbose: String?, address: String?, countryId: Int?, longitude: String?, zipcode: String?, title: String?){
    
        self.cityId = cityId
        self.locality = locality
        self.city = city
        self.latitude = latitude
        self.localityVerbose = localityVerbose
        self.address = address
        self.countryId = countryId
        self.longitude = longitude
        self.zipcode = zipcode
        self.title = title
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.cityId = aDecoder.decodeObject(forKey: SerializationKeys.cityId) as? Int
        self.locality = aDecoder.decodeObject(forKey: SerializationKeys.locality) as? String
        self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? String
        self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? String
        self.localityVerbose = aDecoder.decodeObject(forKey: SerializationKeys.localityVerbose) as? String
        self.address = aDecoder.decodeObject(forKey: SerializationKeys.address) as? String
        self.countryId = aDecoder.decodeObject(forKey: SerializationKeys.countryId) as? Int
        self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? String
        self.zipcode = aDecoder.decodeObject(forKey: SerializationKeys.zipcode) as? String
        self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(cityId, forKey: SerializationKeys.cityId)
        aCoder.encode(locality, forKey: SerializationKeys.locality)
        aCoder.encode(city, forKey: SerializationKeys.city)
        aCoder.encode(latitude, forKey: SerializationKeys.latitude)
        aCoder.encode(localityVerbose, forKey: SerializationKeys.localityVerbose)
        aCoder.encode(address, forKey: SerializationKeys.address)
        aCoder.encode(countryId, forKey: SerializationKeys.countryId)
        aCoder.encode(longitude, forKey: SerializationKeys.longitude)
        aCoder.encode(zipcode, forKey: SerializationKeys.zipcode)
        aCoder.encode(title, forKey: SerializationKeys.title)
    }
}
extension Location : Decodable {
    
    enum LocationSerializationKeys : String,CodingKey {
        case cityId = "city_id"
        case locality = "locality"
        case city = "city"
        case latitude = "latitude"
        case localityVerbose = "locality_verbose"
        case address = "address"
        case countryId = "country_id"
        case longitude = "longitude"
        case zipcode = "zipcode"
        case title = "title"
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LocationSerializationKeys.self)
        
        let cityId = try container.decodeIfPresent(Int.self, forKey: .cityId)
        let locality = try container.decodeIfPresent(String.self, forKey: .locality)
        let city = try container.decodeIfPresent(String.self, forKey: .city)
        let latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        let localityVerbose = try container.decodeIfPresent(String.self, forKey: .localityVerbose)
        let address = try container.decodeIfPresent(String.self, forKey: .address)
        let countryId = try container.decodeIfPresent(Int.self, forKey: .countryId)
        let longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
        let zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)
        let title = try container.decodeIfPresent(String.self, forKey: .title)
        self.init(cityId: cityId, locality: locality, city: city, latitude: latitude, localityVerbose: localityVerbose, address: address, countryId: countryId, longitude: longitude, zipcode: zipcode, title: title)
    }
    
}
