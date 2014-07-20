//
//  TopicListController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class TopicListController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIServiceDelegate {
 
    var topicList: NSArray = NSArray()
    var apiService: APIService = APIService()
    @IBOutlet var topicListTableView: UITableView
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue?.identifier == "showTopicDetail") {
            let indexPath = topicListTableView.indexPathForSelectedRow()
            let topicController = segue.destinationViewController as TopicDetailController
            let rowData = topicList[indexPath.row] as NSDictionary
            topicController.topicData = rowData
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
        let rowData = topicList[indexPath.row] as NSDictionary
        cell.textLabel.text = rowData.objectForKey("title") as NSString
        return cell
    }

    func setupTopicListForUser() -> () {
        // change topic list api url
        apiService.onSub("http://zuoyouba.com/api/v0/1/topics")
    }
    
    func didReceiveResults(data: NSDictionary) {
        // change channels to api wrapper, eg 'topics'
        topicList = data.objectForKey("topics") as NSArray
        self.topicListTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        self.setupTopicListForUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

