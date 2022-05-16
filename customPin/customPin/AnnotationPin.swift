//
//  AnnotationPin.swift
//  customPin
//
//  Created by James Lea on 5/16/22.
//

import MapKit

class AnnotationPin: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title      = title
        self.subtitle   = subtitle
        self.coordinate = coordinate
    }
}
