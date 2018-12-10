//
//  PoiAnnotation.swift
//  poi
//
//  Created by Quintin Smith on 12/8/18.
//  Copyright © 2018 wasatchcode. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class POIAnnotation: NSObject, MKAnnotation {
    
    let pointOfInterest: PointOfInterest
    var coordinate: CLLocationCoordinate2D { return  pointOfInterest.coordinate }
    
    init(point: PointOfInterest) {
        self.pointOfInterest = point
        super.init()
    }
    
    var title: String? { return pointOfInterest.name }
    var subtitle: String? {
        return "(\(pointOfInterest.coordinate.latitude), \(pointOfInterest.coordinate.longitude))"
    }
    
}
