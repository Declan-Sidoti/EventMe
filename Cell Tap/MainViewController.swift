//
//  ViewController.swift
//  Cell Tap
//
//  Created by Declan sidoti on 7/9/15.
//  Copyright (c) 2015 Declan Sidoti. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet var tableView: UITableView!
     var window: UIWindow?
    let blogSegueIdentifier = "ShowBlogSegue"
    let textCellIdentifier = "TextCell"
    let swiftBlogs = ["My Event", "Example Event", "My Other Event"]
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == blogSegueIdentifier {
            if let destination = segue.destinationViewController as? BlogViewController{
                if let blogIndex = tableView.indexPathForSelectedRow()?.row {
                    destination.blogName = swiftBlogs[blogIndex]
                }
            }
            
        }
    }
    @IBAction func logOut(sender: AnyObject) {
        println("logOutButtonTapAction")
        
        LayerClient.client.deauthenticateWithCompletion { (success: Bool, error: NSError?) in
            if error == nil {
                PFUser.logOut()
                self.navigationController!.popToRootViewControllerAnimated(true)
                // 3
            } else {
                println("Failed to deauthenticate: \(error)")
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftBlogs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as? UITableViewCell
        
        let row = indexPath.row
        cell!.textLabel?.text = swiftBlogs[row]
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(swiftBlogs[row])
    }


}

