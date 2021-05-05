//
//  GetPaymentProviders.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

struct GetPaymentProviders: DecodableAPIRequest {

    typealias Response = ListResult

    var additionalHeaders: [String: String]?

    var httpBody: Data?

    var httpRequestMethod: HTTPRequestMethod = .get

    var path: String {
        return "/lists/listresult.json"
    }

    var queryItems: [URLQueryItem]?
}
