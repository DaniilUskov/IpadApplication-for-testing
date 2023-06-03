//
//  IpadInformationViewController.swift
//  IpadApplication
//
//  Created by Даниил Усков on 03.06.2023.
//

import UIKit
import CoreLocation

class IpadInformationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var GeopositionVIew: UIView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
        
        /*override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         super.viewWillTransition(to: size, with: coordinator)
         if UIDevice.current.orientation.isLandscape {
         GeopositionVIew.backgroundColor = .blue
         
         } else {
         GeopositionVIew.backgroundColor = .red
         }
         }*/
        
        // LocationManager Delegates
        
        
    }
}
