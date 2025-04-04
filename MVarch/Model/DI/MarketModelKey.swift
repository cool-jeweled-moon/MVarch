//
//  MarketModelKey.swift
//  MVarch
//
//  Created by Борис Анели on 04.04.2025.
//

import SwiftUI

struct MarketModelKey: EnvironmentKey {
    static let defaultValue: any MarketModelProtocol = MarketModelMock()
}

extension EnvironmentValues {
    var marketModel: any MarketModelProtocol {
        get { self[MarketModelKey.self] }
        set { self[MarketModelKey.self] = newValue }
    }
}
