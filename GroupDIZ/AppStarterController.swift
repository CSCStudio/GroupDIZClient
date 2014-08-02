//
//  AppStarterController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 8/2/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class AppStarterController: UIViewController, APIServiceDelegate {
    
    var apiService: APIService = APIService()
    var topicList: NSArray = NSArray()
    
    func didReceiveResults(data: NSDictionary) {
        if (data.count == 0) {
            self.performSegueWithIdentifier("goToSettings", sender: self)
        } else {
            if (data.objectForKey("nickname")) {
                self.performSegueWithIdentifier("goToList", sender: self)
                self.topicList = data.objectForKey("topics") as NSArray
            } else {
                self.performSegueWithIdentifier("goToSettings", sender: self)
            }
        }
    }
    
    func checkNameAndTopics() {
        let identifierForVendor = UIDevice.currentDevice().identifierForVendor
        let identifier = identifierForVendor.UUIDString
        apiService.onSub("http://zuoyouba.com/api/v0/1/users/\(identifier)")
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue?.identifier == "goToList") {
            let topicListController = segue.destinationViewController as TopicListController
            topicListController.topicList = self.topicList
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.delegate = self
        checkNameAndTopics()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}