//
//  NavigationState.swift
//  SwiftUISandbox
//
//  Created by Борис Анели on 20.11.2024.
//

import SwiftUI

@Observable
class NavigationNode: Identifiable {

    let id: String = UUID().uuidString

    var navigationHash: Int {
        var hasher = Hasher()
        hasher.combine(id)
        hasher.combine(root)
        hasher.combine(path.hashValue)
        return hasher.finalize()
    }

    let root: Route
    var path: [Route] = []
    var sheet: NavigationNode?
    var fullScreenCover: NavigationNode?

    private(set) weak var parent: NavigationNode?
    private(set) weak var child: NavigationNode?

    init(root: Route, parent: NavigationNode? = nil) {
        self.root = root
        self.parent = parent
    }

    func navigate(to route: Route) {
        path.append(route)
    }

    func sheet(_ route: Route) {
        guard child == nil else {
            assertionFailure("Another view is already presented")
            return
        }
        sheet = NavigationNode(root: route, parent: self)
        child = sheet
    }

    func fullScreen(_ route: Route) {
        guard child == nil else {
            assertionFailure("Another view is already presented")
            return
        }
        fullScreenCover = NavigationNode(root: route, parent: self)
        child = fullScreenCover
    }

    func dismiss() {
        guard let parent = parent else { return }
        parent.sheet = nil
        parent.fullScreenCover = nil
    }
}
