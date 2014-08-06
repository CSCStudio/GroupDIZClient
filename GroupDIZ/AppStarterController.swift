//
//  AppStarterController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 8/2/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class AppStarterController: UIViewController, APIServiceDelegate, UserSettingsDelegate {
    
    // MARK: Properties
    var apiService: APIService = APIService()
    var topicList: NSArray = NSArray()
    
    // MARK: Delegate Functions
    func didReceiveResults(response: NSDictionary) {
        if (response.objectForKey("nickname")) {
            self.topicList = response.objectForKey("topics") as NSArray
            self.performSegueWithIdentifier("goToList", sender: self)
        } else {
            self.performSegueWithIdentifier("goToSettings", sender: self)
        }
    }
    
    func didReceiveError(description: String) {
        let alertView = UIAlertView(title: "Error", message: description, delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    // TODO: modify API to return topics as well when setup nickname
    func updateSettings() {
        self.dismissViewControllerAnimated(false, completion: {() in
            self.performSegueWithIdentifier("goToList", sender: self)
        })
    }
    
    // MARK: Private Functions
    private func checkNameAndTopics() {
        apiService.get("/users/\(APIService.identifier)")
    }

    // MARK: Override View Functions
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue?.identifier == "goToList") {
            let topicListController = segue.destinationViewController as TopicListController
            topicListController.topicList = self.topicList.mutableCopy() as NSMutableArray
        } else if (segue?.identifier == "goToSettings") {
            let userSettingsController = segue.destinationViewController as UserSettingsController
            userSettingsController.delegate = self
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