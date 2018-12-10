//
//  String+BooleanValue.swift
//  poi
//
//  Created by Quintin Smith on 12/8/18.
//  Copyright © 2018 wasatchcode. All rights reserved.
//

import Foundation



extension String {
    func toFailableBool() -> Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    
    func toBool() -> Bool {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return false
        }
    }
    
    func toDouble() -> Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US_POSIX")
        return numberFormatter.number(from: self.replacingOccurrences(of: ",", with: "."))?.doubleValue ?? 0.0
    }
    
    func toFailableDouble() -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US_POSIX")
        return numberFormatter.number(from: self.replacingOccurrences(of: ",", with: "."))?.doubleValue ?? 0.0
    }
    
    func toInt() -> Int {
        return NumberFormatter().number(from: self)?.intValue ?? 0
    }
    
    func toFailableInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
}
