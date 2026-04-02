//
//  BIT_Teaching_AppApp.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 3/3/25.
//

import SwiftUI

@main
struct BIT_Teaching_AppApp: App {
    @StateObject private var accessibilityManager = AccessibilityManager.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(accessibilityManager)
        }
    }
}




