//
//  SessionService.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation

class SessionService: NSObject {
    static let shared: SessionService = SessionService()
    let kTimeOut = 150
    
    func sendRequest(forUrl url:String, requestType inRequestType : String, headers inHeaderDic : [String : String], response: @escaping ResponseBlock<Data>) {
        
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        let dataTaskUrl : URL? = URL.init(string: url)
        guard let url = dataTaskUrl else{
            let error = NSError(domain: "Data nil", code: -1, userInfo: nil)
            response(.error(value: error))
            return
        }
        
        let dataTaskRequest : NSMutableURLRequest = NSMutableURLRequest.init(url: url, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: TimeInterval(kTimeOut))
        let contentType : String = "application/JSON"
        
        dataTaskRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
        dataTaskRequest.httpMethod = inRequestType
        
        for (key,value) in inHeaderDic {
            dataTaskRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        let task = defaultSession.dataTask(with: dataTaskRequest as URLRequest) { (dataV, _, errorV) in
            if let err = errorV {
                response(.error(value: err))
            } else {
                response(.object(value: dataV!))
            }
        }
        task.resume()
    }
}
