//
//  CreateTopicController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 7/19/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class CreateTopicController: UIViewController, APIServiceDelegate {
    
    var apiService: APIService = APIService()
    
    @IBOutlet weak var titleField: UITextView!
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBAction func createTopic(sender: AnyObject) {
        if let title = self.titleField.text {
            let description = self.descriptionField.text
            let identifierForVendor = UIDevice.currentDevice().identifierForVendor
            let identifier = identifierForVendor.UUIDString
            var data = NSMutableData()
            data.appendData("title=\(title)&description=\(description)&identifier=\(identifier)".dataUsingEncoding(NSUTF8StringEncoding))
            apiService.onSub("http://zuoyouba.com/api/v0/1/topics", method: "Post", data:data)
        }
    }
    
    @IBAction func cancelCreateTopic(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didReceiveResults(data: NSDictionary) {
        // topic = data.objectForKey("topic") as NSArray
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}