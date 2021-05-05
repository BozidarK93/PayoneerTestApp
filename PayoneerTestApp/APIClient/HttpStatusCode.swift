//
//  HttpStatusCode.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

/// Enum representation of the status code we can get from the backend.
public enum HTTPStatusCode: Int {
    case success
    case redirection
    case clientError
    case serverError

    public init?(rawValue: Int) {
        switch rawValue {
        case 200...299: self = .success
        case 300...399: self = .redirection
        case 400...499: self = .clientError
        case 500...599: self = .serverError
        default: return nil
        }
    }
}
