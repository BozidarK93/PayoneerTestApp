//
//  PaymentProviderViewPresenterTests.swift
//  PayoneerTestAppTests
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation
import XCTest
@testable import PayoneerTestApp

class PaymentProviderViewPresenterTests: XCTestCase {

    var viewDelegateMock: PaymentProviderViewDelegateMock!
    var repositoryMock: PaymentProviderRepositoryMock!
    var sut: PaymentProviderViewPresenter!

    override func setUp() {
        super.setUp()

        repositoryMock = PaymentProviderRepositoryMock()
        viewDelegateMock = PaymentProviderViewDelegateMock()
        sut = PaymentProviderViewPresenter(repository: repositoryMock)
        sut.setViewDelegate(with: viewDelegateMock)
    }

    // MARK: View delegates test suites

    func testLoadingViewIsDisplayedWhenFetchingPaymentProviders() {
        sut.fetchAvailablePaymentNetworks()
        XCTAssertTrue(viewDelegateMock.didDisplayLoadingView)
    }

    func testErrorViewIsDisplayedWhenFetchingPaymentProviderFails() {
        repositoryMock.isFailure = true
        sut = PaymentProviderViewPresenter(repository: repositoryMock)
        sut.setViewDelegate(with: viewDelegateMock)
        sut.fetchAvailablePaymentNetworks()
        XCTAssertTrue(viewDelegateMock.didDisplayError)
    }

    func testProviderDataIsDisplayedWhenFetchingPaymentProviderSucceeds() {
        sut.fetchAvailablePaymentNetworks()
        XCTAssertTrue(viewDelegateMock.didDisplayPaymentsProviderData)
    }

    // MARK: View data mapping test suites

    func testViewDataIsMapedCorrectlyWhenFetchingPaymentProviderSucceeds() throws {
        sut.fetchAvailablePaymentNetworks()
        let viewData = try XCTUnwrap(viewDelegateMock.viewDataMock.first)
        XCTAssertEqual(viewData.providerName, "test-name")
    }
}
