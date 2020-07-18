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
class newPolyLine: UIViewController,MKMapViewDelegate {
@IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var AddBtn: UIButton!
    @IBOutlet weak var addSearch: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
       
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
        }
    }
    }
 
 




