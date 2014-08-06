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
    
    func didReceiveResults(response: NSDictionary) {
        if (response.objectForKey("nickname")) {
            self.topicList = response.objectForKey("topics") as NSArray
            self.performSegueWithIdentifier("goToList", sender: self)
        } else {
            self.performSegueWithIdentifier("goToSettings", sender: self)
        }
    }
    
    func checkNameAndTopics() {
        apiService.get("/users/\(APIService.identifier)")
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