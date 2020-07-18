//
//  newPolyLine.swift
//  dualTableview
//
//  Created by Bhargava on 17/07/20.
//  Copyright © 2020 Bhargava. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class newPolyLine: UIViewController,MKMapViewDelegate ,CLLocationManagerDelegate{
    
     var locationManger = CLLocationManager()
@IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var AddBtn: UIButton!
    @IBOutlet weak var addSearch: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManger.delegate = self
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestAlwaysAuthorization()
        locationManger.requestWhenInUseAuthorization()
        
        locationManger.startUpdatingLocation()
        
      }
   
    @IBAction func getDirection(_ sender: UIButton) {
        getAddress()
    }
    func getAddress(){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addSearch.text ?? " ") { (placemark, err) in
            guard let placemarks = placemark,let location = placemarks.first?.location
                else{
                    print("location not found")
                    return
            }
            print(location)
            self.mapThis(destinationCo: location.coordinate)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
               let region = MKCoordinateRegion(center: location.coordinate, span: span)
               mapView.setRegion(region, animated: true)
           }
    }
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManger.requestLocation()
           }
       }
    func mapThis(destinationCo:CLLocationCoordinate2D){
        let sourceCordinate = (locationManger.location?.coordinate)!
        let sourcePlacemark = MKPlacemark(coordinate: sourceCordinate)
        let destiPlacemark = MKPlacemark(coordinate: destinationCo)
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destiItem = MKMapItem(placemark: destiPlacemark)
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destiItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, err) in
            guard let response = response else {
                if let error = err{
                    print("something is wrong")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
    }
 
 




