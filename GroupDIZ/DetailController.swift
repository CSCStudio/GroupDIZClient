//
//  ViewController.swift
//  GroupDIZ
//
//  Created by Eric Chen on 7/5/14.
//  Copyright (c) 2014 Eric Chen. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(sender: UIBarButtonItem) {
        self.dismissModalViewControllerAnimated(true)
    }
    
}

