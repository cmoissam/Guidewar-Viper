//
//  Mobiapps_AppliUITests.swift
//  Mobiapps AppliUITests
//
//  Created by Lanouari on 11/15/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import XCTest

class Mobiapps_AppliUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    
    func testFirstClick(){
        
        let app = XCUIApplication()
        app.launch()
        
        // Assert that we are displaying the tableview
        let categoryTableView = app.tables["categories"]
        
        XCTAssertTrue(categoryTableView.exists, "The article tableview exists")
        
        app.tables["categories"].cells.allElementsBoundByIndex.first?.tap()
        
        XCUIApplication().navigationBars["Achievements"].buttons["Categories"].tap()
        
        XCTAssertTrue(categoryTableView.exists, "The article tableview exists")
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  
    
}
