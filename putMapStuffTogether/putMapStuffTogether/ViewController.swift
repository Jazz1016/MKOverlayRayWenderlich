//
//  ViewController.swift
//  putMapStuffTogether
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
    var startDraw: Bool = false
    var tapCount: Int = 0
    var middle: CLLocationCoordinate2D?
    var topLeft: CLLocationCoordinate2D?
    var topRight: CLLocationCoordinate2D?
    var bottomLeft: CLLocationCoordinate2D?
    var clock: Clock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        let longPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        longPressRecognizer.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecognizer)
        
        mapView.mapType = .standard
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(keyLat), longitude: CLLocationDegrees(keyLong))
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        if tapCount == 0 {
            let alert = UIAlertController(title: "Draw", message: "Press Start to add corners", preferredStyle: .alert)
            let drawAction = UIAlertAction(title: "Start", style: .default) { _ in
                self.tapCount += 1
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(drawAction)
            alert.addAction(cancelAction)
            present(alert, animated: false)
            return
        }
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
        print(tapCount)
        if tapCount == 1 {
            middle = coordinate
            tapCount += 1
        } else if tapCount == 2 {
            topLeft = coordinate
            tapCount += 1
        } else if tapCount == 3 {
            topRight = coordinate
            tapCount += 1
        } else if tapCount == 4 {
            bottomLeft = coordinate
            tapCount += 1
            guard let middle = middle, let topLeft = topLeft, let topRight = topRight, let bottomLeft = bottomLeft else {
                return
            }
            clock = Clock(midCoord: middle, topLeftCoord: topLeft, topRightCoord: topRight, bottomLeftCoord: bottomLeft)
            addOverlay()
            return
        } else {
            tapCount = 0
            return
        }
        
        print(coordinate)
        //        add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "latitude: " + String(format: "%0.02f", annotation.coordinate.latitude) + "longitude: " + String(format: "%0.02f", String(format: "%0.02f", annotation.coordinate.longitude))
        mapView.addAnnotation(annotation)
    }
    
    func addOverlay() {
        guard let clock = clock else {
            return
        }
        let overlay = ClockOverlay(clock: clock)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addOverlay(overlay)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let latValString: String = String(format: "%0.02f", Float(((view.annotation?.coordinate.latitude)!)))
        let longValString: String = String(format: "%0.02f", Float(((view.annotation?.coordinate.longitude)!)))
        print("latitude \(latValString)", "longitude \(longValString)")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      return ClockOverlayView(
        overlay: overlay,
        overlayImage: UIImage(imageLiteralResourceName: "clock"))
    }
    
}

