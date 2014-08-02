//
//  TopicDetailController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class TopicDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIServiceDelegate {
    
    var topicData: NSDictionary!
    var pointList: NSArray = NSArray()
    var apiService: APIService = APIService()
    
    @IBOutlet weak var topicDescription: UILabel!
    @IBOutlet weak var pointsTableView: UITableView!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue?.identifier == "showPoint") {
            let indexPath = pointsTableView.indexPathForSelectedRow()
            let pointController = segue.destinationViewController as PointController
            let rowData = pointList[indexPath.row] as NSDictionary
            pointController.pointData = rowData
        }
    }
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.delegate = self
        self.topicDescription.text = self.topicData.objectForKey("description")  as NSString
        let id = self.topicData.objectForKey("id") as Int
        apiService.onSub("http://zuoyouba.com/api/v0/1/topics/\(id)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveResults(data: NSDictionary) {
        // change channels to api wrapper, eg 'topics'
        pointList = data.objectForKey("points") as NSArray
        self.pointsTableView.reloadData()
    }
    
    
}

