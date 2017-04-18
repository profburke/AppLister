//
//  MasterViewController.swift
//  AppLister
//
//  Created by Matthew Burke on 11/12/14.
//  Copyright (c) 2014-2017 BlueDino Software. Availble under the MIT License. See the file, LICENSE, for details.
//

import UIKit

class MasterViewController: UITableViewController {
    var detailViewController: DetailViewController? = nil
    var appListDataSource: AppListDataSource = AppListDataSource()
    let evenColor = UIColor(white: 0.9, alpha: 1.0)
    var searchController = UISearchController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.current.userInterfaceIdiom == .pad {
            clearsSelectionOnViewWillAppear = false
            preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = appListDataSource
        
        configureSearchController()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            let navigationController = controllers[controllers.count-1] as! UINavigationController
            detailViewController = navigationController.topViewController as? DetailViewController
        }
    }
    
    // MARK: - SearchController
    
    func configureSearchController() {
        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            
            controller.searchBar.scopeButtonTitles = ["All", "System", "User"]
            controller.searchBar.showsBookmarkButton = true
            controller.searchBar.delegate = appListDataSource
            
            controller.searchResultsUpdater = appListDataSource
            controller.delegate = appListDataSource
            appListDataSource.tableView = tableView
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
            tableView.tableHeaderView = controller.searchBar
            definesPresentationContext = true
            
            return controller
        })()
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isEven = ((indexPath as NSIndexPath).row%2 == 0)
        
        if isEven {
            cell.backgroundColor = evenColor
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = appListDataSource[(indexPath as NSIndexPath).row] as! AppInfo
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.appListDataSource = appListDataSource
                controller.title = object["localizedName"] as! String?
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}

