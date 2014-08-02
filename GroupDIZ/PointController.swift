//
//  PointController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 7/19/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class PointController: UIViewController {
    
    var pointData: NSDictionary!
    
    @IBOutlet weak var pointUser: UILabel!
    @IBOutlet weak var createAt: UILabel!
    @IBOutlet weak var pointTitle: UILabel!
    @IBOutlet weak var pointDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pointTitle.text = self.pointData.objectForKey("title")  as NSString
        self.pointUser.text = self.pointData.objectForKey("username")  as NSString
        self.createAt.text = self.pointData.objectForKey("created_at")  as NSString
        self.pointDescription.text = self.pointData.objectForKey("description")  as NSString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

