//
//  PaymentProviderRepositoryMock.swift
//  PayoneerTestAppTests
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation
@testable import PayoneerTestApp

class PaymentProviderRepositoryMock: PaymentProviderRepository {

    var isFailure = false

    func getPaymentProviders(completion: @escaping (Error?, ListResult?) -> Void) {
        if isFailure {
            completion(APIError.unrecognizedFormat, nil)
        } else {
            completion(nil, ListResult.fixture())
        }
    }
}
