// NFCScannerView.swift
// BIT Teaching App

import SwiftUI
import CoreNFC

struct NFCScannerView: View {
    @EnvironmentObject var accessibilityManager: AccessibilityManager
    @State private var scannedText     = "Tap to Scan NFC Tag"
    @State private var navigationPath: [NFCDestination] = []
    @State private var nfcSession: NFCNDEFReaderSession?
    @State private var nfcDelegate: NFCSessionDelegate?

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                Text(scannedText)
                    .font(.title2)
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)

                Button("Scan NFC Tag") {
                    accessibilityManager.speak("Hold your iPhone near the NFC tag.")
                    beginScanning()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding()
            .navigationDestination(for: NFCDestination.self) { dest in
                dest.view
                    .environmentObject(accessibilityManager)
            }
            .onAppear {
                accessibilityManager.speak("N F C Scanner. Tap the Scan NFC Tag button to begin.")
            }
        }
    }

    private func beginScanning() {
        print("🛫 beginScanning called")
        guard NFCNDEFReaderSession.readingAvailable else {
            print("❌ NFC reading not available")
            updateStatus("NFC not supported on this device.")
            return
        }

        let delegate = NFCSessionDelegate { result in
            handleNFCResult(result)
        }
        nfcDelegate = delegate

        let session = NFCNDEFReaderSession(
            delegate: delegate,
            queue: nil,
            invalidateAfterFirstRead: true
        )
        session.alertMessage = "Hold your iPhone near the NFC tag."
        nfcSession = session
        session.begin()
    }

    private func handleNFCResult(_ rawText: String) {
        print("🔑 handleNFCResult: \(rawText)")
        let tag = rawText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if rawText == "invalid" || tag.isEmpty {
            updateStatus("Unrecognized NFC Tag")
            return
        }

        scannedText = rawText
        accessibilityManager.speak(rawText)
        switch tag {
        case let t where t.contains("speedball"):
            navigationPath.append(.speedBall)
            accessibilityManager.speak("Opening Speed Ball lesson.")
        case let t where t.contains("elevator"):
            navigationPath.append(.elevator)
            accessibilityManager.speak("Opening Elevator Mechanics lesson.")
        case let t where t.contains("breadboard"):
            navigationPath.append(.breadboard)
            accessibilityManager.speak("Opening Breadboard lesson.")
        case let t where t.contains("waveboard"):
            navigationPath.append(.waveboard)
            accessibilityManager.speak("Opening Wave Types lesson.")
        case let t where t.contains("guitar"):
            navigationPath.append(.guitar)
            accessibilityManager.speak("Opening Guitar and Sound lesson.")
        default:
            updateStatus("Unrecognized NFC Tag")
        }
    }

    private func updateStatus(_ text: String) {
        scannedText = text
        accessibilityManager.speak(text)
    }
}

struct NFCScannerView_Previews: PreviewProvider {
    static var previews: some View {
        NFCScannerView()
            .environmentObject(AccessibilityManager.shared)
    }
}
