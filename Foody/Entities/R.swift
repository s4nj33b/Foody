//
//  R.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation

public final class R: NSObject, NSCoding {
    
    private struct SerializationKeys {
        static let resId = "res_id"
    }
    
    public var resId: Int?
    
    init(resId: Int?){
        self.resId = resId
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.resId = aDecoder.decodeObject(forKey: SerializationKeys.resId) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(resId, forKey: SerializationKeys.resId)
    }
}

extension R : Decodable{
    
    enum RSerializationKeys : String, CodingKey {
        case resId = "res_id"
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RSerializationKeys.self)
        let resId = try container.decodeIfPresent(Int.self, forKey: .resId)
        self.init(resId: resId)
    }

}
