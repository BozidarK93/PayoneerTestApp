//
//  PaymentProviderViewDelegateMock.swift
//  PayoneerTestAppTests
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation
@testable import PayoneerTestApp

class PaymentProviderViewDelegateMock: PaymentProviderViewDelegate {

    var didDisplayPaymentsProviderData: Bool = false
    var didDisplayError: Bool = false
    var didDisplayLoadingView: Bool = false
    var viewDataMock: [PaymentProviderViewData] = []

    func displayPaymentsProviderData(with viewData: [PaymentProviderViewData]) {
        didDisplayPaymentsProviderData = true
        viewDataMock = viewData
    }

    func displayError(with error: Error) {
        didDisplayError = true
    }

    func displayLoadingView() {
        didDisplayLoadingView = true
    }
}
