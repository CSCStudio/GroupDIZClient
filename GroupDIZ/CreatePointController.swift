//
//  CreatePointController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 7/19/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

protocol CreatePointDelegate {
    func didCreatePoint(point: AnyObject)
}

class CreatePointController: UIViewController {

    // MARK: Properties
    var apiService: APIService = APIService()
    var delegate: CreatePointDelegate?
    var topic_id: Int!
    
    @IBOutlet weak var titleField: UITextView!
    @IBOutlet weak var descriptionField: UITextView!
    
    // MARK: Actions
    @IBAction func cancelCreatePoint(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCreataePoint(sender: AnyObject) {
        let title = self.titleField.text
        if title.isEmpty{
            let alertView = UIAlertView(title: "Please Input Title", message: description, delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }else{
            let parameters = ["title": title, "description": self.descriptionField.text, "topic_id": topic_id,  "identifier": APIService.identifier]
            apiService.post("/users/join_topic", parameters:parameters)
        }
    }
    
    // MARK: Override View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}