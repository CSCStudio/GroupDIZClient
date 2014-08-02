//
//  UserSettingsController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 8/2/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class UserSettingsController: UIViewController, APIServiceDelegate {
    
    var apiService: APIService = APIService()
    
    @IBOutlet weak var nickNameField: UITextField!
    @IBAction func SubmitNickName(sender: AnyObject) {
        if let nickName = nickNameField.text {
            let identifierForVendor = UIDevice.currentDevice().identifierForVendor
            let identifier = identifierForVendor.UUIDString
            var data = NSMutableData()
            data.appendData("nickname=\(nickName)&identifier=\(identifier)".dataUsingEncoding(NSUTF8StringEncoding))
            apiService.onSub("http://zuoyouba.com/api/v0/1/users", method: "Post", data:data)
        }
    }
    
    func didReceiveResults(data: NSDictionary) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.delegate = self
        let identifier = UIDevice.currentDevice().respondsToSelector(Selector("identifierForVendor"))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}