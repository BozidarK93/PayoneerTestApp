//
//  APIRequest.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

public protocol DecodableAPIRequest {

    /// The associated response type to use when decoding the response from the API.
    associatedtype Response: Decodable

    /// A dictionary of additional headers to send with the request.
    var additionalHeaders: [String: String]? { get }

    /// The data sent as the message body of the request.
    var httpBody: Data? { get }

    /// The HTTP request method.
    var httpRequestMethod: HTTPRequestMethod { get }

    /// The path subcomponent appended to the base URL.
    var path: String { get }

    /// An array of query items for the URL, in the order in which they appear.
    var queryItems: [URLQueryItem]? { get }
}

extension DecodableAPIRequest {

    func buildRequest(withBaseUrl baseUrl: URL?) -> URLRequest? {
        guard let url = buildUrl(withBaseUrl: baseUrl) else {
            NSLog("Failed to build request for resource: \(String(describing: self))")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpRequestMethod.rawValue
        request.httpBody = httpBody

        additionalHeaders?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    private func buildUrl(withBaseUrl baseUrl: URL?) -> URL? {
        guard
            let baseUrl = baseUrl,
            var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        else {
            NSLog("Failed to build url for resource: \(String(describing: self))")
            return nil
        }
        components.path = baseUrl.path.appending(path)
        components.queryItems = queryItems

        return components.url
    }
}
