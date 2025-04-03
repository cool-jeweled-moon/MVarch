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

    @State
    private var navigationState = NavigationState(root: .market(.list))

    private let injector = Injector()

    var body: some Scene {
        WindowGroup {
            NavigationContainerView(node: navigationState.root)
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
                .environment(navigationState)
                .environment(injector)
        }
//        .modelContainer(modelContainer)
    }
}
