//
//  PointOfInterest.swift
//  poi
//
//  Created by Quintin Smith on 12/8/18.
//  Copyright © 2018 wasatchcode. All rights reserved.
//

import MapKit
import CoreLocation

class PointOfInterest: NSObject {
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
    }
    
    init?(csvLine: String) {
        let parts = csvLine.components(separatedBy: ",")
        if parts.count < 3 { return nil }
        guard let latitude = parts[1].toFailableDouble() else { return nil }
        guard let longitude = parts[0].toFailableDouble() else { return nil }
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.name = parts[2].replacingOccurrences(of: "\"", with: "")
    }
}

func ==(lhs: PointOfInterest, rhs: PointOfInterest) -> Bool {
    return lhs.name == rhs.name && lhs.coordinate == rhs.coordinate
}
