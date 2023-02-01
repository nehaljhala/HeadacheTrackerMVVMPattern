//
//  HeadacheTrackerViewController.swift
//  Headache Tracker
//
//  Created by Nehal Jhala.
//
import Foundation
import UIKit
import CoreLocation
import CoreData
import MapKit

class HeadacheTrackerViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var historyButton: UIBarButtonItem!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var tempAvgLabel: UILabel!
    @IBOutlet weak var humidityAvgLabel: UILabel!
    @IBOutlet weak var uviAvgLabel: UILabel!
    @IBOutlet weak var avgDurationLabel: UILabel!
    @IBOutlet weak var avgTimeLabel: UILabel!
    @IBOutlet weak var windSpeedAvgLabel: UILabel!
   
    var locationManager = CLLocationManager()
    var region = MKCoordinateRegion()  
    var lat = Double()
    var lon = Double()
    var endTime = Date()
    let dataArray : [NSManagedObject] = []
    var humidityAvg = Float()
    var tempAvg = Float()
    var windSpeedAvg = Float()
    var uviAvg = Float()
    var timeAvg = String()
    var avgDuration = Int()
    var persCont = HTPerCont()
    var analytics = Analytics()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if persCont.isRecordingInProgress() == true{
            startStopButton.setTitle("START", for: .normal)
        } else {
            startStopButton.setTitle("STOP", for: .normal)
        }
        analytics.doAnalysis()
        updateDashboard()
    }
    
        func updateDashboard() {
            tempAvgLabel.text = "Temperature - \(tempAvg) F"
            humidityAvgLabel.text = "Humiditiy - \(humidityAvg)"
            uviAvgLabel.text = "UV Index range - \(uviAvg)"
            windSpeedAvgLabel.text = "Wind speed - \(windSpeedAvg)mph"
            avgDurationLabel.text = "Average duration of headache in minutes - \(avgDuration)"
            avgTimeLabel.text = "Your Headache mostly occurs at \(timeAvg)"
        }
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        if  persCont.isRecordingInProgress() == false{
            persCont.stopButtonTapped(endTime)
            startStopButton.setTitle("START", for: .normal)
        }
        else {
            let client = HTClient()
            client.getJson(lat, lon) { [self] (json,error,success)  in
                if success == true{
                    DispatchQueue.main.async { [self] in
                        self.persCont.saveWeatherData(weather: json!, self.lat, lon)
                        analytics.doAnalysis()
                        updateDashboard()
                    }
                }
                else{
                    let alert = UIAlertController(title:"Unexpected Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            startStopButton.setTitle("STOP", for: .normal)
        }
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        //Segue to tableView
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        //Segue to LoginView
    }
   
    //Location Manager Delegate methods
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied: // Setting option: Never
            print("LocationManager didChangeAuthorization denied")
        case .notDetermined: // Setting option: Ask Next Time
            print("LocationManager didChangeAuthorization notDetermined")
        case .authorizedWhenInUse: // Setting option: While Using the App
            print("LocationManager didChangeAuthorization authorizedWhenInUse")
            //  Request a one-time location information
            locationManager.requestLocation()
        case .authorizedAlways: // Setting option: Always
            print("LocationManager didChangeAuthorization authorizedAlways")
            //  Request a one-time location information
            locationManager.requestLocation()
        case .restricted: // Restricted by parental control
            print("LocationManager didChangeAuthorization restricted")
        default:
            print("LocationManager didChangeAuthorization")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            NotificationCenter.default
                .post(name: NSNotification.Name("getRegion"),
                      object: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager didFailWithError \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied {
            locationManager.stopMonitoringSignificantLocationChanges()
            return
        }
    }

}
