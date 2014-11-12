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
    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AppInfo? {
        didSet {
            self.configureView()
        }
    }

    
    
    
    func configureView()
    {
        if let app: AppInfo = self.detailItem {
            if let label = self.detailDescriptionLabel {
                self.title = app.name
                label.text = app.name
            }
        }
    }

    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.configureView()
    }


}

