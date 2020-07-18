//
//  polyLine.swift
//  dualTableview
//
//  Created by Bhargava on 16/07/20.
//  Copyright © 2020 Bhargava. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class polyLine: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate{
var locationManager : CLLocationManager!
    @IBOutlet weak var maMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
         locationManager = CLLocationManager()
        maMap.delegate = self
        maMap.showsUserLocation = true
        maMap.showsCompass = true
       
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let location = locations.last! as CLLocation
         let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.03)
         let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
         let region = MKCoordinateRegion(center: center, span: span)
         locationManager.stopUpdatingLocation()
         self.maMap.setRegion(region, animated: true)
  
        let geoCoder = CLGeocoder()
        let currentLoc = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        geoCoder.reverseGeocodeLocation(currentLoc) {(placemarkArray, error) in
            let placeMark = placemarkArray?.last
           // print(placeMark?.administrativeArea!)
            let myPin = MKPointAnnotation()
            myPin.coordinate = center
           // myPin.title = placeMark?.subLocality ?? " "
            //myPin.subtitle = placeMark?.isoCountryCode ?? " "
            if let city = placeMark?.addressDictionary!["City"] as? String {
                myPin.subtitle = city
                       }
            if let locationName = placeMark?.addressDictionary!["Name"] as? String {
                           //print(locationName)
                myPin.title = locationName
                       }
            print(placeMark?.addressDictionary ?? " ")
            print((placeMark?.name ?? " "))
            self.maMap.addAnnotations([myPin])
        }
       
        
    }
  
}
