//
//  MVarchApp.swift
//  MVarch
//
//  Created by Борис Анели on 03.04.2025.
//

import SwiftUI
import SwiftData

@main
struct MVarchApp: App {

    private let injector = Injector()

    @State
    private var navigationState = NavigationState(root: .market(.list))

    var body: some Scene {
        WindowGroup {
            NavigationContainerView(
                node: navigationState.root,
                injector: injector
            )
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
