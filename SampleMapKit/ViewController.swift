//
//  ViewController.swift
//  SampleMapKit
//
//  Created by Muhammad Raza on 08/08/2015.
//  Copyright (c) 2015 Muhammad Raza. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        // 1
        let location = CLLocationCoordinate2D(
            latitude: 51.50007773,
            longitude: -0.1246402
        )
        // 2
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        var tapRecognizer = UITapGestureRecognizer(target: self, action: "foundTap:")
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        self.mapView.addGestureRecognizer(tapRecognizer)
        
        
        var c1 = CLLocation(latitude: 51.50007773, longitude: -0.1246402)
        var c2 = CLLocation(latitude: 51.51007773, longitude: -0.1146402)
        var c3 = CLLocation(latitude: 48.49007773, longitude: -0.1146402)
        var c4 = CLLocation(latitude: 48.50007773, longitude: -0.1246402)
        
        var locationCorrdinates = [c1,c2,c3,c4]
        var coordinates:[CLLocationCoordinate2D] = []
        
        var numOfCoordinates = locationCorrdinates.count
        
        for var i:Int = 0; i < locationCorrdinates.count; i++ {
            var location = locationCorrdinates[i]
            var coordinate = location.coordinate
            
            coordinates.append(coordinate)
        }
        
        var polyLine = MKPolyline(coordinates: &coordinates, count: numOfCoordinates)
        //self.mapView.addOverlay(polyLine)
        
        self.mapView.delegate = self
        var circle = MKCircle(centerCoordinate: CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402), radius: 200)
        circle.title = "Check Point"
        mapView.addOverlay(circle)
        
        var circle1 = MKCircle(centerCoordinate: CLLocationCoordinate2D(latitude: 51.52007773, longitude: -0.1246402), radius: 200)
        circle1.title = "Check Point 1"
        mapView.addOverlay(circle1)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            var circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.redColor()
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
            circle.lineWidth = 1
            return circle
        }
        else {
            return nil
        }
    }
    
    func foundTap(sender: UITapGestureRecognizer){
        var point = sender.locationInView(self.mapView)
        
        let available = CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion)
        
        let pav1 = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 51.50007773, longitude: -0.1246402), radius: 200, identifier: "pavilion1")
        let pav2 = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 51.52007773, longitude: -0.1246402), radius: 200, identifier: "pavilion2")
        
        locationManager.startMonitoringForRegion(pav1)
        
        var tapPoint = self.mapView.convertPoint(point, toCoordinateFromView: self.view)
        
        println(tapPoint.latitude)
        println(tapPoint.longitude)
        
        if pav1.containsCoordinate(tapPoint) {
            self.performSegueWithIdentifier("getpic", sender: self)
        }else if pav2.containsCoordinate(tapPoint){
            self.performSegueWithIdentifier("getpic", sender: self)
        }
        
        var point1 = MKPointAnnotation()
        
        point1.coordinate = tapPoint
        self.mapView.addAnnotation(point1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

