// HomeView.swift
// BIT Teaching App

import SwiftUI
import CoreNFC

struct HomeView: View {
    @EnvironmentObject var accessibilityManager: AccessibilityManager
    @State private var navigationPath: [NFCDestination] = []
    @State private var nfcSession: NFCNDEFReaderSession?
    @State private var nfcDelegate: NFCSessionDelegate?

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 24) {
                Text("Welcome to Tap n' Learn")
                    .font(.largeTitle).bold()
                    .accessibilityLabel("Welcome to Tap and Learn. Choose a subject to study or scan an NFC tag.")
                    .accessibilityAddTraits(.isHeader)

                // 📡 Scan NFC Tag
                Button {
                    accessibilityManager.speak("Hold your iPhone near the NFC tag.")
                    beginScanning()
                } label: {
                    menuButton(
                        title: "Scan NFC Tag",
                        color: .blue,
                        description: "Scan a tag to learn about Math or Physics."
                    )
                }

                Divider().padding(.vertical, 10)

                // 📝 Quiz Mode
                NavigationLink(destination: QuizView()) {
                    menuButton(
                        title: "Tap N Math Quiz Mode",
                        color: .green,
                        description: "Test your math skills with a quiz."
                    )
                }

                Divider().padding(.vertical, 10)

                // ⚙️ Physics Lessons
                NavigationLink(destination: PhysicsView()) {
                    menuButton(
                        title: "Physics Lessons",
                        color: .orange,
                        description: "Explore interactive physics lessons."
                    )
                }

                Divider().padding(.vertical, 10)

                // ⚙️ Settings
                NavigationLink(destination: SettingsView()) {
                    menuButton(
                        title: "Settings",
                        color: .gray,
                        description: "Change speech and accessibility settings."
                    )
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Main Menu")
            .navigationDestination(for: NFCDestination.self) { dest in
                dest.view
            }
            .onAppear {
                // clear any stale navigation state
                navigationPath = []
                // speak welcome when in-app voice feedback is enabled
                accessibilityManager.speak(
                    "Welcome to Tap and Learn. Choose a subject to study or scan an NFC tag."
                )
            }
        }
    }

    // MARK: – Uniform button style (300×80)
    func menuButton(title: String, color: Color, description: String) -> some View {
        Text(title)
            .font(.title2)
            .foregroundColor(.white)
            .frame(width: 300, height: 80)
            .background(color)
            .cornerRadius(15)
            .shadow(radius: 3)
            .accessibilityLabel(description)
            .accessibilityHint("Double tap to select.")
    }

    // MARK: – NFC Scanning
    private func beginScanning() {
        guard NFCNDEFReaderSession.readingAvailable else {
            accessibilityManager.speak("NFC not supported on this device.")
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

    private func handleNFCResult(_ raw: String) {
        let tag = raw.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard raw != "invalid", !tag.isEmpty else {
            accessibilityManager.speak("Unrecognized NFC Tag")
            return
        }
        switch tag {
        case _ where tag.contains("speedball"):
            navigationPath.append(.speedBall)
            accessibilityManager.speak("Opening Speed Ball lesson.")
        case _ where tag.contains("elevator"):
            navigationPath.append(.elevator)
            accessibilityManager.speak("Opening Elevator Mechanics lesson.")
        case _ where tag.contains("breadboard"):
            navigationPath.append(.breadboard)
            accessibilityManager.speak("Opening Breadboard lesson.")
        case _ where tag.contains("waveboard"):
            navigationPath.append(.waveboard)
            accessibilityManager.speak("Opening Wave Types lesson.")
        case _ where tag.contains("guitar"):
            navigationPath.append(.guitar)
            accessibilityManager.speak("Opening Guitar and Sound lesson.")
        default:
            accessibilityManager.speak("Unrecognized NFC Tag")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AccessibilityManager.shared)
    }
}
