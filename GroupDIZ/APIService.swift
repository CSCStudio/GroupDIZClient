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
    optional func didReceiveError(error: NSError)
}

class APIService: NSObject {

    var delegate:APIServiceDelegate?
    var username:NSString?
    class var baseUrl:String {
        return "http://zuoyouba.com/api/v0/1"
    }
    
    func userIdentifier() -> NSNumber {
        let identifier = UIDevice.currentDevice().respondsToSelector(Selector("identifierForVendor"))
        return identifier
    }
    
    func initializeRequestManager() -> AFHTTPRequestOperationManager {
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        // other request settings
        // manager.requestSerializer.setValue("608c6c08443c6d933576b90966b727358d0066b4", forHTTPHeaderField: "X-Auth-Token")
        return manager
    }
    
    func handleResponse(responseObject: AnyObject) {
        if (responseObject.isKindOfClass(NSDictionary)){
            self.delegate?.didReceiveResults(responseObject as NSDictionary)
        } else {
            // not valid response, eg: nil
            println("response not valid")
        }
    }
    
    func handleError(error: NSError) {
        println("code: \(error.code)")
        println("description: \(error.localizedDescription)")
        self.delegate?.didReceiveError?(error)
    }
    
    // for parameters input, use NSDictionary and encode with AFJSONRequestSerializer
    // let parameters = {"user":"admin", "password":"123456"}
    func get(url:String, baseUrl:String = baseUrl, parameters:NSDictionary = NSDictionary()) {
        let requestUrl = baseUrl + url
        let manager = initializeRequestManager()
        manager.GET(requestUrl, parameters: parameters,
            success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                self.handleResponse(responseObject)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                self.handleError(error)
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
                self.handleError(error)
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
                self.handleError(error)
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
                self.handleError(error)
            }
        )
    }
}