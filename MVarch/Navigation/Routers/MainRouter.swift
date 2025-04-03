//
//  MainRouter.swift
//  SwiftUISandbox
//
//  Created by Борис Анели on 20.11.2024.
//

import SwiftUI

enum Route: Identifiable, Hashable {
    var id: String { "\(hashValue)" }
    
    case market(MarketRoute)
}

struct MainRouter {
    let route: Route
    let injector: Injector

    @ViewBuilder
    func configure() -> some View {
        switch route {
        case let .market(route):
            MarketRouter(route: route, injector: injector).configure()
        }
    }
}
