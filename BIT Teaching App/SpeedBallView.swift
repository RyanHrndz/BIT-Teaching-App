//
//  SpeedBallView.swift
//  BIT Teaching App
//

import SwiftUI
import CoreBluetooth
import AVFoundation
import UIKit

struct SpeedBallView: View {
    @StateObject private var bleManager = BLEManager()

    var body: some View {
        VStack(spacing: 20) {
            Text("Speed Ball – Motion & Acceleration")
                .font(.largeTitle)
                .bold()
                .padding()
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel("Speed Ball. Motion and Acceleration lesson.")

            Text(bleManager.isConnected ? "Speed Ball Connected ✅" : "Speed Ball Disconnected ❌")
                .foregroundColor(bleManager.isConnected ? .green : .red)
                .font(.headline)
                .accessibilityLabel("Connection Status")
                .accessibilityValue(bleManager.isConnected ? "Connected" : "Disconnected")

            Group {
                Text("Velocity: \(bleManager.velocity) m/s")
                    .accessibilityLabel("Velocity")
                    .accessibilityValue("\(bleManager.velocity) meters per second")

                Text("Acceleration: \(bleManager.acceleration) m/s²")
                    .accessibilityLabel("Acceleration")
                    .accessibilityValue("\(bleManager.acceleration) meters per second squared")

                Text("Distance: \(bleManager.distance) meters")
                    .accessibilityLabel("Distance")
                    .accessibilityValue("\(bleManager.distance) meters")
            }
            .font(.title3)
            .padding()

            Button(action: {
                bleManager.startScanning()
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                if UIAccessibility.isVoiceOverRunning {
                    UIAccessibility.post(notification: .announcement, argument: "Scanning for Speed Ball...")
                } else {
                    speakMetricsIfNeeded()
                }
            }) {
                Text("Connect to Speed Ball")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .accessibilityLabel("Connect to Speed Ball")
            .accessibilityHint("Tap to search and connect to the BLE device")

            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .accessibilityRespondsToUserInteraction(true)
    }

    // Optional voice feedback when not using VoiceOver
    func speakMetricsIfNeeded() {
        if !UIAccessibility.isVoiceOverRunning && bleManager.isConnected {
            let text = """
                Velocity: \(bleManager.velocity) meters per second.
                Acceleration: \(bleManager.acceleration) meters per second squared.
                Distance: \(bleManager.distance) meters.
            """
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            AVSpeechSynthesizer().speak(utterance)
        }
    }
}
