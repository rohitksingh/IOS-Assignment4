//
//  AppUtility.swift
//  Assignment4
//
//  Created by Rohit  on 08/03/20.
//  Copyright © 2020 Rohit . All rights reserved.
//

import Foundation

class AppUtility{
    
    static func getDistance(currentPlace:PlaceDescription, selectedPlace: PlaceDescription) -> Double {
        
        var lat1 = 0.0
        var lat2 = 0.0
        var lon1 = 0.0
        var lon2 = 0.0
        
        lat1 = Double(currentPlace.latitude)
        lon1 = Double(currentPlace.longitude)
        
        lat2 = Double(selectedPlace.latitude)
        lon2 = Double(selectedPlace.longitude)
        
        if ((lat1 == lat2) && (lon1 == lon2)) {
            return 0.00
        } else {
            let theta = lon1 - lon2
            var dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2))
                + cos(deg2rad(lat1)) * cos(deg2rad(lat2))
                * cos(deg2rad(theta))
            dist = acos(dist)
            dist = radiansToDegrees(radians: dist)
            dist = dist * 60 * 1.1515 * 1.609344
            return (dist)
        }
    }
    
    static func getBearing(currentPlace:PlaceDescription, selectedPlace: PlaceDescription) -> Double {
        
        var lat1 = 0.0
        var lat2 = 0.0
        var lon1 = 0.0
        var lon2 = 0.0
        
        lat1 = Double(currentPlace.latitude)
        lat1 = deg2rad(lat1)
        
        lon1 = Double(currentPlace.longitude)
        
        lat2 = Double(selectedPlace.latitude)
        lat2 = deg2rad(lat2)
        
        lon2 = Double(selectedPlace.longitude)
        
        let longDiff = deg2rad(lon2 - lon1)
        let y = sin(longDiff) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(longDiff)
        
        return (radiansToDegrees(radians: atan2(y, x)) + 360).truncatingRemainder(dividingBy:360)
    }
    
    static func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    static func radiansToDegrees (radians: Double)->Double {
        return radians * 180 / .pi
    }
    
}
