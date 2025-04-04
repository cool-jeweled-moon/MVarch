//
//  MarketRoute.swift
//  MVarch
//
//  Created by Борис Анели on 20.11.2024.
//

import SwiftUI

enum MarketRoute: Hashable {
    case list
    case filter

    @ViewBuilder
    func build(injector: Injector) -> some View {
        switch self {
        case .list:
            let model = MarketModel(
                repository: injector.marketRepository,
                mapper: MarketListViewModelMapper()
            )
            MarketListScreen()
                .environment(\.marketModel, model)
        case .filter:
            MarketFilterScreen()
        }
    }
}
