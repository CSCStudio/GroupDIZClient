//
//  JoinTopicController.swift
//  GroupDIZ
//
//  Created by songjiayang on 8/9/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class JoinTopicController : UIViewController, APIServiceDelegate {

    @IBOutlet weak var alertMessage: UILabel!
    @IBOutlet weak var groupCode: UITextField!
    
    var apiService: APIService = APIService()
    var delegate: CreateTopicDelegate?
    
    @IBAction func submit(sender: UIButton) {
        let code = groupCode.text
        if code.isEmpty{
            self.alertMessage.text = "Please Input Code!"
        }else{
            let parameters = ["code": code, "identifier": APIService.identifier]
            apiService.post("/users/join_topic", parameters:parameters)
        }
    }
    
    @IBAction func cancelCreateTopic(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //@Implement: Delegate Functions
    func didReceiveResults(response: NSDictionary) {
        self.delegate?.didCreateTopic(response)
    }
    
    func didReceiveError(errorMessage: String) {
        self.alertMessage.text = errorMessage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alertMessage.text = ""
        apiService.delegate = self
    }
}
