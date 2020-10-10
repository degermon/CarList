//
//  CarListTests.swift
//  CarListTests
//
//  Created by Daniel Šuškevič on 2020-10-10.
//

import XCTest
@testable import CarList

class CarListTests: XCTestCase {
    
    var sut: Locations!
    var sut1: ImageCache!
    var sut2: Networking!

    override func setUpWithError() throws {
        super.setUp()
        sut = Locations()
        sut1 = ImageCache()
        sut2 = Networking()
    }

    override func tearDownWithError() throws {
        sut = nil
        sut1 = nil
        sut2 = nil
        super.tearDown()
    }
    
    func testSortByDistanceFromCurrent() {
        let distance = sut.distanceFrom(latitude: 44.20, longitude: 44.20, to: .init(latitude: 44.22, longitude: 44.22))!
        XCTAssertEqual(Int(distance), 2737, "Distances not equal")
    }
    
    func testGetImageFromImageCache() {
        sut1.imageCache.add(UIImage(), withIdentifier: "testKey")
        
        sut1.checkCacheForImageWith(key: "testKey") { (result) in
            XCTAssertEqual(result, UIImage(), "Result image is not nil")
        }
    }
    
    func testGetImageFromUrl() {
    }

}
