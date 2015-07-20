//
//  AppDelegate.swift
//  Cell Tap
//
//  Created by Declan sidoti on 7/9/15.
//  Copyright (c) 2015 Declan Sidoti. All rights reserved.
//

import UIKit
//import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let LayerAppIDString: NSURL! = NSURL(string: "layer:///apps/staging/cebbcb50-29b7-11e5-9861-68bc460101a2")
    let ParseAppIDString: String = "TN6zAxck5uARAxPlUBJHkj213my67BvzrBFrFD7f"
    let ParseClientKeyString: String = "jsiAYUkWNQyquiGimaISxu6vysjyVNakrJHWAPB4"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupParse()
        setupLayer()
        
        // Initialize Facebook
        // 1
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        // check if we have logged in user
        // 2
        let user = PFUser.currentUser()
        
        let startViewController: UIViewController;
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        startViewController = storyboard.instantiateViewControllerWithIdentifier("NavBarController") as! UINavigationController
        
        // 5
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController;
        self.window?.makeKeyAndVisible()
        
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func setupParse() {
        // Enable Parse local data store for user persistence
        Parse.enableLocalDatastore()
        Parse.setApplicationId(ParseAppIDString, clientKey: ParseClientKeyString)
        
        // Set default ACLs
        let defaultACL: PFACL = PFACL()
        defaultACL.setPublicReadAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
    }
    
    func setupLayer() {
        LayerClient.client = LYRClient(appID: LayerAppIDString)
        LayerClient.client.autodownloadMaximumContentSize = 1024 * 100
        LayerClient.client.autodownloadMIMETypes = NSSet(objects: "image/jpeg") as Set<NSObject>
    }
    
    
    
}

