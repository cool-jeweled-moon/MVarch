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

    @ViewBuilder
    func build(injector: Injector) -> any View {
        switch self {
        case .market(let marketRoute):
            marketRoute.build(injector: injector)
        }
    }
}
