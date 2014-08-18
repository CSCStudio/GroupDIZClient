//
//  PointController.swift
//  GroupDIZ
//
//  Created by 陈晓光 on 7/19/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class ShowPointController: UIViewController, APIServiceDelegate {
    
    // MARK: Properties
    var pointData: NSDictionary!
    var apiService: APIService = APIService()
    
    @IBOutlet weak var pointUser: UILabel!
    @IBOutlet weak var createAt: UILabel!
    @IBOutlet weak var pointTitle: UILabel!
    @IBOutlet weak var pointDescription: UILabel!
    
    // MARK: Override View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.delegate = self
        self.pointTitle.text = self.pointData.objectForKey("title")  as NSString
        self.pointUser.text = self.pointData.objectForKey("username")  as NSString
        self.createAt.text = self.pointData.objectForKey("created_at")  as NSString
        self.pointDescription.text = self.pointData.objectForKey("description")  as NSString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func disagree(sender: UIBarButtonItem) {
        doVote("disagree")
        
    }
    
    @IBAction func agree(sender: UIBarButtonItem) {
        doVote("agree")
    }
    
    func doVote(kind: String) {
        let id = self.pointData.objectForKey("id") as Int
        let parameters = ["kind": kind,  "identifier": APIService.identifier]
        apiService.post("/points/\(id)/votes", parameters:parameters)
    }
    
    // MARK: Delegate Functions
    func didReceiveResults(response: NSDictionary) {
        let alertView = UIAlertView(title: "Success", message: "Voted Successful", delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    func didReceiveError(description: String) {
        let alertView = UIAlertView(title: "Error", message: description, delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    
}

