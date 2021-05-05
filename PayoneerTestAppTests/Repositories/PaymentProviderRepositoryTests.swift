//
//  PaymentProviderRepositoryTests.swift
//  PayoneerTestAppTests
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation
import XCTest
@testable import PayoneerTestApp

class PaymentProviderRepositoryTests: XCTestCase {

    var sut: PaymentProviderRepository!
    var apiClient: PaymentAPIClientMock!

    override func setUp() {
        super.setUp()

        apiClient = PaymentAPIClientMock()
        sut = StandardPaymentProviderRepository(apiClient: apiClient)
    }

    func testSuccessClosurePassedWhenCallSucceeds() {
        let expectation = self.expectation(description: "Fetch payment provider")

        apiClient.isSuccess = true
        apiClient.expectedSuccess = ListResult.fixture()
        sut.getPaymentProviders { error, response in
            XCTAssertTrue(error == nil)
            XCTAssertNotNil(response?.networks.applicable.first)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testCorrectClosurePassedWhenFetchingPaymentProviderFails() {
        let expectation = self.expectation(description: "Fetch payment provider")

        apiClient.isSuccess = false
        apiClient.expectedFailure = APIError.client
        sut.getPaymentProviders { error, response in
            XCTAssertTrue(error != nil)
            XCTAssertNil(response?.networks.applicable.first)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
