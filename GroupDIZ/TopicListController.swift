//
//  TopicListController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class ListTopicsController: UIViewController, UITableViewDataSource, UITableViewDelegate, CreateTopicDelegate {
 
    // MARK: Properties
    var topicList: NSMutableArray = NSMutableArray()
    var apiService: APIService = APIService()
    @IBOutlet weak var topicListTableView: UITableView!

    // MARK: Delegate Functions
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return topicList.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("topic", forIndexPath: indexPath) as UITableViewCell
        let rowData = self.topicList[indexPath.row] as NSDictionary
        cell.textLabel.text = rowData.objectForKey("title") as NSString
        return cell
    }

    func didCreateTopic(topic: AnyObject) {
        self.topicList.addObject(topic)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Override View Functions
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue?.identifier == "showTopicDetail") {
            let indexPath = topicListTableView.indexPathForSelectedRow()
            let topicController = segue.destinationViewController as ShowTopicController
            let rowData = topicList[indexPath.row] as NSDictionary
            topicController.topicData = rowData
        } else if (segue?.identifier == "createTopic") {
            let topicController = segue.destinationViewController as CreateTopicController
            topicController.delegate = self
        } else if (segue?.identifier == "joinTopic"){
            let joinController = segue.destinationViewController as JoinTopicController
            joinController.delegate = self
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

