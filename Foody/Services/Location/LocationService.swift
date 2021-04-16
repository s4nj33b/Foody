//
//  LocationService.swift
//  Foody
//
//  Created by Sanjeeb on 13/04/21.
//

import Foundation
import CoreLocation
import UIKit

class LocationService: NSObject {
    
    static var shared: LocationService = LocationService()
    
    var locationManager: CLLocationManager!
    var completionHandler: ((_ lat : String, _ long : String)->())?
    var errorHandler: ((_ error : Error)->())?
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            DLog("Location access was restricted.")
        case .denied:
            DLog("User denied access to location.")
            self.requestLocationIfDenied()
        case .notDetermined:
            self.locationManager.requestAlwaysAuthorization()
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            DLog("User choose location when app is in use.")
        default:
            DLog("Unhandled error occurred.")
        }
    }
    
    
    func requestLocationIfDenied() {
        let alertController = UIAlertController(title: "Allow \"Foody\" to access your location while you are using the app?", message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .cancel) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        alertController.show()
    }
    
    func determineCurrentLocation(withCompletionHandler completionHandler:@escaping (_ lat : String, _ long : String)->(), andErrorHandler errorHandler : @escaping (_ error : Error)->()) {
        
        self.completionHandler = completionHandler
        self.errorHandler = errorHandler
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
        let userLocation: CLLocation = locations[0] as CLLocation
        if let completion = self.completionHandler {
            DispatchQueue.main.async {
                completion(String(userLocation.coordinate.latitude),String(userLocation.coordinate.longitude))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let errorHandler = self.errorHandler {
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }
    
}
