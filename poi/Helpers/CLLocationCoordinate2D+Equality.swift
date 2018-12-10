//
//  CLLocationCoordinate2D+Equality.swift
//  poi
//
//  Created by Quintin Smith on 12/8/18.
//  Copyright © 2018 wasatchcode. All rights reserved.
//

import Foundation
import CoreLocation

private let kCLLocationCoordinateErrorRange = 0.005

extension CLLocationCoordinate2D {
    
    func isEqual(object: Any) -> Bool {
        
        if let coordinate = object as? CLLocationCoordinate2D { return self == coordinate }
        
        return false
    }
    
    static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        if abs(lhs.latitude - rhs.latitude) > kCLLocationCoordinateErrorRange { return false }
        else if abs(lhs.longitude - rhs.longitude) > kCLLocationCoordinateErrorRange { return false }
        
        return true
    }
}
