//
//  MVarchApp.swift
//  MVarch
//
//  Created by Борис Анели on 03.04.2025.
//

import SwiftUI
import SwiftData
import NavigationGraph

@main
struct MVarchApp: App {

    private let injector = Injector()

    @State
    private var navigationState = NavigationGraphState<AppRoute>(root: .market(.list))

    var body: some Scene {
        WindowGroup {
            NavigationGraphView(node: navigationState.root) { route in
                AppRouter(route: route, injector: injector)
                    .build()
            }
                .environment(navigationState)
//                .onFirstAppear {
//                    UNUserNotificationCenter.current()
//                        .requestAuthorization(
//                            options: [.alert, .badge, .sound]
//                        ) { success, error in
//                            if success {
//                                print("All set!")
//                            } else if let error {
//                                print(error.localizedDescription)
//                            }
//                        }
//                }
        }
//        .modelContainer(modelContainer)
    }
}
