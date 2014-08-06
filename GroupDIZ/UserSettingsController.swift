//
//  UserSettingsController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 8/2/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

protocol UserSettingsDelegate {
    func updateSettings()
}

class UserSettingsController: UIViewController, APIServiceDelegate {
    
    // MARK: Properties
    var apiService: APIService = APIService()
    var delegate:UserSettingsDelegate?
    @IBOutlet weak var nickNameField: UITextField!
    
    // MARK: Actions
    @IBAction func SubmitNickName(sender: AnyObject) {
        if let nickName = nickNameField.text {
            let parameters = ["nickname": nickName, "description": description, "identifier": APIService.identifier]
            apiService.post("/users", parameters:parameters)
        }
    }
    
    // MARK: Delegate Functions
    func didReceiveResults(data: NSDictionary) {
        self.delegate?.updateSettings()
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