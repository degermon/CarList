//
//  CarListTests.swift
//  CarListTests
//
//  Created by Daniel Šuškevič on 2020-10-10.
//

import XCTest
import RxCocoa
@testable import CarList

class CarListTests: XCTestCase {
    
    var sut: Locations!
    var sut1: ImageCache!
    var sut2: CarList!

    override func setUpWithError() throws {
        super.setUp()
        sut = Locations()
        sut1 = ImageCache()
        sut2 = CarList()
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
    
    func testFilterByPlateNumber() {
        sut2.fullList = [Car.init(id: 0, plateNumber: "a3"), Car.init(id: 1, plateNumber: "a2"), Car.init(id: 2, plateNumber: "b2"), Car.init(id: 4, plateNumber: "a1")]
        let expectedResult: [Car] = [Car.init(id: 1, plateNumber: "a2"), Car.init(id: 2, plateNumber: "b2")]
        
        sut2.filterByPlateNumber(for: "2")
        let filteredArray = sut2.listToDisplay.value
        
        if filteredArray.count == expectedResult.count {
            for i in 0...expectedResult.count - 1 {
                XCTAssertEqual(filteredArray[i].plateNumber, expectedResult[i].plateNumber, "Filter by platenumber not working")
            }
        } else {
            XCTFail()
        }
    }
    
    func testFilterByBattery() {
        sut2.fullList = [Car.init(batteryPercentage: 17), Car.init(batteryPercentage: 55), Car.init(batteryPercentage: 52), Car.init(batteryPercentage: 69), Car.init(batteryPercentage: 25)]
        let expectedResult: [Car] = [Car.init(batteryPercentage: 55), Car.init(batteryPercentage: 69)]
        
        sut2.filterByBattery(for: "55")
        let filteredArray = sut2.listToDisplay.value
        
        if filteredArray.count == expectedResult.count {
            for i in 0...expectedResult.count - 1 {
                XCTAssertEqual(filteredArray[i].batteryPercentage, expectedResult[i].batteryPercentage, "Filter by battery not working")
            }
        } else {
            XCTFail()
        }
    }
}
