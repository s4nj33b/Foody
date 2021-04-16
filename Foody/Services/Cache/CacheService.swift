//
//  CacheService.swift
//  Foody
//
//  Created by Sanjeeb on 15/04/21.
//

import UIKit

class CacheManager: NSObject {
    
    static var shared : CacheManager = CacheManager()
    
    let imageLocalCache = NSCache<NSString, UIImage>()
    
    func getImageFromLocalCache(forUrl url: String, response: @escaping ResponseBlock<UIImage>){
       
        if let image = self.imageLocalCache.object(forKey: NSString(string: url)) {
            response(.object(value: image))
            
        } else {
            //Download image if not found in cache
            let errorV = NSError(domain: "Typecasting failed.", code: -1, userInfo: nil)
            if let urlObject = URL(string: url) {
                do{
                    let data = try Data.init(contentsOf: urlObject)
                    if let resultImage = UIImage(data: data) {
                        self.imageLocalCache.setObject(resultImage, forKey: NSString.init(string: url))
                        response(.object(value: resultImage))
                    } else {
                        response(.error(value: errorV))
                    }
                } catch {
                    response(.error(value: error))
                }
            } else {
                response(.error(value: errorV))
            }
        }
    }
    
    func clearMemoryCache() {
        imageLocalCache.removeAllObjects()
    }

}
