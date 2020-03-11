//
//  MapManager.swift
//  MyPlaces
//
//  Created by Артем  on 2/19/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import MapKit

class MapManager {
    
    let locationManager = CLLocationManager()
    private let regionInMeters = 10_000.0
    
    func setupPlacemark(place: Place, mapView: MKMapView) {
           
           guard let location = place.location else { return }
           
           let geocoder = CLGeocoder()
           geocoder.geocodeAddressString(location) { (placemarks, error) in
               if let error = error {
                   print(error)
                   return
               }
               guard let placemarks = placemarks else { return }
               let placemark = placemarks.first
               
               let annotation = MKPointAnnotation()
               annotation.title = place.name
               annotation.subtitle = place.type
               
               guard let placemarkLocation = placemark?.location else { return }
               
               annotation.coordinate = placemarkLocation.coordinate
               
               mapView.showAnnotations([annotation], animated: true)
               mapView.selectAnnotation(annotation, animated: true)
           }
       }
    
    func checkLocationServices(mapView: MKMapView, segueIdentifier: String, closure: () -> ()) {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorization(mapView: mapView, segueIdentifier: segueIdentifier)
            closure()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(title: "Location services are disabled",
                               message: "Enable services")
            }
        }
    }
    
    func checkLocationAuthorization(mapView: MKMapView, segueIdentifier: String) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            if segueIdentifier == "getAdress" { showUserLocation(mapView: mapView) }
            break
        case .denied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showAlert(title: "Your location is not avaliable",
                           message: "Give permissions")
            }
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // alert
            break
        case .authorizedAlways:
            break
        @unknown default:
            print("new case is avalible")
        }
    }
    
    func showUserLocation(mapView: MKMapView) {
        
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location,
                                            latitudinalMeters: regionInMeters,
                                            longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func showAlert(title: String, message: String){
        
        let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alertC.addAction(ok)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertC, animated: true)
    }
    
    
    
}

