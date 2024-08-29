//
//  ExchangeListUITests.swift
//  ExchangeListUITests
//
//  Created by Fabricio Padua on 8/29/24.
//

import XCTest

class ExchangeListUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        app = XCUIApplication()
        app.launch()
    }

    func testNavigationToDetailView() {
        let firstCell = app.tables.cells.element(boundBy: 1)
        XCTAssertTrue(firstCell.exists, "The first cell should exist")
        firstCell.tap()
        
        // Verifique a existência da barra de navegação com uma abordagem eventual
        XCTAssertEventually(self.app.navigationBars["Exchange Detail"].exists, timeout: 10, message: "The detail navigation bar should exist when first cell is tapped")
    }
}

extension XCTestCase {
    func XCTAssertEventually(_ expression: @autoclosure @escaping () -> Bool, timeout: TimeInterval = 10.0, message: String = "") {
        let predicate = NSPredicate { _, _ in expression() }
        let expectation = self.expectation(for: predicate, evaluatedWith: nil, handler: nil)
        wait(for: [expectation], timeout: timeout)
    }
}
