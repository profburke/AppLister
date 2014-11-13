//
//  MasterViewController.swift
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

import UIKit

class MasterViewController: UITableViewController
{
    var detailViewController: DetailViewController? = nil
    var appListDataSource: AppListDataSource = AppListDataSource()
    let evenColor = UIColor(white: 0.9, alpha: 1.0)

    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.dataSource = self.appListDataSource
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }
    
    
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let isEven = (indexPath.row%2 == 0)
        
        if isEven {
            cell.backgroundColor = self.evenColor
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
    }
    
    
    
    
    // MARK: - Segues

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = self.appListDataSource[indexPath.row] as AppInfo
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = object
                controller.title = object["localizedName"] as String?
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    

}

