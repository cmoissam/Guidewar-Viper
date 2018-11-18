//
//  Mobiapps_AppliTests.swift
//  Mobiapps AppliTests
//
//  Created by Lanouari on 11/15/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//
@testable import Mobiapps_Appli
import XCTest
//@testable import Mobiapps_Appli

class Mobiapps_AppliTests: XCTestCase {
    
    
    var groupInteractor : GroupInteractor!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        groupInteractor = GroupInteractor()
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        groupInteractor = nil
    }
    
    func testGroupIds(){
        
        groupInteractor.getGroupsIds()
        
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
    
}
