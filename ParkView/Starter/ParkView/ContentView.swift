/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import MapKit

let park = Park(filename: "Clock")
let mapView = MKMapView(frame: UIScreen.main.bounds)

struct MapView: UIViewRepresentable {
  func makeUIView(context: Context) -> MKMapView {
    let latDelta = park.overlayTopLeftCoordinate.latitude - park.overlayBottomRightCoordinate.latitude

    // Think of a span as a tv size, measure from one corner to another
    let span = MKCoordinateSpan(latitudeDelta: fabs(latDelta), longitudeDelta: 0.0)
    let region = MKCoordinateRegion(center: park.midCoordinate, span: span)

    mapView.region = region
    mapView.delegate = context.coordinator

    return mapView
  }

  func updateUIView(_ uiView: MKMapView, context: Context) {
  }

  // Acts as the MapView delegate
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
      self.parent = parent
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      return ParkMapOverlayView(
        overlay: overlay,
        overlayImage: UIImage(imageLiteralResourceName: "tac12clock"))
    }
      
      func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          let annotationView = AttractionAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
          annotationView.canShowCallout = true
          return annotationView
      }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}

struct ContentView: View {
  @State var mapBoundary = false
  @State var mapOverlay = false
  @State var mapPins = false
  @State var mapCharacterLocation = false
  @State var mapRoute = false

  var body: some View {
    NavigationView {
      MapView()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(leading:
          HStack {
            Button(":Bound:") {
              self.mapBoundary.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapBoundary ? .white : .red)
            .background(mapBoundary ? Color.green : Color.clear)

            Button(":Overlay:") {
              self.mapOverlay.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapOverlay ? .white : .red)
            .background(mapOverlay ? Color.green : Color.clear)

            Button(":Pins:") {
              self.mapPins.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapPins ? .white : .red)
            .background(mapPins ? Color.green : Color.clear)

            Button(":Characters:") {
              self.mapCharacterLocation.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapCharacterLocation ? .white : .red)
            .background(mapCharacterLocation ? Color.green : Color.clear)

            Button(":Route:") {
              self.mapRoute.toggle()
              self.updateMapOverlayViews()
            }
            .foregroundColor(mapRoute ? .white : .red)
            .background(mapRoute ? Color.green : Color.clear)
          }
        )
    }
  }

  func addOverlay() {
    let overlay = ParkMapOverlay(park: park)
    mapView.addOverlay(overlay)
  }

  func addAttractionPins() {
      guard let attractions = Park.plist("MagicMountainAttractions") as? [[String: String]] else { return }
      
      for attraction in attractions {
          let coordinate = Park.parseCoord(dict: attraction, fieldName: "location")
          let title = attraction["name"] ?? ""
          let typeRawValue = Int(attraction["type"] ?? "0") ?? 0
          let type = AttractionType(rawValue: typeRawValue) ?? .misc
          let subtitle = attraction["subtitle"] ?? ""
          
          let annotation = AttractionAnnotation(
            coordinate: coordinate,
            title: title,
            subtitle: subtitle,
            type: type)
          mapView.addAnnotation(annotation)
      }
  }

  func addRoute() {
    // TODO: Implement
  }

  func addBoundary() {
    // TODO: Implement
  }

  func addCharacterLocation() {
    // TODO: Implement
  }

  func updateMapOverlayViews() {
    mapView.removeAnnotations(mapView.annotations)
    mapView.removeOverlays(mapView.overlays)

    if mapBoundary { addBoundary() }
    if mapOverlay { addOverlay() }
    if mapPins { addAttractionPins() }
    if mapCharacterLocation { addCharacterLocation() }
    if mapRoute { addRoute() }
  }
}
