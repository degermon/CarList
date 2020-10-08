//
//  ViewControllerTableViewExt.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarCell
        
        let currentCar = carList[indexPath.row]
        cell.titleLabel.text = currentCar.model?.title ?? ""
        cell.plateNumber.text = currentCar.plateNumber ?? ""
        cell.locationLabel.text = currentCar.location?.address ?? ""
        cell.batteryLabel.text = "Battery: \(currentCar.batteryPercentage ?? 0) %"
        
        ImageCache.shared.checkCacheForImageWith(key: currentCar.model?.photoUrl ?? "") { (image) in
            if let image = image {
                cell.carImage.image = image
            }
        }
        
        return cell
    }
}
