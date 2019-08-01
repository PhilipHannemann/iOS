//
//  ViewController.swift
//  MapsPrototype
//
//  Created by Philip on 04.04.16.
//  Copyright © 2016 Philip. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var locationInfo: UILabel!
    
    var coreLocationManager = CLLocationManager()
    var locationManager: LocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        coreLocationManager.delegate = self
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        locationManager = LocationManager.sharedInstance
        
        if authorizationCode == CLAuthorizationStatus.NotDetermined && coreLocationManager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization))||coreLocationManager.respondsToSelector(#selector(CLLocationManager.requestWhenInUseAuthorization)){
            
            if NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil {
                
                coreLocationManager.requestAlwaysAuthorization()
            }
            else{
                print("No description provided")
                
            }
            
        }
        
    }
    
    func getLocation() {
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) in
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
        }
    }
    
    func displayLocation (location: CLLocation){
        MapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude),span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
        let locatinPinCoord = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locatinPinCoord
        
        MapView.addAnnotation(annotation)
        MapView.showAnnotations([annotation], animated: true)
        
        
        locationManager.reverseGeocodeLocationWithCoordinates(location, onReverseGeocodingCompletionHandler: {(reverseGeocodeInfo, placemark, error)in
            let adress = reverseGeocodeInfo?.objectForKey("formattedAddress") as! String
            self.locationInfo.text = adress
            
        })
        
        
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.NotDetermined || status != CLAuthorizationStatus.Denied || status != CLAuthorizationStatus.Restricted{
            getLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func updateLocation(sender: UIButton) {
        getLocation()
    }

}

