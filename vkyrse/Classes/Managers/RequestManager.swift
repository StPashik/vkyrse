//
//  RequestManager.swift
//  vkyrse
//
//  Created by StPashik on 29.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let kServerStringURL = "http://api.fixer.io/"

extension Request {
    public func debugLog() -> Self {
        debugPrint(self)
        return self
    }
}

class RequestManager {

    class var sharedInstance: RequestManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: RequestManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = RequestManager()
        }
        return Static.instance!
    }
    
    private func basicRequestWithMethod(
        api:        String,
        parametrs:  [String : AnyObject],
        success:    ((responseObject: JSON!) -> Void)!,
        failure:    ((error: NSError) -> Void)!)
    {
        let address = "\(kServerStringURL)\(api)"
        
        Alamofire.request(.GET, address, parameters: parametrs)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                debugPrint(response.response)
                
                switch response.result {
                case .Success:
                    
                    success(responseObject: JSON(data: response.data!))
                    
                case .Failure(let error):
                    print(error)
                    
                    failure(error: response.result.error!)
                }
        }
    }
}

extension RequestManager {
    
    internal func getCurrency(base: String,
                              compare: String,
                              latest: Bool = true,
                              date: NSDate? = NSDate(),
                              success: ((responseObject: JSON!) -> Void)!,
                              failure: ((error: NSError) -> Void)!)
    {
        let parametrs = [
            "base" : base,
            "symbols" : compare
        ]
        
        let api = latest ? "latest" : date!.formattedStringWithFormat("yyyy-MM-dd")
        
        basicRequestWithMethod(api, parametrs: parametrs, success: { (responseObject) in
            
            success(responseObject: responseObject)
            
        }) { (error) in
            failure(error: error)
        }
    }
    
}
