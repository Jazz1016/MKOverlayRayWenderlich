//
//  ViewController.swift
//  mapKit-AddAnnotation
//
//  Created by James Lea on 5/16/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var keyLat: Float = 49.2888
    var keyLong: Float = 123.1111
    var selectedAnnotation: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        longPressRecognizer.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecognizer)
        
        mapView.mapType = .standard
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(keyLat), longitude: CLLocationDegrees(keyLong))
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func handleTap(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        //add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "latitude: " + String(format: "%0.02f", annotation.coordinate.latitude) + "longitude: " + String(format: "%0.02f", String(format: "%0.02f", annotation.coordinate.longitude))
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let latValString: String = String(format: "%0.02f", Float(((view.annotation?.coordinate.latitude)!)))
        let longValString: String = String(format: "%0.02f", Float(((view.annotation?.coordinate.longitude)!)))
        print("latitude \(latValString)", "longitude \(longValString)")
    }


}

