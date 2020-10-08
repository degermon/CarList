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
    func setupCarListObserver() {
        CarList.shared.list.asObservable().subscribe { (list) in
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    func setupCellConfiguration() {
        CarList.shared.list.bind(to: tableView.rx.items(cellIdentifier: "carCell", cellType: CarCell.self)) { row, car, cell in
                cell.titleLabel.text = car.model?.title ?? ""
                cell.plateNumber.text = car.plateNumber ?? ""
                cell.locationLabel.text = car.location?.address ?? ""
                cell.batteryLabel.text = "Battery: \(car.batteryPercentage ?? 0) %"
            
                ImageCache.shared.checkCacheForImageWith(key: car.model?.photoUrl ?? "") { (image) in
                    if let image = image {
                        cell.carImage.image = image
                    }
                }
        }.disposed(by: disposeBag)
    }
    
    func monitorAuthorization() {
        locationManager.rx
            .didChangeAuthorization
            .subscribe(onNext: {_, status in
                switch status {
                case .denied:
                    print("Authorization denied")
                case .notDetermined:
                    print("Authorization: not determined")
                case .restricted:
                    print("Authorization: restricted")
                case .authorizedAlways, .authorizedWhenInUse:
                    print("All good fire request")
                @unknown default:
                    print("Unknown")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func getcurrentLocation() {
        locationManager.rx
            .location.take(1) // take 1 so only executed 1 time
            .subscribe(onNext: { location in
                guard let location = location?.coordinate else { return }
                Locations.shared.usercoordinates = location
            })
            .disposed(by: disposeBag)
    }
    
//    func setupButtonconfiguration() {
//        sortByDistanceButton.rx.tap.bind{
//            
//        }.disposed(by: disposeBag)
//    }
}
