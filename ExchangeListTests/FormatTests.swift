//
//  FormatTests.swift
//  ExchangeListTests
//
//  Created by Fabricio Padua on 8/29/24.
//

import XCTest
@testable import ExchangeList

class FormatTests: XCTestCase {

    var formatter: format!

    override func setUp() {
        super.setUp()
        formatter = format()
    }

    func testFormatNumberSort() {
        XCTAssertEqual(formatter.formatNumberSort(1_000_000_000), "1.00 B")
        XCTAssertEqual(formatter.formatNumberSort(1_500_000), "1.50 M")
        XCTAssertEqual(formatter.formatNumberSort(500), "500.00")
        XCTAssertEqual(formatter.formatNumberSort(-1_000_000), "-1.00 M")
    }
    
    func testFormatNumber() {
        XCTAssertEqual(formatter.formatNumber(123456.789), "123,456.79")
    }
}
