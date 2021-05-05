//
//  PaymentProviderViewPresenter.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation
import UIKit

struct PaymentProviderViewData {
    let providerLogo: UIImage
    let providerName: String
}

protocol PaymentProviderViewDelegate: AnyObject {
    /// Passes the obtained payment provider view data in case of a success
    /// - Parameters:
    ///     - viewData: A list of parsed `PaymentProviderViewData`
    func displayPaymentsProviderData(with viewData: [PaymentProviderViewData])
    /// Passes the UI the delegation of displaying an error in case of a failure
    /// - Parameters:
    ///     - viewData: A list of parsed `PaymentProviderViewData`
    func displayError(with error: Error)
    /// Passes the UI the delegation of displaying a loading view in case the network call is being performed.
    func displayLoadingView()
}


class PaymentProviderViewPresenter {

    private let paymentProviderRepository: PaymentProviderRepository
    weak private var viewDelegate : PaymentProviderViewDelegate?

    init(repository: PaymentProviderRepository = StandardPaymentProviderRepository()){
        self.paymentProviderRepository = repository
    }

    func setViewDelegate(with viewDelegate: PaymentProviderViewDelegate?){
        self.viewDelegate = viewDelegate
    }

    func fetchAvailablePaymentNetworks() {
        viewDelegate?.displayLoadingView()

        paymentProviderRepository.getPaymentProviders { error, response in
            if let networkError = error {
                self.viewDelegate?.displayError(with: networkError)
            }
            if let network = response?.networks {
                let viewData = self.mapToViewData(from: network.applicable)
                self.viewDelegate?.displayPaymentsProviderData(with: viewData)
            }
        }
    }
}

extension PaymentProviderViewPresenter {
    // Maps the view data from the list of available payment providers. It parses and downloads the logo (if any) and assigns it to a UIImage. And it parses the label which it maps as a name of the payment provider
    private func mapToViewData(from applicableList: [ApplicableNetwork]) -> [PaymentProviderViewData] {
        var paymentListViewData: [PaymentProviderViewData] = []
        for applicable in applicableList {
            if let logoURL = applicable.links?["logo"],
               let logoData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: logoData){
                paymentListViewData.append(PaymentProviderViewData(providerLogo: logoImage, providerName: applicable.label))
            }
        }
        return paymentListViewData
    }
}
