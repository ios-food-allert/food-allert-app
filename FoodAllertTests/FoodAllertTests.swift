//
//  FoodAllertTests.swift
//  FoodAllertTests
//
//  Created by José Gil Ramírez S on 1/1/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import XCTest
@testable import FoodAllert

class FoodAllertTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIngredientSearch(){
        let ingredient = "Base de soya (agua y semillas de soya seleccionadas), azúcares, saborizante idéntico al natural, mezcla de vitaminas y minerales (calcio, vitamina E, vitamina A, vitamina D, vitamina B12, vitamina B2, vitamina B6, ácido fólico y zinc), citrato de sodio, sal yodada, goma gellana, goma xantana, caramelo clase IV, sucralosa (11 mg/100 mg) y lecitina de soya. Contiene soya. Elaborado en líneas que procesan nueces"
        let promise = expectation(description: "Retrieve response from service")
        FoodPrediccionService.sharedInstance.search(ingredient: ingredient) { (results) in
            let foodPrediccion = results.resultObject
            print(foodPrediccion?.entities)
            promise.fulfill()
            XCTAssertGreaterThan(foodPrediccion?.entities.count ?? 0, 0)
        }
        waitForExpectations(timeout: 30, handler: nil)
        
    }

}
