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

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}
