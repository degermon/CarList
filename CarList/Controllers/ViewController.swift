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
    @IBOutlet weak var resetAllButton: UIButton!
    @IBOutlet weak var filterByButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    let locationManager = CLLocationManager()
    var filterBy: BehaviorRelay<String> = BehaviorRelay(value: "Plate number")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateFilterByButtonTitle()
        registerCell()
        checkLocationPermissions()
        configureLocationManager()
        setupObserver()
        setupSearchConfiguration()
        setupCellConfiguration()
        setupButtonconfiguration()
        fetchCars()
    }
    
    // MARK: - Config

    private func fetchCars() {
        Networking.shared.fetchCarData { (result) in
            CarList.shared.fullList = result
            CarList.shared.listToDisplay.accept(result)
            self.getcurrentLocation() // get current location first time
            CarList.shared.getDistanceFromCurrent() // get distance based on current location
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
    
    func resetCarListToShow() {
        CarList.shared.listToDisplay.accept(CarList.shared.fullList)
//        searchBar.text = ""
    }
    
    func updateFilterByButtonTitle() {
        filterByButton.setTitle("Filter by: \(filterBy.value)", for: .normal)
    }
    
    func filterByChoice() { // potato filter choice
        let alert = UIAlertController(title: "Filter by:", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Plate number", style: .default, handler: { (choice) in
            self.filterBy.accept(choice.title!)
            self.updateFilterByButtonTitle()
        }))
        alert.addAction(UIAlertAction(title: "Battery", style: .default, handler: { (choice) in
            self.filterBy.accept(choice.title!)
            self.updateFilterByButtonTitle()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
