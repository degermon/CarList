//
//  CarList.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-08.
//

import Foundation
import RxSwift
import RxCocoa

class CarList {
    static let shared = CarList()
    var fullList: [Car] = [] // full list from api
    var listToDisplay: BehaviorRelay<[Car]> = BehaviorRelay(value: []) // list to display in table view
    
    func sortByDistanceFromCurrent(){
        let sortedCarList = listToDisplay.value.sorted { (car1, car2) -> Bool in
            Locations.shared.distanceFrom(latitude: car1.location?.latitude, longitude: car1.location?.longitude, to: Locations.shared.usercoordinates)! < Locations.shared.distanceFrom(latitude: car2.location?.latitude, longitude: car2.location?.longitude, to: Locations.shared.usercoordinates)!
        }
        listToDisplay.accept(sortedCarList)
    }
    
    func getDistanceFromCurrent() { // calculate distance from current and add to carList arrays
        var newList: [Car] = []
        for item in fullList { // for checking (temporary)
            let distance = Locations.shared.distanceFrom(latitude: item.location?.latitude, longitude: item.location?.longitude, to: Locations.shared.usercoordinates)
            var updatedCarItem = item
            updatedCarItem.distanceToCar = distance
            newList.append(updatedCarItem)
        }
        fullList = newList
        listToDisplay.accept(newList)
    }
    
    func filterByPlateNumber(for text: String) {
        var filteredCarList: [Car] = []
        for item in fullList {
            if let plateNumber = item.plateNumber {
                if plateNumber.lowercased().contains(text.lowercased()) {
                        filteredCarList.append(item)
                }
            }
        }
        listToDisplay.accept(filteredCarList)
    }
    
    func filterByBattery(for text: String) {
        var filteredCarList: [Car] = []
        let filterBattery = Int(text) ?? 0 // in invalid conversion to int, set as 0
        for item in fullList {
            if let battery = item.batteryPercentage {
                if battery >= filterBattery {
                    filteredCarList.append(item)
                }
            }
        }
        listToDisplay.accept(filteredCarList)
    }
}
