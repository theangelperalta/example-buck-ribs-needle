//
//  TicTacToeUITests.swift
//  TicTacToeUITests
//
//  Created by Angel Cortez on 5/7/20.
//

import XCTest

class TicTacToeUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

//    func testExampleAppLabel() {
//        XCTAssertEqual(app.label, "ExampleApp")
//    }
//
//    func testMainScreenLabelExists() {
//        XCTAssert(app.staticTexts["Hello, world"].exists)
//    }
}
