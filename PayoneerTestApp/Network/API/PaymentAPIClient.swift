//
//  PaymentAPIClient.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

class PaymentAPIClient: APIClient {

    var baseUrlComponents: URLComponents? {
        URLComponents(string: "https://raw.githubusercontent.com/optile/checkout-android/develop/shared-test")
    }

    var decoder: JSONDecoder {
        JSONDecoder()
    }

    var session: URLSession {
        URLSession.shared
    }


    func sendRequest<T: DecodableAPIRequest>(for resource: T, completion: @escaping (APIResult<T>) -> Void) {

        guard
            let baseURL = baseUrlComponents?.url,
            let request = resource.buildRequest(withBaseUrl: baseURL),
            let _ = request.url?.absoluteString
        else {
            completion(.failure(error: APIError.client))
            return
        }
        let task = session.dataTask(with: request) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                let httpStatusCode = HTTPStatusCode(rawValue: httpResponse.statusCode)
            else {

                completion(.failure(error: APIError.unrecognizedFormat))
                return
            }
            if httpStatusCode != .success {
                completion(.failure(error: APIError.network(httpStatusCode: httpStatusCode)))
                return
            }
            do {
                completion(.success(result: try self.decoder.decode(T.Response.self, from: data!)))
            } catch let error as NSError {
                completion(.failure(error: APIError.decoding(reason: error.userInfo)))
                return
            }
        }
        do {
            task.resume()
        }
    }
}
