//
//  ZomatoEvents.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation

public final class ZomatoEvents:NSObject, NSCoding {
    
    private struct SerializationKeys {
        static let event = "event"
    }
    
    public var event: Event?
    
    init(event: Event?) {
        self.event = event
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.event = aDecoder.decodeObject(forKey: SerializationKeys.event) as? Event
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(event, forKey: SerializationKeys.event)
    }
}

extension ZomatoEvents: Decodable {
    
    enum ZomatoEventsSerializationKeys: String,CodingKey {
        case event = "event"
    }
    
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ZomatoEventsSerializationKeys.self)
        let event = try container.decodeIfPresent(Event.self, forKey: .event)
        self.init(event: event)
    }
}
