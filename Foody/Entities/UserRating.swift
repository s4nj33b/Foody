//
//  UserRating.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation

public final class UserRating: NSObject,NSCoding {
    
    private struct SerializationKeys {
        static let ratingText = "rating_text"
        static let ratingColor = "rating_color"
        static let aggregateRating = "aggregate_rating"
        static let votes = "votes"
    }
    
    public var ratingText: String?
    public var ratingColor: String?
    public var aggregateRating: String?
    public var votes: Int?

    init(ratingText: String?, ratingColor: String?, aggregateRating: String?, votes: Int?) {
        self.ratingText = ratingText
        self.ratingColor = ratingColor
        self.aggregateRating = aggregateRating
        self.votes = votes
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.ratingText = aDecoder.decodeObject(forKey: SerializationKeys.ratingText) as? String
        self.ratingColor = aDecoder.decodeObject(forKey: SerializationKeys.ratingColor) as? String
        self.aggregateRating = aDecoder.decodeObject(forKey: SerializationKeys.aggregateRating) as? String
        self.votes = aDecoder.decodeObject(forKey: SerializationKeys.votes) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(ratingText, forKey: SerializationKeys.ratingText)
        aCoder.encode(ratingColor, forKey: SerializationKeys.ratingColor)
        aCoder.encode(aggregateRating, forKey: SerializationKeys.aggregateRating)
        aCoder.encode(votes, forKey: SerializationKeys.votes)
    }
}

extension UserRating : Decodable{
    
    enum UserRatingSerializationKeys : String,CodingKey {
        case ratingText = "rating_text"
        case ratingColor = "rating_color"
        case aggregateRating = "aggregate_rating"
        case votes = "votes"
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserRatingSerializationKeys.self)
        
        let ratingText = try container.decodeIfPresent(String.self, forKey: .ratingText)
        let ratingColor = try container.decodeIfPresent(String.self, forKey: .ratingColor)
        let aggregateRating = try container.decodeIfPresent(String.self, forKey: .aggregateRating)
        let votes = try container.decodeIfPresent(Int.self, forKey: .votes)
        
        self.init(ratingText: ratingText, ratingColor: ratingColor, aggregateRating: aggregateRating, votes: votes)
    }
    
}
