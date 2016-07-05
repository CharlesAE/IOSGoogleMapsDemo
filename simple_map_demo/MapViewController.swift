//
//  MapViewController.swift
//  simple_map_demo
//
//  Created by Charles E on 7/5/16.
//  Copyright © 2016 SR Studios. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    var didFindMyLocation = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem()
        mapItem()
        }

    func navItem(){
        navigationController?.navigationBar.translucent = false
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "Google Maps Demo"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.darkGrayColor()
        navigationItem.titleView = titleLabel
    }
    
    func mapItem(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        GMSServices.provideAPIKey("YOUR_API_KEY")
        
        let camera = GMSCameraPosition.cameraWithLatitude(38.897931,
                                                          longitude: -77.036562, zoom: 17.8, bearing: 0, viewingAngle: 45)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        //mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        mapView.mapType =  kGMSTypeHybrid
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(38.897931, -77.036562)
        marker.icon = UIImage(named: "home-variant")
        marker.title = "The White House"
        marker.snippet = "Iconic home of America's president"
        marker.map = mapView
    }
    
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
            mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: 17.8)
            mapView.settings.myLocationButton = true
            didFindMyLocation = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mapView.myLocationEnabled = true
        }
    }
    
    deinit {
        mapView?.removeObserver(self, forKeyPath: "myLocation")
    }
    
}
