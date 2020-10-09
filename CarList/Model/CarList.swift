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
    var fullList: BehaviorRelay<[Car]> = BehaviorRelay(value: [])
    var listToDisplay: BehaviorRelay<[Car]> = BehaviorRelay(value: [])
    
    func sortByDistanceFromCurrent(){
        let sortedCarList = CarList.shared.listToDisplay.value.sorted { (car1, car2) -> Bool in
            Locations.shared.distanceFrom(latitude: car1.location?.latitude, longitude: car1.location?.longitude, to: Locations.shared.usercoordinates)! < Locations.shared.distanceFrom(latitude: car2.location?.latitude, longitude: car2.location?.longitude, to: Locations.shared.usercoordinates)!
        }
        listToDisplay.accept(sortedCarList)
        
        //        for item in CarList.shared.list.value { // for checking (temporary)
        //            let distance = Locations.shared.distanceFrom(latitude: item.location?.latitude, longitude: item.location?.longitude, to: Locations.shared.usercoordinates)
        //            print(Int(distance ?? 0))
        //        }
    }
}
