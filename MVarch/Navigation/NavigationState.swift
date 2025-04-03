//
//  NavigationState.swift
//  RiTodo
//
//  Created by Борис Анели on 05.01.2025.
//

import Foundation

@Observable
class NavigationState {

    let root: NavigationNode

    init(root: Route) {
        self.root = NavigationNode(root: root)
    }

    private var currentNode: NavigationNode {
        var currentNode = root
        while let child = currentNode.child {
            currentNode = child
        }
        return currentNode
    }

    func navigate(to route: Route) {
        currentNode.navigate(to: route)
    }

    func sheet(_ route: Route) {
        currentNode.sheet(route)
    }

    func fullScreen(_ route: Route) {
        currentNode.fullScreen(route)
    }

    func dismiss() {
        currentNode.dismiss()
    }

    func dismissToRoot() {
        root.dismiss()
    }
}
