//
//  TopicDetailController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class TopicDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIServiceDelegate {
    
    // MARK: Properties
    var topicData: NSDictionary!
    var pointList: NSArray = NSArray()
    var apiService: APIService = APIService()
    
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
        println(pointList)
        let rowData = pointList[indexPath.row] as NSDictionary
        cell.textLabel.text = rowData.objectForKey("title") as NSString
        return cell
    }

    func didReceiveResults(data: NSDictionary) {
        // change channels to api wrapper, eg 'topics'
        pointList = data.objectForKey("points") as NSArray
        self.pointsTableView.reloadData()
    }
    
    func didReceiveError(description: String) {
        let alertView = UIAlertView(title: "Error", message: description, delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    // MARK: Internal Functions
    internal func getTopicDetails() {
        topicDescription.text = topicData.objectForKey("description")  as NSString
        let id = topicData.objectForKey("id") as Int
        let parameters = ["identifier": APIService.identifier]
        apiService.get("/topics/\(id)", parameters: parameters)
    }
    
    // MARK: Override View Functions
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue?.identifier == "showPoint") {
            let indexPath = pointsTableView.indexPathForSelectedRow()
            let pointController = segue.destinationViewController as PointController
            let rowData = pointList[indexPath.row] as NSDictionary
            pointController.pointData = rowData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.delegate = self
        getTopicDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

