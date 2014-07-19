//
//  TopicListController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class TopicListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var topicList: [Dictionary<String, String>]!
    
    @IBOutlet var topicListTableView: UITableView
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue?.identifier == "showTopicDetail") {
            let indexPath = topicListTableView.indexPathForSelectedRow()
            let topicController = segue.destinationViewController as TopicDetailController
            topicController.topicTitle = topicList[indexPath.row]["title"]
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return topicList.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("topic") as UITableViewCell
        if (cell == nil) {
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "topic")
        }
        let rowData = topicList[indexPath.row]
        cell.textLabel.text = rowData["title"]
        return cell
    }

    func setupTopicListForUser() -> () {
        // TODO: write a fetching method to get topicList
        topicList = [
            ["title":"topic title 1", "id":"1"],
            ["title":"topic title 2", "id":"2"],
            ["title":"topic title 3", "id":"3"]
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupTopicListForUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

