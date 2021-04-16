//
//  UrlConstants.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation
class UrlConstant: NSObject {

    static var zomatoBaseUrl: String {
        return "https://developers.zomato.com/api/"
    }
    
    static var zomatoApiVersion: String {
        return "2.1"
    }
    
    static var zomationUserkey: String{
        return "4feaa2167c4dc6beadf629319423bd4b"
    }
    
    static func getRestrauntsUrlBasedOn(lat: String, long: String) -> String {
        return zomatoBaseUrl+"v"+zomatoApiVersion+"/geocode?lat=\(lat)&lon=\(long)"
    }

}
