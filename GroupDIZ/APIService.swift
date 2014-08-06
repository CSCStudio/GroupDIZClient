//
//  APIService.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 7/19/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

@objc protocol APIServiceDelegate {
    func didReceiveResults(response: NSDictionary)
    optional func didReceiveError(description: String)
}

class APIService: NSObject {

    // MARK: Properties
    var delegate:APIServiceDelegate?
    
    class var baseUrl:String {
        return "http://zuoyouba.com/api/v0/1"
//        return "http://0.0.0.0:3000/api/v0/1"
    }
    
    class var identifier:String {
        let identifierForVendor = UIDevice.currentDevice().identifierForVendor
        let identifier = identifierForVendor.UUIDString
        return identifier
    }
    
    // MARK: Private Functions
    private func initializeRequestManager() -> AFHTTPRequestOperationManager {
        let manager = AFHTTPRequestOperationManager()
        
        // setup requset and response serializer with json format
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
//        manager.reachabilityManager.startMonitoring()
//        manager.reachabilityManager.setReachabilityStatusChangeBlock{(status:AFNetworkReachabilityStatus) in
//            switch (status) {
//            // case AFNetworkReachabilityStatus.ReachableViaWiFi:
//            // case AFNetworkReachabilityStatus.ReachableViaWWAN:
//            case AFNetworkReachabilityStatus.NotReachable:
//                manager.operationQueue.suspended = true
//                let description = "Network not available!"
//                self.delegate?.didReceiveError?(description)
//            default:
//                manager.operationQueue.suspended = false
//            }
//        }
//         manager.requestSerializer.setValue("608c6c08443c6d933576b90966b727358d0066b4", forHTTPHeaderField: "X-Auth-Token")
        
        return manager
    }
    
    private func handleResponse(responseObject: AnyObject?) {
        if let response:NSDictionary = responseObject as? NSDictionary {
            self.delegate?.didReceiveResults(responseObject as NSDictionary)
        } else {
            // not valid response, eg: nil
            println("response not valid")
        }
    }
    
    private func handleError(error: NSError, responseObject: AnyObject?) {
        var description = error.localizedDescription
        if let response:NSDictionary = responseObject as? NSDictionary {
            if (response.objectForKey("message")) {
                description = response.objectForKey("message") as String
            }
        }
        self.delegate?.didReceiveError?(description)
    }
    
    // MARK: Functions
    func get(url:String, baseUrl:String = baseUrl, parameters:NSDictionary = NSDictionary()) {
        let requestUrl = baseUrl + url
        let manager = initializeRequestManager()
        manager.GET(requestUrl, parameters: parameters,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                self.handleResponse(responseObject)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                self.handleError(error, responseObject: operation.responseObject)
            }
        )
    }
    
    func post(url:String, baseUrl:String = baseUrl, parameters:NSDictionary) {
        let requestUrl = baseUrl + url
        let manager = initializeRequestManager()
        manager.POST(requestUrl, parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                self.handleResponse(responseObject)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                self.handleError(error, responseObject: operation.responseObject)
            }
        )
    }
    
    func put(url:String, baseUrl:String = baseUrl, parameters:NSDictionary) {
        let requestUrl = baseUrl + url
        let manager = initializeRequestManager()
        manager.PUT(requestUrl, parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                self.handleResponse(responseObject)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                self.handleError(error, responseObject: operation.responseObject)
            }
        )
    }
    
    func delete(url:String, baseUrl:String = baseUrl, parameters:NSDictionary = NSDictionary()) {
        let requestUrl = baseUrl + url
        let manager = initializeRequestManager()
        manager.DELETE(requestUrl, parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                self.handleResponse(responseObject)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                self.handleError(error, responseObject: operation.responseObject)
            }
        )
    }
}