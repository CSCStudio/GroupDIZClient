//
//  TopicDetailController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class TopicDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var topicId: String!
    var topicTitle: String!
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("detail") as UITableViewCell
        cell.textLabel.text = "This is a detail title"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.topicTitle
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
}

