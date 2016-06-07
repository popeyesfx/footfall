//
//  footfallAnotation.swift
//  Footfall
//
//  Created by Jack Hider on 07/06/2016.
//  Copyright © 2016 Jack Hider. All rights reserved.
//

import Foundation
import MapKit

class footfallAnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        
        self.coordinate = coordinate
        
    }
    
}