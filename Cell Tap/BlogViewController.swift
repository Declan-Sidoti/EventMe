//
//  BlogViewController.swift
//  Cell Tap
//
//  Created by Declan sidoti on 7/9/15.
//  Copyright (c) 2015 Declan Sidoti. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class BlogViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{

    @IBOutlet var myMap: MKMapView!
    var locationManager = CLLocationManager()
    var blogName = String()
  
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = blogName
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error")
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as! CLLocation
        locationManager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        myMap.setRegion(region, animated: true)
    }

}
