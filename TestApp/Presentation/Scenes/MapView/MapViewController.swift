//
//  MapViewController.swift
//  TestApp
//
//  Created by Shota Ito on 2021/06/18.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {

    // MARK: - UIs
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkUserLocationAuthorization()
        centerCurrentLocation()
    }
    
    private func setupView() {
        navigationItem.title = "Map"
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
}
