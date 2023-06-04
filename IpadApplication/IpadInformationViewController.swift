//
//  IpadInformationViewController.swift
//  IpadApplication
//
//  Created by Даниил Усков on 03.06.2023.
//
import CoreLocation
import UIKit
import MapKit

class IpadInformationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var GeopositionVIew: UIView!
    @IBOutlet weak var mapInformation: UILabel!
    @IBOutlet weak var modelInfo: UILabel!
    @IBOutlet weak var versionInfo: UILabel!
    @IBOutlet weak var coordinatesInfo: UILabel!
    @IBOutlet weak var ipadName: UILabel!
    @IBOutlet weak var ipadSystemName: UILabel!
    
    let ipadInfo: UIDevice = UIDevice()
    
    private let map:MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GeopositionVIew.addSubview(map)
        title = "Home"
        self.mapInformation.text = "Загрузка..."
        fillIpadInfo()
        
        LocationManager.shared.gerUserLocation{ [weak self] location in
            DispatchQueue.main.async{
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addMapPin(with: location)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = GeopositionVIew.bounds
        map.frame.size.height = GeopositionVIew.bounds.height
        map.frame.size.width = GeopositionVIew.bounds.width
    }
    
    func addMapPin(with location: CLLocation){
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate,
                                                    span: MKCoordinateSpan(
                                                        latitudeDelta: 0.7,
                                                        longitudeDelta: 0.7)),
                                 animated:true)
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.mapInformation.text = locationName
            if var text = self?.coordinatesInfo.text{
                text += ", Координаты: широта - \(String(location.coordinate.latitude)), долгота - \(String(location.coordinate.longitude))"
                self?.coordinatesInfo.text = text
            }
        }
    }
    
    func fillIpadInfo(){
        if var text = modelInfo.text{
            text += "\(ipadInfo.model)"
            modelInfo.text = text
        }
        
        if var text = versionInfo.text{
            text += "\(ipadInfo.systemVersion)"
            versionInfo.text = text
        }
        
        if var text = ipadName.text{
            text += "\(ipadInfo.name)"
            ipadName.text = text
        }
        
        if var text = ipadSystemName.text{
            text += "\(ipadInfo.systemName)"
            ipadSystemName.text = text
        }
    }
}

