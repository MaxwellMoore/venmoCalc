//
//  Calc.App.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

@main
struct VenmoCalcApp: App {
    @StateObject var coordinator = AppCoordinator()  // Coordinator to manage navigation

    var body: some Scene {
        WindowGroup {
            coordinator.currentView  // Start with the first screen
        }
    }
}
