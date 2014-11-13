//
//  DetailViewController.swift
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var tableview: UITableView!
    var appinfoDataSource: AppInfoDataSource?

    
    var detailItem: AppInfo? {
        didSet {
            self.appinfoDataSource = AppInfoDataSource(appProxy: detailItem!)
            self.configureView()
        }
    }

    
    
    
    func configureView()
    {
        if let dataSource: AppInfoDataSource = self.appinfoDataSource {
            self.tableview?.dataSource = dataSource
        }
    }

    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.configureView()
    }

    
    
}

