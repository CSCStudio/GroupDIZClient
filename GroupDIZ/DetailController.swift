//
//  ViewController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("detail") as UITableViewCell
        //        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "topic")
        //        let rowData:NSDictionary = self.tableData[indexPath.row] as NSDictionary;
        cell.textLabel.text = "This is a detail title"
        return cell
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

