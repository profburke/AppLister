//
//  DetailViewController.swift
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014-2015 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

import UIKit



class DetailViewController: UIViewController
{
  @IBOutlet weak var tableview: UITableView!
  var appinfoDataSource: AppInfoDataSource?
  var appListDataSource: AppListDataSource?
  
  
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
  
  
  
  @IBAction func openApp()
  {
    if let appListDataSource = appListDataSource {
      appListDataSource.openApp(appinfoDataSource?.getBundleID())
    }
  }
  
  
}

