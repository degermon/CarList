//
//  ViewControllerRxExt.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-08.
//

import Foundation
import RxSwift
import RxCocoa
import RxCoreLocation
import AlamofireImage
import Alamofire

extension ViewController {
    func setupObserver() {
        CarList.shared.listToDisplay.asObservable().subscribe { (list) in // reload table view on change of listToDisplay array
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        filterBy.asObservable().subscribe { value in
            self.searchBar.placeholder = value + "..."
        }.disposed(by: disposeBag)
    }
    
    func setupSearchConfiguration() { // setup search bar
        searchBar.returnKeyType = .done
        
        searchBar.rx.text.orEmpty.subscribe { (querry) in // when entering/editing searchbar
            guard querry.element != "" else { // if no text present
                self.resetCarListToShow()
                return
            }
            if self.filterBy.value == "Plate number" { // if filter by selected as plate number
                CarList.shared.filterByPlateNumber(for: querry.element ?? "")
            } else if self.filterBy.value == "Battery" { // or battery
                CarList.shared.filterByBattery(for: querry.element ?? "")
            }
        }.disposed(by: disposeBag)
                
        searchBar.rx.searchButtonClicked.subscribe { (_) in // when done button is tapped, hide keyboard
            self.searchBar.resignFirstResponder()
        }.disposed(by: disposeBag)
    }
    
    func setupCellConfiguration() { // setup table view
        CarList.shared.listToDisplay.bind(to: tableView.rx.items(cellIdentifier: "carCell", cellType: CarCell.self)) { row, car, cell in
            cell.titleLabel.text = car.model?.title ?? ""
            cell.plateNumber.text = car.plateNumber ?? ""
            cell.locationLabel.text = car.location?.address ?? ""
            cell.batteryLabel.text = "Battery: \(car.batteryPercentage ?? 0) %"
            cell.batteryEstimatedDistnce.text = "Estimated distance: \(Int(car.batteryEstimatedDistance ?? 0)) Km."
            cell.distanceToCar.text = "Distance to car: \(Int(car.distanceToCar ?? 0)) m."
            
            ImageCache.shared.checkCacheForImageWith(key: car.model?.photoUrl ?? "") { (image) in
                if let image = image {
                    cell.carImage.image = image
                }
            }
        }.disposed(by: disposeBag)
    }
    
    func getcurrentLocation() { // get current location coordinates
        locationManager.rx
            .location.take(1) // take 1 so only executed 1 time
            .subscribe(onNext: { location in
                guard let location = location?.coordinate else { return }
                Locations.shared.usercoordinates = location
            })
            .disposed(by: disposeBag)
    }
    
    func setupButtonconfiguration() {
        sortByDistanceButton.rx.tap.bind{
            self.getcurrentLocation()
            CarList.shared.sortByDistanceFromCurrent()
        }.disposed(by: disposeBag)
        
        resetAllButton.rx.tap.bind {
            self.resetCarListToShow()
        }.disposed(by: disposeBag)
        
        filterByButton.rx.tap.bind{
            self.filterByChoice()
        }.disposed(by: disposeBag)
    }
}
