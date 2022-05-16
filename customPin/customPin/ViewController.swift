//
//  ViewController.swift
//  customPin
//
//  Created by James Lea on 5/16/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var pin: AnnotationPin!
    var tapCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let coordinate = CLLocationCoordinate2D(latitude: 27.1751, longitude: 78.0421)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        pin = AnnotationPin(title: "Taj Mahal", subtitle: "One of the wonder's of the world", coordinate: coordinate)
        mapView.addAnnotation(pin)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: pin, reuseIdentifier: "tajPin")
        annotationView.image = UIImage(named: "clock1")
        let transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        annotationView.transform = transform
        return annotationView
    }

}

