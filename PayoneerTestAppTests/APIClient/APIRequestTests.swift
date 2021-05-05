//
//  APIRequestTests.swift
//  PayoneerTestAppTests
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation
import XCTest
@testable import PayoneerTestApp

class APIRequestTests: XCTestCase {

    // MARK: HTTP method

    func testHTTPMethodIsSetFromRequestForPostRequest() throws {
        let request = APIRequestFake(httpRequestMethod: .post)

        let urlRequest = try XCTUnwrap(request.buildRequest(withBaseUrl: URL(string: "www.api-client.com")))

        XCTAssertEqual(urlRequest.httpMethod, "POST")
    }

    func testHTTPMethodIsSetFromRequestForGetRequest() throws {
        let request = APIRequestFake(httpRequestMethod: .get)

        let urlRequest = try XCTUnwrap(request.buildRequest(withBaseUrl: URL(string: "www.api-client.com")))

        XCTAssertEqual(urlRequest.httpMethod, "GET")
    }

    // MARK: URL

    func testURLIsComposedCorrectly() throws {
        let request = APIRequestFake(httpRequestMethod: .get)

        let urlRequest = try XCTUnwrap(request.buildRequest(withBaseUrl: URL(string: "www.api-client.com")))

        XCTAssertEqual(urlRequest.httpMethod, "GET")

        XCTAssertEqual(urlRequest.url?.absoluteString, "www.api-client.com/fake/path")
    }

    // MARK: Query items

    func testNoQueryItemsAreSetIfRequestDefinesNoParameters() throws {
        let request = APIRequestFake(path: "/foo/bar/baz")

        let urlRequest = try XCTUnwrap(request.buildRequest(withBaseUrl: URL(string: "www.api-client.com")))

        let url = try XCTUnwrap(urlRequest.url)
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        XCTAssertNil(urlComponents?.queryItems)
    }

    func testQueryItemIsSetFromRequestParameter() throws {
        let queryItems = [
            URLQueryItem(name: "a", value: "b")
        ]
        let request = APIRequestFake(path: "/foo/bar", queryItems: queryItems)

        let urlRequest = try XCTUnwrap(request.buildRequest(withBaseUrl: URL(string: "www.api-client.com")))

        let url = try XCTUnwrap(urlRequest.url)
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        XCTAssertEqual(urlComponents?.queryItems?.count, 1)
        XCTAssert(urlComponents?.queryItems?.contains(queryItems[0]) == true)
    }


    // MARK: Headers

    func testHeadersAreSetCorrectly() throws {
        let stubbedHeaders = ["Authorization": "Bearer abc", "X-Foo": "Bar"]
        let request = APIRequestFake(httpRequestMethod: .post, additionalHeaders: stubbedHeaders)

        let urlRequest = try XCTUnwrap(request.buildRequest(withBaseUrl: URL(string: "www.api-client.com")))

        let headers = try XCTUnwrap(urlRequest.allHTTPHeaderFields)
        XCTAssertEqual(headers.count, 2)
        XCTAssertEqual(headers["Authorization"], "Bearer abc")
        XCTAssertEqual(headers["X-Foo"], "Bar")
    }
}
