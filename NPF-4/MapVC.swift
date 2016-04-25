//
//  MapVC.swift
//  NPF-4
//
//  Created by Randy Perez on 4/19/16.
//  Copyright © 2016 Randy Perez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Contacts

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var btnRefresh: UIButton!
    
    var locationManager : CLLocationManager?
    var startLocation: CLLocation!
    
    var parkList = Parks()
    var parks : [Park] {
        get {
            return self.parkList.parkList!
        }
        
        set(val) {
            self.parkList.parkList = val 
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        
        mapView?.addAnnotations(parks)
        mapView?.delegate = self
        
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        activity.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //Optional method to handle error when getting user location.
        let errorAlert = UIAlertController(title: "Error", message: "NP-4 was unable to get your location", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        errorAlert.addAction(okAction)
        self.presentViewController(errorAlert, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        //method to respond to auth changes by the user, like notify if we can't get the location and suggest changes.
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        case .NotDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .Restricted, .Denied:
            let alertController = UIAlertController(title: "Location Disbled", message: "NP-4 needs your location to function properly, please your permission settings to allow it", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let openAction = UIAlertAction(title: "Open Settings", style: .Default, handler: {
                (action) in if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(openAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation: AnyObject = locations[0]
        let mKCoordinateRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 20000, 20000)
        mapView?.setRegion(mKCoordinateRegion, animated: true)
        
        //add Anotation
        let point = MKPointAnnotation()
        point.coordinate = newLocation.coordinate
        point.title = "This is your current location"
        point.subtitle = "Driving directions will part from here."
        mapView?.addAnnotation(point)
        
        if startLocation == nil {
            startLocation = newLocation as! CLLocation
            locationManager?.stopUpdatingLocation()
        }
        activity.stopAnimating()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //called once for each annotation created - if no view returned
    //use defualt pin
    func stopUpdating() {
        locationManager?.stopUpdatingLocation()
    }
    
    func startUpdating()  {
        startLocation = nil
        locationManager?.startUpdatingLocation()
    }
    
    
    //annotation methods
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let annotation = view.annotation
        print("The tittle of the annotation is \(annotation!.title)")
    }
    
    //called once for each annotation created - if no view returned
    //use defualt pin
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var view:MKPinAnnotationView
        let identifier = "Pin"
        
        if annotation is MKPointAnnotation {
            return nil //use blue dot
        }
        if annotation !== mapView.userLocation {
            //try to reuse a view
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.pinTintColor = MKPinAnnotationView.purplePinColor()
                view.animatesDrop = true
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x:-5, y:5)
                let leftButton = UIButton(type: .DetailDisclosure)
                let rightButton = UIButton(type: .DetailDisclosure)
                leftButton.tag = 0
                rightButton.tag = 1
                view.leftCalloutAccessoryView = leftButton
                view.rightCalloutAccessoryView = rightButton
            }
            return view
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Control tapped: \(control), tag number= \(control.tag)")
        let location = view.annotation as! Park
        
        if control.tag == 0 {
            
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMapsWithLaunchOptions(launchOptions)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: location.getLink())!)
        }
        
        
    }
    
    @IBAction func zoomOut(sender: AnyObject) {
//        let address = [String(CNPostalAddressCountryKey):"USA"]
//        let place = MKPlacemark(coordinate: CLLocationCoordinate2DMake(39.5, -98.35), addressDictionary: address)
//        let mapItem = MKPlacemark(placemark: place)
        
        let mKCoordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(39.5, -98.35), 450000, 4500000)
        mapView?.setRegion(mKCoordinateRegion, animated: true)
    }
    
    @IBAction func refresh(sender: AnyObject) {
        locationManager?.delegate = self
        activity.startAnimating()
        startUpdating()
    }
    

}
