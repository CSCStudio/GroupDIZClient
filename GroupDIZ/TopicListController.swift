//
//  TopicListController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class TopicListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var topicList: NSArray = NSArray()
    var apiService: APIService = APIService()
    @IBOutlet weak var topicListTableView: UITableView!

    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return topicList.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("topic") as UITableViewCell
        if (cell == nil) {
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "topic")
        }
        let rowData = self.topicList[indexPath.row] as NSDictionary
        cell.textLabel.text = rowData.objectForKey("title") as NSString
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue?.identifier == "showTopicDetail") {
            let indexPath = topicListTableView.indexPathForSelectedRow()
            let topicController = segue.destinationViewController as TopicDetailController
            let rowData = topicList[indexPath.row] as NSDictionary
            topicController.topicData = rowData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

