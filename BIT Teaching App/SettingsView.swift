//
//  SettingsView.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 5/11/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var accessibilityManager: AccessibilityManager

    var body: some View {
        Form {
            Section(header: Text("Accessibility Settings")) {
                Toggle(
                    "Enable Voice Feedback (if VoiceOver is off)",
                    isOn: $accessibilityManager.userWantsSpeech
                )
                .accessibilityLabel("Enable voice feedback when VoiceOver is not running.")
                // 🆕 Use the zero-param version:
                .onChange(of: accessibilityManager.userWantsSpeech) {
                    let msg = accessibilityManager.userWantsSpeech
                        ? "Voice feedback enabled"
                        : "Voice feedback disabled"
                    accessibilityManager.speak(msg)
                }
                /*
                // — or —
                // If you want both old & new values, use the two-param version:
                .onChange(of: accessibilityManager.userWantsSpeech) { oldValue, newValue in
                    let msg = newValue
                        ? "Voice feedback enabled"
                        : "Voice feedback disabled"
                    accessibilityManager.speak(msg)
                }
                */
            }
        }
        .navigationTitle("Settings")
    }
}


