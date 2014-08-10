//
//  TopicDetailController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class ShowTopicController: UIViewController, UITableViewDataSource, UITableViewDelegate, CreatePointDelegate, APIServiceDelegate {
    
    // MARK: Properties
    var topicData: NSDictionary!
    var pointList: NSMutableArray = NSMutableArray()
    var apiService: APIService = APIService()
    
    @IBOutlet weak var creator: UILabel!
    @IBOutlet weak var topicTitle: UILabel!
    @IBOutlet weak var topicDescription: UILabel!
    @IBOutlet weak var pointsTableView: UITableView!
    
    // MARK: Delegate Functions
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return pointList.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("detail") as UITableViewCell
        if (cell == nil) {
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "detail")
        }
        let rowData = pointList[indexPath.row] as NSDictionary
        cell.textLabel.text = rowData.objectForKey("title") as NSString
        return cell
    }

    func didReceiveResults(data: NSDictionary) {
        // change channels to api wrapper, eg 'topics'
        if data.objectForKey("points") {
            self.pointList = data.objectForKey("points") as NSMutableArray
            self.pointsTableView.reloadData()
        }
    }
    
    func didReceiveError(description: String) {
        let alertView = UIAlertView(title: "Error", message: description, delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    // MARK: Override View Functions
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue?.identifier == "showPoint") {
            let indexPath = pointsTableView.indexPathForSelectedRow()
            let pointController = segue.destinationViewController as ShowPointController
            let rowData = pointList[indexPath.row] as NSDictionary
            pointController.pointData = rowData
        }else if (segue?.identifier == "createPoint") {
            let pointController = segue.destinationViewController as CreatePointController
            pointController.topic_id = topicData.objectForKey("id") as Int
            pointController.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.delegate = self
        showTopicDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didCreatePoint(point: AnyObject) {
        //pointList.addObject(point)
        self.dismissViewControllerAnimated(true, completion: nil)
        showTopicDetails()
    }
    
    // MARK: Private showTopicDetails
    private func showTopicDetails() {
        topicTitle.text = topicData.objectForKey("title")  as NSString
        topicDescription.text = topicData.objectForKey("description")  as NSString
        creator.text = topicData.objectForKey("creator_name") as NSString
        let id = topicData.objectForKey("id") as Int
        let parameters = ["identifier": APIService.identifier]
        apiService.get("/topics/\(id)", parameters: parameters)
    }
    
    
}

