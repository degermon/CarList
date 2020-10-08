//
//  Locations.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-08.
//

import CoreLocation

class Locations {
    static let shared = Locations()
    var usercoordinates: CLLocationCoordinate2D?
    
    func distanceFrom(latitude: Double?, longitude: Double?, to: CLLocationCoordinate2D?) -> CLLocationDistance? {
        guard let latitude = latitude, let longitude = longitude else { return nil }
        guard let coordinates = to else { return nil }
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return location.distance(from: coordinates)
    }
}
