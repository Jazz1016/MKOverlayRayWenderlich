//
//  ClockOverlay.swift
//  putMapStuffTogether
//
//  Created by James Lea on 5/16/22.
//

import MapKit

class ClockOverlay: NSObject, MKOverlay {
    let coordinate: CLLocationCoordinate2D
    let boundingMapRect: MKMapRect
    
    init(clock: Clock) {
        boundingMapRect = clock.overlayBoundingMapRect
        coordinate = clock.midCoordinate
    }

}
