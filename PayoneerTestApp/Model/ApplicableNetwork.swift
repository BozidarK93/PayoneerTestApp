//
//  ApplicableNetwork.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

struct ApplicableNetwork: Decodable {
    /// Payment network code.
    let code: String

    /// Display label of the payment network.
    let label: String

    /// Indicates payment method this network belongs to.
    let method: String

    /// Grouping code; helps to group several payment networks together while displaying them on payment page (e.g. credit cards).
    let grouping: String

    /// Indicates whether this payment network supports registration and how this should be presented on payment page
    let registration: String

    /// Indicates whether this payment network supports recurring registration and how this should be presented on payment page
    let recurrence: String

    /// If `true` the payment via this network will result in redirect to the PSP web-site (e.g. PayPal, Sofortüberweisung, etc.)
    let redirect: Bool

    /// Code of button-label when this network is selected.
    let button: String?

    /// If `true` this network should been initially pre-selected.
    let selected: Bool?

    /// IFrame height for selective native, only supplied if "iFrame" link is present
    let iFrameHeight: Int?

    /// Indicates that form for this network is empty, without any text and input elements
    let emptyForm: Bool?


    /// Collection of links related to this payment network in scope of the `LIST` session
    let links: [String: URL]?

    // MARK: -
    enum Requirement: String {
        case NONE, OPTIONAL, OPTIONAL_PRESELECTED, FORCED, FORCED_DISPLAYED
    }

    var registrationRequirement: Requirement? { Requirement(rawValue: registration) }
    var recurrenceRequirement: Requirement? {
        Requirement(rawValue: recurrence)
    }
}
