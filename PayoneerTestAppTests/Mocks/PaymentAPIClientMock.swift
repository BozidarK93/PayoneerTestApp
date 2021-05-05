//
//  PaymentAPIClientMock.swift
//  PayoneerTestAppTests
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation
@testable import PayoneerTestApp

class PaymentAPIClientMock: APIClient {
    var baseUrlComponents: URLComponents? {
        return URLComponents()
    }

    var decoder: JSONDecoder {
        return JSONDecoder()
    }

    var session: URLSession {
        return URLSession.shared
    }

    var isSuccess = false

    var expectedFailure = APIError.unrecognizedFormat
    var expectedSuccess = ListResult.fixture()

    func sendRequest<T>(for request: T, completion: @escaping (APIResult<T>) -> Void) where T : DecodableAPIRequest {
        isSuccess ? completion(.success(result: expectedSuccess as! T.Response)) : completion(.failure(error: expectedFailure))
    }

}
