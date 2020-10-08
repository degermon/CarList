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
    var list: BehaviorRelay<[Car]> = BehaviorRelay(value: [])
}
