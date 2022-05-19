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
    var point1: CGPoint?
    var point2: CGPoint?
//    var thetaADist: CGFloat?
//    var thetaBDist: CGFloat?
    var angle: CGFloat?
    var annotationRadius: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupTapGesture()
        
//        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
//        mapView.setRegion(region, animated: true)
//
//        pin = AnnotationPin(title: "Taj Mahal", subtitle: "One of the wonder's of the world", coordinate: coordinate)
//        mapView.addAnnotation(pin)
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if view.annotation?.title == "test" {
            
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: pin, reuseIdentifier: "tajPin")
        annotationView.image = UIImage(named: "clock1")
        guard let annotationRadius = annotationRadius else {
            return MKAnnotationView()
        }
        annotationView.frame = CGRect(x: 0, y: 0, width: annotationRadius * 2, height: annotationRadius * 2)
//        let twoPi: CGFloat = 2 * CGFloat(M_PI)
//        let radians: CGFloat = (atan2(thetaADis.t!, thetaBDist!) + twoPi).truncatingRemainder(dividingBy: two)
//        let angle = atan2(thetaADist!, annotationRadius)
//        print(atan2(thetaADist!, thetaBDist!))
//        let angle2 = atan(annotationRadius)
//        print(atan(thetaADist!))
//        print(angle, point1, point2, thetaADist, thetaBDist)
//        let theta_deg = angle/M_PI*180 + 180
        
        let transform = CGAffineTransform(rotationAngle: angle!)
        annotationView.transform = transform
        
//        return nil
        return annotationView
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        
        if tapCount == 0 {
            point1 = location
            tapCount += 1
        } else if tapCount == 1 {
            point2 = location
            tapCount = 0
        }
        
        if tapCount == 0 && point1 != nil && point2 != nil {
            let xDist: CGFloat = point2!.x - point1!.x
            let yDist: CGFloat = point2!.y - point1!.y
            let distance: CGFloat = sqrt((xDist * xDist) + (yDist * yDist))
//            let thirdPoint: CGPoint = (point1!.x, point2!.y)
            annotationRadius = distance
//            // distances for thetaX and thetaY
//            let thetaAxDist: CGFloat = point1!.x - point1!.x
//            let thetaAyDist: CGFloat = point2!.y - point1!.y
//            thetaADist = sqrt((thetaAxDist * thetaAxDist) + (thetaAyDist * thetaAyDist))
//            let thetaBxDist: CGFloat = point2!.x - point1!.x
//            let thetaByDist: CGFloat = point2!.y - point2!.y
//            thetaBDist = sqrt((thetaBxDist * thetaBxDist) + (thetaByDist * thetaByDist))
            let coordinate: CLLocationCoordinate2D = mapView.convert(point1 ?? location, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.title = "test ajkafjadfdk"
            annotation.subtitle = "devmountaint"
            annotation.coordinate = coordinate
//            let testAngle = atan2(thetaAyDist, thetaByDist) - atan2(thetaAxDist, thetaBxDist)
            let testAngle = atan2(yDist, xDist) + .pi/2
//            let testAngle = -atan2(thetaAxDist * thetaByDist - thetaAyDist * thetaBxDist, thetaAxDist * thetaBxDist + thetaAyDist * thetaByDist)
//            -atan2(vec1.x * vec2.y - vec1.y * vec2.x, dot(vec1, vec2))
//            where dot = vec1.x * vec2.x  + vec1.y * vec2.y
            
//            print("lhs \(atan2(thetaAyDist, thetaAxDist))", "rhs \(atan2(thetaByDist, thetaBxDist))")
//            let testAngle = atan2(thetaADist!, thetaBDist!)
            angle = testAngle
            print(testAngle)
            
            mapView.addAnnotation(annotation)
        }
        
    }

}

