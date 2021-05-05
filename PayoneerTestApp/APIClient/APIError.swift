//
//  APIError.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

/// Enum representation of all possible errors that could occur in the APIClient usage.
public enum APIError: Error {
    /// For client side errors, such as failing to build a request to the server.
    case client

    /// For decoding errors, such as failing to decode a response from the server.
    case decoding(reason: [String: Any]?)

    /// For network errors, such as 404 not found etc.
    case network(httpStatusCode: HTTPStatusCode)

    /// For when the client receives an unexpected response from the server.
    case unrecognizedFormat

    /// For when the network is unreachable.
    case unreachable
}
