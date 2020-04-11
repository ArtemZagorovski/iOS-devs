//
//  ViewController.swift
//  API-First
//
//  Created by Артем  on 2/21/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        toggleActivityIndicator(on: true)
        getCurrentWeatherData()
    }
    
    
    lazy var weatherManager = APIWeatherManager(apiKey: "586e691ba1bd5976b1cc3e6581f3c3e5")
    let coordinate = Coordinates(latitude: 53.909324, longeitude: 27.453646)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        getCurrentWeatherData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last! as CLLocation
        print("\(userLocation.coordinate.latitude) \(userLocation.coordinate.longitude)")
    }
    
    func toggleActivityIndicator(on: Bool){
        refreshButton.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func getCurrentWeatherData(){
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinate) { (result) in
            self.toggleActivityIndicator(on: false)
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                let alertController = UIAlertController(title: "Unable to get data", message: "\(error)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    
    func updateUIWith(currentWeather: CurrentWeather) {
        self.imageView.image = currentWeather.icon
        self.temperatureLabel.text = currentWeather.temperatureString
        self.pressureLabel.text = currentWeather.pressureString
        self.humidityLabel.text = currentWeather.humidityString
        self.appearTemperatureLabel.text = currentWeather.apperentTemperatureString
    }
}

