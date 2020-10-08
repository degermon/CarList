//
//  ViewController.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class ViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortByDistanceButton: UIButton!
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        checkLocationPermissions()
        configureLocationManager()
        setupCarListObserver()
        setupCellConfiguration()
        fetchCars()
    }
    
    // MARK: - Config

    private func fetchCars() {
        Networking.shared.fetchCarData { (result) in
            CarList.shared.list.accept(result)
        }
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "CarCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "carCell")
    }

    private func configureLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    private func checkLocationPermissions() { // Add respective allerts
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                @unknown default:
                break
            }
            } else {
                print("Location services are not enabled")
        }
    }
    
    // MARK: - Actions
    
    @IBAction func sortByDistanceBtnTapped(_ sender: Any) {
        getcurrentLocation()
    }
}
