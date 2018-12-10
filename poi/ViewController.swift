//
//  ViewController.swift
//  poi
//
//  Created by Quintin Smith on 12/8/18.
//  Copyright © 2018 wasatchcode. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var poi: [PointOfInterest] = [] { didSet { visiblePOI = poi; filterVisiblePOI() }}
    var visiblePOI: [PointOfInterest] = []
    let userLocation = CLLocationCoordinate2D(latitude: 38.88833, longitude: -77.0163)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterVisiblePOI()
        loadPointsOfInterest()
        centerMapInitialCoordinates()
        showPointsOfInterestInMap()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visiblePOI.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PointOfInterestCell", for: indexPath)
        
        //configure cell
        let point = visiblePOI[indexPath.row]
        cell.textLabel?.text = point.name
        cell.detailTextLabel?.text = "(\(point.coordinate.latitude), \(point.coordinate.longitude))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let point = visiblePOI[indexPath.row]
        if let annotation = (mapView.annotations as? [POIAnnotation])?.filter({ $0.pointOfInterest == point}).first {
            selectPinPointInTheMap(annotation: annotation)
        }
    }
    
    func selectPinPointInTheMap(annotation: POIAnnotation) {
        mapView.selectAnnotation(annotation, animated: true)
        
        if CLLocationCoordinate2DIsValid(annotation.coordinate) {
            self.mapView.setCenter(annotation.coordinate, animated: true)
        }
    }
    
    func loadPointsOfInterest() {
        guard let poiPath = Bundle.main.path(forResource: "museums_usa", ofType: "csv") else {
            print("unable to load file from Apps bundle")
            return
        }
        
        guard let poiData = FileManager.default.contents(atPath: poiPath) else {
            print("error getting data from poi file as \(poiPath)")
            return
        }
        
        guard let poitString = String(data: poiData, encoding: String.Encoding.utf8) else {
            print("unable to get a valid string from data in POI file \(poiPath)")
            return
        }
        
        for line in poitString.components(separatedBy: "\n") {
            if let point = PointOfInterest(csvLine: line) { poi.append(point) }
        }
    }
    
    func centerMapInitialCoordinates() {
        //fixed user location at latitude -77.01639, longitude 38.88833
        mapView.setCenter(userLocation, animated: true)
        let visibleRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 100000, longitudinalMeters: 100000)
        self.mapView.setRegion(self.mapView.regionThatFits(visibleRegion), animated: true)
    }
    
    func showPointsOfInterestInMap() {
        
        mapView.removeAnnotations(mapView.annotations)
        
        for point in poi {
            let pin = POIAnnotation(point: point)
            mapView.addAnnotation(pin)
        }
    }
    
    func filterVisiblePOI() {
        
        let visibleAnnotations = self.mapView.annotations(in: self.mapView.visibleMapRect)
        var annotations = [POIAnnotation]()
        
        for visibleAnnotation in visibleAnnotations {
            if let annotation = visibleAnnotation as? POIAnnotation {
                annotations.append(annotation)
            }
        }
        
        self.visiblePOI = annotations.map({ $0.pointOfInterest })
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        filterVisiblePOI()
    }


}

