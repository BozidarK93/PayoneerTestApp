//
//  APIResult.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

public enum APIResult<T: DecodableAPIRequest> {
    case failure(error: APIError)
    case success(result: T.Response)
}
