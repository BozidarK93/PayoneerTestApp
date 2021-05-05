//
//  APIClient.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

public protocol APIClient {
    /// The base URLComponents.
    var baseUrlComponents: URLComponents? { get }

    /// Used for JSON decoding.
    var decoder: JSONDecoder { get }

    /// The session to be used when creating URLSessionDataTasks.
    var session: URLSession { get }


    /// Uses  a URLSessionDataTask .
    ///
    /// - Parameters:
    ///   - request: APIRequest we send to the backend.
    ///   - completion: Result Completion handler.
    /// - Returns: URLSessionDataTask for the corresponding resource, or nil.
    func sendRequest<T: DecodableAPIRequest>(for request: T, completion: @escaping (APIResult<T>) -> Void)
}

