//
//  MapViewController.swift
//  TestApp
//
//  Created by Shota Ito on 2021/06/18.
//

import UIKit
import MapKit
import CoreLocation

final class PlaceAnnotation: MKPointAnnotation {

    let index: String
    var name: String
    var image: UIImage
    var latitude: Double
    var longitude: Double

    init(index: Int, name: String, image: UIImage, latitude: Double, longitude: Double) {
        self.index = index.description
        self.name = name
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
    }
}

final class MapViewController: UIViewController {

    // MARK: - UIs
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        checkUserLocationAuthorization()
        centerCurrentLocation()
        setAnnotations()
        
    }
    
    private func setupView() {
        navigationItem.title = "Map"
        mapView.delegate = self
    }
    
    // TODO: - Move Location Manager to UseCase or Feature layer
    private func checkUserLocationAuthorization() {
        let status = locationManager.authorizationStatus
        if case .notDetermined = status {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func centerCurrentLocation() {
        locationManager.startUpdatingLocation()
        mapView.userTrackingMode = .follow
        let userLocation = CLLocationCoordinate2D(latitude: mapView.userLocation.coordinate.latitude,
                                                  longitude: mapView.userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func setAnnotations() {
        // set an annotation that changes its image
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 35.68493104294112, longitude: 139.75273538025138)
        mapView.addAnnotation(annotation)
        
        // set an annotation that Custom View is used
        mapView.register(PlaceAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        let tokyoDome = PlaceAnnotation(index: 2, name: "東京ドーム", image: R.image.im_sp()!,
                                        latitude: 35.70580548548312, longitude: 139.7517604413992)
        tokyoDome.coordinate = CLLocationCoordinate2DMake(tokyoDome.latitude, tokyoDome.longitude)
        let jinbochoSt = PlaceAnnotation(index: 3,
                                         name: "神保町駅 ー 神保町は古本いっぱい楽しいうわーいうわーいうわーいうわーいうわーいうわーいうわーいうわーいうわーいうわーいうわーいうわーい",
                                         image: R.image.im_sp()!, latitude: 35.69591725953706, longitude: 139.75773500398736)
        jinbochoSt.coordinate = CLLocationCoordinate2DMake(jinbochoSt.latitude, jinbochoSt.longitude)
        mapView.addAnnotations([tokyoDome, jinbochoSt])
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // ignore UserLocation
        if annotation is MKUserLocation { return nil }
        
        switch annotation {
        case is PlaceAnnotation:
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? PlaceAnnotationView
            if let annotation = annotation as? PlaceAnnotation {
                annotationView?.label.text = annotation.index
            }
            return annotationView

        default:
            let identifier = "pin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            } else {
                annotationView?.annotation = annotation
            }

            annotationView?.image = R.image.ic_annotation()

            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // 自身の位置は無視
        if view.annotation is MKUserLocation { return }
        
        let calloutView = R.nib.placeCalloutView.firstView(owner: nil)!
        if let annotatioin = view.annotation as? PlaceAnnotation {
            calloutView.label.text = annotatioin.name
            calloutView.imageView.image = annotatioin.image
        }
        // ピンの中心にCalloutがフォーカスされるためInsetをかける
        let inset = PlaceAnnotationView.height / 2
        calloutView.center = CGPoint(x: view.bounds.size.width / 2,
                                     y: (-calloutView.bounds.size.height / 2) - inset)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: MKAnnotationView.self) {
            for subview in view.subviews {
                if subview.isKind(of: PlaceCalloutView.self) {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}
