//
//  DetailViewController.swift
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014-2017 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var tableview: UITableView!
  var appinfoDataSource: AppInfoDataSource?
  var appListDataSource: AppListDataSource?
  
  var detailItem: AppInfo? {
    didSet {
      appinfoDataSource = AppInfoDataSource(appProxy: detailItem!)
      configureView()
    }
  }
  
  func configureView() {
    if let dataSource: AppInfoDataSource = appinfoDataSource {
      tableview?.dataSource = dataSource
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  @IBAction func openApp() {
    if let appListDataSource = appListDataSource {
      appListDataSource.openApp(appinfoDataSource?.getBundleID())
    }
  }
  
}

