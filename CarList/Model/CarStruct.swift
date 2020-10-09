//
//  CarStruct.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import Foundation

struct Car: Decodable {
    var id: Int?
    var plateNumber: String?
    var location: Location?
    var model: Model?
    var batteryPercentage: Int?
    var batteryEstimatedDistance: Float?
    var isCharging: Bool?
    var servicePlusEGoPoints: Int?
    var distance: Double? // added additional element to store distance
}

struct Location: Decodable {
    var id: Int?
    var latitude: Double?
    var longitude: Double?
    var address: String?
}

struct Model: Decodable {
    var id: Int?
    var title: String?
    var photoUrl: String?
    var loyaltyPrize: Int?
    var rate: Rate?
}

struct Rate: Decodable {
    var isWeekend: Bool?
    var currency: String?
    var currencySymbol: String?
    var lease: Lease?
    var reservation: Reservation?
}

struct Lease: Decodable {
    var workdays: LeaseRate?
    var weekends: LeaseRate?
    var kilometerPrice: Float?
    var freeKilometersPerDay: Int?
}

struct LeaseRate: Decodable {
    var amount: Double?
    var minutes: Int?
    var dailyAmount: Float?
    var minimumPrice: Float?
    var minimumMinutes: Int?
}

struct Reservation: Decodable {
    var initialPrice: Float?
    var initialMinutes: Int?
    var extensionPrice: Float?
    var extensionMinutes: Int?
    var longerExtensionPrice: Float?
    var longerExtensionMinutes: Int?
}
