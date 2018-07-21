//
//  MapViewController.swift
//  Boot
//
//  Created by Nitin on 21/07/18.
//  Copyright © 2018 Nitin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var longitude: String?
    var latitude: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let centerCoordinate = CLLocationCoordinate2DMake(Double(latitude!)!, Double(longitude!)!)
        let region = MKCoordinateRegionMakeWithDistance(centerCoordinate, 500, 500)
        mapView.setRegion(region, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(Double(latitude!)!, Double(longitude!)!)
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: mapview delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinID = "EvenLocPin"
        let pinView: MKPinAnnotationView?
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinID) {
            pinView = dequedView as? MKPinAnnotationView
            pinView?.annotation = annotation
        }else {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinID)
        }
        return pinView!
    }
}
