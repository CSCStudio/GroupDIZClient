//
//  APIService.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 7/19/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import Foundation

@objc protocol APIServiceDelegate {
    func didReceiveResults(data: NSDictionary)
}

class APIService: NSObject {

    var delegate:APIServiceDelegate?
    
    func getTopicList(url:String) {
        let nsUrl = NSURL(string: url)
        let request = NSURLRequest(URL: nsUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(
            response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            self.delegate?.didReceiveResults(result)
        })
    }
}