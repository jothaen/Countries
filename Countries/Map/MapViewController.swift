//
//  MapViewController.swift
//  Countries
//
//  Created by Piotr Kozłowski on 30/04/2019.
//  Copyright © 2019 Piotr Kozłowski. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let lat: Double
    private let lng: Double
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.mapType = .standard
        view.showsScale = true
        view.isZoomEnabled = true
       
        return view
    }()
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        view.backgroundColor = .white
        initView()
    }
    
    private func initView() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let location = CLLocationCoordinate2D(latitude: lat,longitude: lng)
      
        let span = MKCoordinateSpan(latitudeDelta: 80, longitudeDelta: 80)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
    }
    
}
