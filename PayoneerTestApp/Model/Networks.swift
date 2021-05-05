//
//  Networks.swift
//  PayoneerTestApp
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation

/// List response with possible payment networks
struct Networks: Decodable {
    /// Collection of applicable payment networks that could be used by a customer to complete the payment in scope of this `LIST` session
    let applicable: [ApplicableNetwork]
}
