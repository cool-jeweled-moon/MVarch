//
//  MainRouter.swift
//  SwiftUISandbox
//
//  Created by Борис Анели on 20.11.2024.
//

import SwiftUI
import NavigationGraph

enum AppRoute: NavigationGraphRoute {
    case market(MarketRoute)
}

struct AppRouter {
    let route: AppRoute
    let injector: Injector

    @ViewBuilder
    func build() -> some View {
        switch route {
        case let .market(route):
            MarketRouter(route: route, injector: injector)
                .build()
        }
    }
}
