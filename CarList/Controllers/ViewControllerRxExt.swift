//
//  ViewControllerRxExt.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-08.
//

import Foundation
import RxSwift
import RxCocoa

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
}
