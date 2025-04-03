//
//  NavigationContainerView.swift
//  RiTodo
//
//  Created by Борис Анели on 05.01.2025.
//

import SwiftUI

struct NavigationContainerView: View {
    @State
    private(set) var node: NavigationNode

    @Environment(Injector.self)
    private var injector

    var body: some View {
        NavigationStack(path: $node.path) {
            MainRouter(route: node.root, injector: injector).configure()
                .navigationDestination(for: Route.self) { route in
                    MainRouter(route: route, injector: injector).configure()
                }
                .sheet(item: $node.sheet) { sheetNode in
                    NavigationContainerView(node: sheetNode)
                }
                .fullScreenCover(item: $node.fullScreenCover) { coverNode in
                    NavigationContainerView(node: coverNode)
                }
        }
        .id(node.navigationHash)
    }
}
