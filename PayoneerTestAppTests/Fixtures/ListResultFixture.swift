//
//  ListResultFixture.swift
//  PayoneerTestAppTests
//
//  Created by Bozidar Kokot on 05.05.21.
//

import Foundation
@testable import PayoneerTestApp

extension ListResult {

    static func fixture() -> ListResult {
        let url: URL = URL(string: "https://resources.integration.oscato.com/resource/network/MOBILETEAM/en_US/AMEX/logo3x.png")!
        return ListResult(networks: Networks(applicable: [ApplicableNetwork(code: "DE", label: "test-name", method: "test-method", grouping: "", registration: "", recurrence: "", redirect: false, button: "", selected: false, iFrameHeight: 100, emptyForm: true, links: ["logo": url])]))
    }
}
