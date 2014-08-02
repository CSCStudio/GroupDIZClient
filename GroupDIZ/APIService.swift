//
//  APIService.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 7/19/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

@objc protocol APIServiceDelegate {
    func didReceiveResults(data: NSDictionary)
}

class APIService: NSObject {

    var delegate:APIServiceDelegate?
    var username:NSString?
    
    func userIdentifier() -> NSNumber {
        let identifier = UIDevice.currentDevice().respondsToSelector(Selector("identifierForVendor"))
        return identifier
    }
    
    func onSub(url:String, method:NSString = "Get", data:NSMutableData = NSMutableData()) {
        let nsUrl = NSURL(string: url)
        let request = NSMutableURLRequest(URL: nsUrl)
        request.HTTPMethod = method
        if (data.length > 0) {
            request.HTTPBody = data
        }
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(
            response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            self.delegate?.didReceiveResults(result)
        })
    }
}