//
//  Park.swift
//  NPF-1
//
//  Created by Randy Perez on 2/14/16.
//  Copyright © 2016 Randy Perez. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import AddressBook
import Contacts
//mk anmotation is part of mapkit
class Park: NSObject, MKAnnotation {
    

    private var parkName: String = ""
    private var parkLocation: String = ""
    private var dateFormed: String = ""
    private var area: String = ""
    private var link: String = ""
    private var location: CLLocation?
    private var imageLink: String = ""
    private var parkDescription: String = ""
    private var imageName:String = ""
    private var imageSize:String = ""
    private var imageType:String = ""
    override var description: String {
        return "{\n" +
            "\t parkName: \(getParkName()) \n" +
            "\t parkLocation: \(getParkLocation()) \n" +
            "\t dateFormed: \(getDateFormed()) \n" +
            "\t area: \(getArea()) \n" +
            "\t link: \(getLink()) \n " +
            "\t location: \(getLocation() as CLLocation!) \n " +
            "\t imageLink: \(getImageLink()) \n " +
            "\t imageName: \(getImageName()) \n " +
            "\t imageSize: \(getImageSize()) \n " +
            "\t imageType: \(getImageType()) \n " +
            "\t parkDescription: \(getParkDescription()) \n " +
        "}"
    }
    
    @objc var coordinate: CLLocationCoordinate2D {
        get {
            return location!.coordinate
        }
    }
    
    @objc var title: String? {
        get {
            return parkName
        }
    }
    
    @objc var subtitle: String? {
        get{
            return parkDescription //not sure
        }
    }
    
    
     init(parkName:String, parkLocation:String, dateFormed:String, area:String, link:String,
        location:CLLocation?, imageLink:String, imageName:String, imageSize:String, imageType:String, parkDescription:String) {
            super.init()
            self.setParkName(parkName)
            self.setParkLocation(parkLocation)
            self.setDateFormed(dateFormed)
            self.setArea(area)
            self.setLink(link)
            self.setLocation(location)
            self.setImageLink(imageLink)
            self.setParkDescription(parkDescription)
            self.setImageName(imageType)
            self.setImageType(imageType)
            self.setImageSize(imageSize)
        
    }
    
    convenience override init() {
        self.init(parkName: "Unknown", parkLocation:"Unknown", dateFormed: "Unknown",
            area: "Unknown", link: "Unknown", location: nil, imageLink:"Unknown", imageName:"Unknown", imageSize:"Unknown", imageType:"Unknown",parkDescription:"Unknown")
//        super.init()
    }
    
    
    //getters
    func getParkName() -> String {
        return parkName
    }
    
    func getParkLocation()-> String {
        return parkLocation
    }
    
    func getDateFormed()-> String {
        return dateFormed
    }
    
    func getArea()-> String {
        return area
    }
    
    func getLink()-> String {
        return link
    }
    
    func getLocation()-> CLLocation? {
        if let location = self.location {
            return location
        }
        return nil
    }
    
    func getImageLink()-> String {
        return imageLink
    }
    
    func getImageName()-> String {
        return imageName
    }
    
    func getImageType()-> String {
        return imageType
    }
    
    func getImageSize()-> String {
        return imageSize
    }
    
    func getParkDescription()-> String {
        return parkDescription
    }
    
    //setters
    func setParkName(value:String) { //hardcoded value in the error
        if validate(value) {
            self.parkName = value
        }
        else {
            self.parkName = "TBD"
            print("Bad value of \(value) in setParkName: setting to TBD")
        }
    }
    
    func setParkLocation(value:String) { //hard coding value too
        if validate(value) {
            self.parkLocation = value
        }
        else {
            self.parkLocation = "TBD"
            print("Bad value of na in setParkLocation: setting to TBD")
        }
    }
    
    func setDateFormed(value:String) {
        dateFormed = value
    }
    
    func setArea(value:String) {
        area = value
    }
    
    func setLink(value:String) {
        link = value
    }
    
    func setLocation(value:CLLocation?) {
        location = value
    }
    
    func setImageLink(value:String) {
        imageLink = value
    }
    
    func setImageName(value:String) {
        imageName = value
    }
    
    func setImageType(value:String) {
        imageType = value
    }
    
    func setImageSize(value:String) {
        imageSize = value
    }
    
    func setParkDescription(value:String) {
        parkDescription = value
    }
    
    //methods
    private func validate(value:String)->Bool {
        let newVal = value.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if newVal.characters.count > 2 && newVal.characters.count < 76  {
            return true
        }
        return false
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddress): parkName]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}