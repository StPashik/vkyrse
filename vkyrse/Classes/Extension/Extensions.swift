//
//  Extensions.swift
//  vkyrse
//
//  Created by StPashik on 30.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit

extension CustomStringConvertible {
    var description : String {
        var description: String = ""
        if self is AnyObject {
            description = "***** \(self.dynamicType) - <\(unsafeAddressOf((self as! AnyObject)))>***** \n"
        } else {
            description = "***** \(self.dynamicType) *****\n"
        }
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}

extension NSDateFormatter
{
    static func dateFormatterWithDateFormat(aDateFormat:String) -> NSDateFormatter
    {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = aDateFormat
        
        return dateFormatter
    }
}

extension NSDate
{
    public func formattedStringWithFormat(format:String?) -> String{
        let isFormat:Bool = format != nil
        let dateFormatter: NSDateFormatter = NSDateFormatter.dateFormatterWithDateFormat(isFormat ? format! : "d.MM.yyyy")
        
        return dateFormatter.stringFromDate(self)
    }
    
}

extension String
{
    public func formatToDate(format: String?) -> NSDate
    {
        let isFormat:Bool = format != nil
        let dateFormatter: NSDateFormatter = NSDateFormatter.dateFormatterWithDateFormat(isFormat ? format! : "d.MM.yyyy")
        
        return dateFormatter.dateFromString(self)!
    }
}