//
//  NetworkServiceTests.swift
//  ExchangeListTests
//
//  Created by Fabricio Padua on 8/29/24.
//

import XCTest
@testable import ExchangeList

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!

    override func setUp() {
        super.setUp()

        // Configure a custom URLSession with URLProtocolMock
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
        let customSession = URLSession(configuration: config)

        // Initialize NetworkService with the custom session
        networkService = NetworkService(session: customSession)
    }
    
    override func tearDown() {
        URLProtocolMock.testURLs = [:]  // Clear the mock data after each test
        networkService = nil
        super.tearDown()
    }
    
    func testFetchExchangesAndIconsSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch exchanges and icons")
        let exchangesURL = URL(string: "https://rest.coinapi.io/v1/exchanges")!
        let iconsURL = URL(string: "https://rest.coinapi.io/v1/exchanges/icons/32")!
        
        // Mock data for exchanges
        let mockExchangesData = """
        [
            {"exchange_id": "binance", "name": "Binance", "volume_1hrs_usd": 1000000, "volume_1day_usd": 1000000, "volume_1mth_usd": 1000000}
        ]
        """.data(using: .utf8)!
        
        // Mock data for icons
        let mockIconsData = """
        [
            {"exchange_id": "binance", "url": "https://example.com/icon.png"}
        ]
        """.data(using: .utf8)!
        
        URLProtocolMock.testURLs = [exchangesURL: mockExchangesData, iconsURL: mockIconsData]
        
        // When
        networkService.fetchExchangesAndIcons { exchanges in
            // Then
            XCTAssertEqual(exchanges.count, 1, "Expected one exchange")
            XCTAssertEqual(exchanges.first?.exchange_id, "binance", "Expected exchange_id to be 'binance'")
            XCTAssertEqual(exchanges.first?.icon_url, "https://example.com/icon.png", "Expected icon_url to be 'https://example.com/icon.png'")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testFetchExchangesAndIconsFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch exchanges and icons failure")
        let exchangesURL = URL(string: "https://rest.coinapi.io/v1/exchanges")!
        let iconsURL = URL(string: "https://rest.coinapi.io/v1/exchanges/icons/32")!
        
        // Mock error responses by providing no data for URLs
        URLProtocolMock.testURLs = [exchangesURL: Data(), iconsURL: Data()]
        
        // When
        networkService.fetchExchangesAndIcons { exchanges in
            // Then
            XCTAssertTrue(exchanges.isEmpty, "Expected no exchanges to be returned")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
}
