//
//  MapVCViewController.swift
//  MyPlaces
//
//  Created by Артем  on 2/19/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewContollerDelegate {
    func getAddress(_ address: String?)
}

class MapVC: UIViewController {
    
    let mapManager = MapManager()
    var mapVCDelegate: MapViewContollerDelegate?
    var place = Place()
    
    let annotationID = "annotationID"
    var incomeSegueIdentifier = ""

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapPinImage: UIImageView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adressLabel.text = ""
        mapView.delegate = self
        setupMapView()
    }
    
    
    @IBAction func closeBs() {
        dismiss(animated: true)
    }
    
    @IBAction func centerViewInUserLocation() {
        
        mapManager.showUserLocation(mapView: mapView)
    }
    
    @IBAction func donewButtonPressed() {
        mapVCDelegate?.getAddress(adressLabel.text)
        dismiss(animated: true)
    }
    
    private func setupMapView() {
        if incomeSegueIdentifier == "showPlace"{
            mapManager.setupPlacemark(place: place, mapView: mapView)
            mapPinImage.isHidden = true
            adressLabel.isHidden = true
            doneButton.isHidden = true
        }
    }
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationID) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationID)
            annotationView?.canShowCallout = true
        }
        
        if let imageData = place.imageData {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.image = UIImage(data: imageData)
            annotationView?.rightCalloutAccessoryView = imageView
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let center = mapManager.getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(center) { (placemarks, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            let streetName = placemark?.thoroughfare
            let buildNumber = placemark?.subThoroughfare
            
            DispatchQueue.main.async {
                
                if streetName != nil && buildNumber != nil {
                    self.adressLabel.text = "\(streetName!), \(buildNumber!)"
                } else if streetName != nil {
                    self.adressLabel.text = "\(streetName!)"
                } else {
                    self.adressLabel.text = ""
                }
            }
            
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapManager.checkLocationAuthorization(mapView: mapView,
                                              segueIdentifier: incomeSegueIdentifier)
    }
}
