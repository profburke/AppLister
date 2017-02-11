//
//  AppInfoDataSource.swift
//  AppLister
//
//  Created by Matthew Burke on 11/13/14.
//  Copyright (c) 2014-2017 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

import UIKit

class AppInfoDataSource: NSObject, UITableViewDataSource {
  let appProxy: AppInfo
  let CellIdentifier = "DetailCell"
  
  init(appProxy: AppInfo) {
    self.appProxy = appProxy
    super.init()
  }
  
  func getBundleID() -> String {
    return appProxy["bundleIdentifier"] as! String
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.appProxy.propertyCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: self.CellIdentifier, for: indexPath) 
    
    let propName = self.appProxy[(indexPath as NSIndexPath).row] as! String
    let prop = self.appProxy[propName] as! String
    
    cell.textLabel?.text = prop
    cell.detailTextLabel?.text = propName
    
    return cell
  }

}
