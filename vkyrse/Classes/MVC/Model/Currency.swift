//
//  Currency.swift
//  vkyrse
//
//  Created by StPashik on 29.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit
import SwiftyJSON

class Currency: CustomStringConvertible {
    
    let baseCurrency: String
    let compareCurrency: String
    let rate: Float
    let lastUpdate: NSDate
    
    var percents: Int = 0
    
    var titleCompare: String {
        return "\(baseCurrency)->\(compareCurrency)"
    }
    
    init(info: JSON)
    {
        self.baseCurrency = info["base"].stringValue
        self.compareCurrency = Array(info["rates"].dictionaryValue.keys)[0]
        self.rate = info["rates"][self.compareCurrency].floatValue
        
        self.lastUpdate = NSDate()
    }
    
    class func getCurrency(base: String, compare: String, complete: ((currency: Currency) -> Void)!, failure: ((error: NSError) -> Void)!)
    {
        RequestManager.sharedInstance.getCurrency(base, compare: compare, success: { (responseObject) in
            
            let curr = Currency(info: responseObject)
            let yesterday = NSDate().dateByAddingTimeInterval(-24 * 60 * 60)
            
            RequestManager.sharedInstance.getCurrency(base, compare: compare, latest: false, date: yesterday, success: { (responseObject) in
                
                let percents = 100 * (responseObject["rates"][curr.compareCurrency].floatValue - curr.rate) / curr.rate
                curr.percents = Int(percents < 0 ? floor (percents) : ceil(percents))
                
                complete(currency: curr)
                
            }, failure: { (error) in
                
                failure(error: error)
                
            })
        }) { (error) in
            
            failure(error: error)
            
        }
    }
    
}