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
        if let title = currentCar.model?.title {
            cell.titleLabel.text = title
        }
        if let plateNumber = currentCar.plateNumber {
            cell.plateNumber.text = plateNumber
        }
        if let address = currentCar.location?.address {
            cell.locationLabel.text = address
        }
        if let batteryPrecentage = currentCar.batteryPercentage {
            cell.batteryLabel.text = "Battery: \(batteryPrecentage) %"
        }
        
        return cell
    }
}
