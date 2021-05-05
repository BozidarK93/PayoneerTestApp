//
//  PaymentProviderRepository.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

protocol PaymentProviderRepository {
    func getPaymentProviders(completion: @escaping (Error?, ListResult?) -> Void)
}

class StandardPaymentProviderRepository: PaymentProviderRepository {

    private let apiClient: APIClient

    init(apiClient: APIClient = PaymentAPIClient()) {
        self.apiClient = apiClient
    }

    func getPaymentProviders(completion: @escaping (Error?, ListResult?) -> Void) {
        let request = GetPaymentProviders()
        apiClient.sendRequest(for: request) { result in
            switch result {
                case .failure(let error):
                    completion(error, nil)
                case .success(let response):
                    completion(nil, response)
            }
        }
    }
}
