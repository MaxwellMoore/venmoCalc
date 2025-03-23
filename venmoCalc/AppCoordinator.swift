//
//  AppCoordinator.swift
//  venmoCalc
//
//  Created by Maxwell Lane Moore on 3/18/25.
//

import SwiftUI

class AppCoordinator: ObservableObject
{
    @Published var currentView: AnyView = AnyView(CalcView())

    func navigateTo(_ view: AnyView)
    {
        currentView = view
    }
}
