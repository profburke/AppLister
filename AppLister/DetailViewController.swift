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
    @IBOutlet weak var detailDescriptionView: UITextView!


    var detailItem: AppInfo? {
        didSet {
            self.configureView()
        }
    }

    
    
    
    func configureView()
    {
        if let app: AppInfo = self.detailItem {
            if let textview = self.detailDescriptionView {
                textview.text = app.details
            }
        }
    }

    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.configureView()
    }


}

