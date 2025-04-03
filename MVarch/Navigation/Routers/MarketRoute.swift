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
}

struct MarketRouter {
    let route: MarketRoute
    let injector: Injector

    @ViewBuilder
    func configure() -> some View {
        switch route {
        case .list:
            let viewModel = MarketViewModel(
                repository: injector.marketRepository,
                mapper: MarketListViewModelMapper()
            )
            MarketListScreen(viewModel: viewModel)
        case .filter:
            MarketFilterScreen()
        }
    }
}
