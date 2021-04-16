//
//  Photos.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation

public final class Photos : NSObject, NSCoding {
    
    private struct SerializationKeys {
        static let photo = "photo"
    }
    
    public var photo: Photo?
    
    init(photo: Photo?){
        self.photo = photo
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.photo = aDecoder.decodeObject(forKey: SerializationKeys.photo) as? Photo
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(photo, forKey: SerializationKeys.photo)
    }
}

extension Photos: Decodable {
    
    enum PhotosSerializationKeys : String,CodingKey {
        case photo = "photo"
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotosSerializationKeys.self)
        let photo = try container.decodeIfPresent(Photo.self, forKey: .photo)
        self.init(photo: photo)
    }
}


