//
//  UserSettingsController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 8/2/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class UserSettingsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let identifier = UIDevice.currentDevice().respondsToSelector(Selector("identifierForVendor"))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}