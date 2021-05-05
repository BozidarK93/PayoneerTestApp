//
//  APIRequestFake.swift
//  PayoneerTestAppTests
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation
@testable import PayoneerTestApp

struct APIRequestFake: DecodableAPIRequest {

    var queryItems: [URLQueryItem]?
    typealias Response = FakeResponse
    let additionalHeaders: [String: String]?
    let httpBody: Data?
    let httpRequestMethod: HTTPRequestMethod
    let path: String

    init(httpRequestMethod: HTTPRequestMethod = .get,
         path: String = "/fake/path",
         httpBody: Data? = nil,
         queryItems: [URLQueryItem]? = nil,
         additionalHeaders: [String: String]? = nil)
    {
        self.httpRequestMethod = httpRequestMethod
        self.path = path
        self.queryItems = queryItems
        self.httpBody = httpBody
        self.additionalHeaders = additionalHeaders
    }
}

// Convienience struct used for testing
struct FakeResponse: Codable {
    let fakeField: String
}
