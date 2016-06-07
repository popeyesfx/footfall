//
//  SecondViewController.swift
//  Footfall
//
//  Created by Jack Hider on 07/06/2016.
//  Copyright © 2016 Jack Hider. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var map:MKMapView!
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    let addresses = [
        "280 Southwell Rd E, Rainworth, Mansfield NG21 0EB",
        "Sherwood Parade, Kirklington Rd, Rainworth, Mansfield NG21 0JP",
        "16 Hall Cl, Vale Road, Rainworth, Mansfield NG21 0FR",
        "166 Southwell Rd E, Rainworth, Mansfield NG21 0EH" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
        
        for add in addresses {
            
            getPlaceMarkFromAddress(add)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
            map.showsUserLocation = true
            
        }else {
            
            locationManager.requestWhenInUseAuthorization()
        }
        
        
    }
    
    func centreMapOnLocation( location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            
            centreMapOnLocation(loc)
            
        }
    }
    
    
    func createAnnotationForLocation(location: CLLocation) {
        
        let place = footfallAnotation(coordinate: location.coordinate)
        map.addAnnotation(place)
        
    }
    
    func getPlaceMarkFromAddress(address: String) {
        
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, err: NSError?) -> Void in
            
            if err == nil {
                if let marks = placemarks where placemarks!.count > 0 {
                    
                    if let loc = marks[0].location {
                        
                        self.createAnnotationForLocation(loc)
                        
                        
                    }
                    
                }
            }
            
        }
        
    }
}

