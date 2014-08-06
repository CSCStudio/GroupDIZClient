//
//  CreateTopicController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 7/19/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

protocol CreateTopicDelegate {
    func didCreateTopic(topic: AnyObject)
}

class CreateTopicController: UIViewController, APIServiceDelegate {
    
    // MARK: Properties
    var apiService: APIService = APIService()
    var delegate: CreateTopicDelegate?
    @IBOutlet weak var titleField: UITextView!
    @IBOutlet weak var descriptionField: UITextView!
    
    // MARK: Actions
    @IBAction func createTopic(sender: AnyObject) {
        if let title = self.titleField.text {
            let description = self.descriptionField.text
            let parameters = ["title": title, "description": description, "identifier": APIService.identifier]
            apiService.post("/topics", parameters:parameters)
        }
    }
    
    @IBAction func cancelCreateTopic(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Delegate Functions
    func didReceiveResults(response: NSDictionary) {
        self.delegate?.didCreateTopic(response)
    }
    
    func didReceiveError(description: String) {
        let alertView = UIAlertView(title: "Error", message: description, delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    // MARK: Override View Functions
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