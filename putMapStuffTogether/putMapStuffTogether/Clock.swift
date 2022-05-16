//
//  Clock.swift
//  putMapStuffTogether
//
//  Created by James Lea on 5/16/22.
//

import MapKit

class Clock {
    var name: String?
    var boundary: [CLLocationCoordinate2D] = []
    
    var midCoordinate = CLLocationCoordinate2D()
    var overlayTopLeftCoordinate = CLLocationCoordinate2D()
    var overlayTopRightCoordinate = CLLocationCoordinate2D()
    var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: overlayBottomLeftCoordinate.latitude,
            longitude: overlayTopRightCoordinate.longitude)
    }
    
    var overlayBoundingMapRect: MKMapRect {
        let topLeft = MKMapPoint(overlayTopLeftCoordinate)
        let topRight = MKMapPoint(overlayTopRightCoordinate)
        let bottomLeft = MKMapPoint(overlayBottomLeftCoordinate)
        
        return MKMapRect(
            x: topLeft.x,
            y: topLeft.y,
            width: fabs(topLeft.x - topRight.x),
            height: fabs(topLeft.y - bottomLeft.y))
    }
    
    init(midCoord: CLLocationCoordinate2D,topLeftCoord: CLLocationCoordinate2D, topRightCoord: CLLocationCoordinate2D, bottomLeftCoord: CLLocationCoordinate2D
//         ,bottomRightCoord: CLLocationCoordinate2D
    ) {
        midCoordinate               = midCoord
        overlayTopLeftCoordinate    = topLeftCoord
        overlayTopRightCoordinate   = topRightCoord
        overlayBottomLeftCoordinate = bottomLeftCoord
//        overlayBottomRightCoordinate   = bottomRightCoord
    }
    
    static func parseCoord(dict: [String: Any], fieldName: String) -> CLLocationCoordinate2D {
        if let coord = dict[fieldName] as? String {
            let point = NSCoder.cgPoint(for: coord)
            return CLLocationCoordinate2D(
                latitude: CLLocationDegrees(point.x),
                longitude: CLLocationDegrees(point.y))
        }
        return CLLocationCoordinate2D()
    }
}
