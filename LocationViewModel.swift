//
//  LocationViewModel.swift
//  Headache Tracker
//
//  Created by Nehal Jhala on 3/30/22.
//

import Foundation
import CoreLocation
import MapKit

class LocationViewModel: NSObject, CLLocationManagerDelegate{
    
//    var locationManager = CLLocationManager()
//    var region = MKCoordinateRegion()    
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//    }
}
  
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .denied: // Setting option: Never
//            print("LocationManager didChangeAuthorization denied")
//        case .notDetermined: // Setting option: Ask Next Time
//            print("LocationManager didChangeAuthorization notDetermined")
//        case .authorizedWhenInUse: // Setting option: While Using the App
//            print("LocationManager didChangeAuthorization authorizedWhenInUse")
//            //  Request a one-time location information
//            locationManager.requestLocation()
//        case .authorizedAlways: // Setting option: Always
//            print("LocationManager didChangeAuthorization authorizedAlways")
//            //  Request a one-time location information
//            locationManager.requestLocation()
//        case .restricted: // Restricted by parental control
//            print("LocationManager didChangeAuthorization restricted")
//        default:
//            print("LocationManager didChangeAuthorization")
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last{
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//            NotificationCenter.default
//                .post(name: NSNotification.Name("getRegion"),
//                      object: nil)
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("LocationManager didFailWithError \(error.localizedDescription)")
//        if let error = error as? CLError, error.code == .denied {
//            locationManager.stopMonitoringSignificantLocationChanges()
//            return
//        }
//    }







