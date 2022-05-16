//
//  ViewController.swift
//  MapAnnotations
//
//  Created by James Lea on 5/16/22.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let coordinate = CLLocationCoordinate2D(
        latitude: 40.728,
        longitude: -74
    )
    let map = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        map.frame = view.bounds
        
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(
            latitudeDelta: 0.1,
            longitudeDelta: 0.1)), animated: false)
        addCustomPin()
    }

    private func addCustomPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Pokemon Here"
        pin.subtitle = "Go and Catch them all"
        map.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
//        var annotationView: MKAnnotationView?
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            //create the view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
//            annotationView?.rightCalloutAccessoryView
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "ball")
        
        return MKAnnotationView()
    }
    
    UILongtap
    
}
