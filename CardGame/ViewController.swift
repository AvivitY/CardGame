//
//  ViewController.swift
//  CardGame
//
//  Created by Student25 on 26/05/2023.
//

import UIKit
import CoreLocation
class ViewController: UIViewController,CLLocationManagerDelegate, ResultDelegate {
    
    @IBOutlet weak var westImg: UIImageView!
    @IBOutlet weak var eastImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBAction func nameBtn(_ sender: Any) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier:"popup") as! PopUpController?{
            viewController.delegate = self
            present(viewController,animated: true,completion: nil)
        }
    
    }
    var name = UserDefaults.standard.string(forKey: "Name")
    var lat = 0.0
    var long = 0.0
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        if(name != nil){
            nameBtn.isHidden = true
            nameLabel.text = "Hi, " + (name ?? "")
            // Ask for Authorisation from the User.
            self.locationManager.requestAlwaysAuthorization()
        }else {
            startBtn.isHidden = true
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        long = locValue.longitude
        if(long <= 34.817549168324334){
            print("long \(long)")
            eastImg.alpha = 0.1
            UserDefaults.standard.set(false, forKey: "isEast")
        }else{
            westImg.alpha = 0.1
            UserDefaults.standard.set(true, forKey: "isEast")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("location permissions denied")
        case .notDetermined:
            print("no location permissions")
        @unknown default:
            break
        }
    }
    func handleResult(_ result:Any?){
        if (result as! Bool == true) {
            name = UserDefaults.standard.string(forKey: "Name")
            nameBtn.isHidden = true
            nameLabel.text = "Hi, " + (name ?? "")
            startBtn.isHidden = false
            // Ask for Authorisation from the User.
            self.locationManager.requestAlwaysAuthorization()
        }
    }
    
}
