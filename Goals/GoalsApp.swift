//
//  GoalsApp.swift
//  Goals
//
//  Created by Dawid Łabno on 03/06/2023.
//

import SwiftUI

@main
struct GoalsApp: App {
    @StateObject private var goalViewModel = GoalViewModel() // Tworzenie instancji GoalViewModel
    var body: some Scene {
        WindowGroup {
            StartTabView()
                .environmentObject(goalViewModel)
        }
    }
}
