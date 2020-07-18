//
//  data.swift
//  dualTableview
//
//  Created by Bhargava on 17/07/20.
//  Copyright © 2020 Bhargava. All rights reserved.
//

import Foundation
import MapKit
class Station: NSObject, MKAnnotation {
  var title: String?
  var subtitle: String?
  var latitude: Double = 0
  var longitude:Double = 0

  var coordinate: CLLocationCoordinate2D {
  return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
init(latitude: Double, longitude: Double) {
self.latitude = latitude
self.longitude = longitude
}
}
