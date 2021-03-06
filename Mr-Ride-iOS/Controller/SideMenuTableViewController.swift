//
//  RootTableViewController.swift
//  Mr-Ride-iOS
//
//  Created by Eph on 2016/5/24.
//  Copyright © 2016年 AppWorks School WuDuhRen. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Amplitude_iOS


class SideMenuTableViewController: UITableViewController {

    private let menu = ["Home", "History", "Map"]
    
    weak var delegate: SideMenuDelegate?
    
    
    deinit {
        //print("SideMenuTableViewController deinit at \(self)")
    }

}



// MARK: - SideMenuTableViewDataSource

extension SideMenuTableViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SideMenuCell", forIndexPath: indexPath) as! SideMenuCell
        cell.delegate = delegate
        cell.buttonTitle = menu[indexPath.row]
        cell.selectionStyle = .None
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
}



// MARK: - Setup

extension SideMenuTableViewController {
    
    private func setup() {
        self.navigationController?.navigationBarHidden = true
        self.tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        self.view.backgroundColor = .MRDarkSlateBlueColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    private func setupbutton() {
        
        let button = UIButton(frame: CGRect(x: 60, y: 470, width: 150, height: 32))
        button.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.3)
        button.setTitle("Log Out", forState: .Normal)
        button.addTarget(self, action: #selector(SideMenuTableViewController.facebookLogout(_:)), forControlEvents: UIControlEvents.TouchDown)
        tableView.addSubview(button)
    }
}



// MARK: - LogOut

extension SideMenuTableViewController {

    func facebookLogout(sender: UIButton) {
        FBSDKLoginManager().logOut()
        Amplitude.instance().logEvent("select_logout_in_menu")
        
        RootViewManager.sharedManager.changeRootViewController(
            viewController: LoginViewController.controller(),
            animated: true,
            success: nil,
            failure: nil
        )
    }
}




// MARK: - View Lifecycle

extension SideMenuTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupbutton()
        
        Amplitude.instance().logEvent("view_in_menu")
    }
}












