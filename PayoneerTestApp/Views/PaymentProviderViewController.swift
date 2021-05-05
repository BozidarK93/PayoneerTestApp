//
//  ViewController.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import UIKit

class PaymentProviderViewController: UIViewController {

    @IBOutlet weak var paymentListView: UITableView!
    private let presenter = PaymentProviderViewPresenter()
    var activityView: UIActivityIndicatorView?

    private var viewData: [PaymentProviderViewData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        paymentListView.delegate = self
        paymentListView.dataSource = self
        paymentListView.tableFooterView = UIView()
        presenter.setViewDelegate(with: self)
        presenter.fetchAvailablePaymentNetworks()
    }
}

//MARK: PaymentProviderViewDelegate

extension PaymentProviderViewController: PaymentProviderViewDelegate {

    func displayPaymentsProviderData(with viewData: [PaymentProviderViewData]) {
        // Dispatch UI updates from the API to the main thread
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            self.viewData = viewData
            self.paymentListView.reloadData()
        }
    }

    func displayError(with error: Error) {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            let alert = UIAlertController(title: "Ops something went wrong", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func displayLoadingView() {
        showActivityIndicator()
    }
}

//MARK: UITableViewDelegate & UITableViewDataSource

extension PaymentProviderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentProviderCell", for: indexPath) as! PaymentProviderCell

        let provider = viewData[indexPath.row]
        cell.providerName.text = provider.providerName
        cell.providerLogo.image = provider.providerLogo

        return cell
    }
}

//MARK: Private helpers

extension PaymentProviderViewController {

    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator(){
        activityView?.stopAnimating()
    }
}

