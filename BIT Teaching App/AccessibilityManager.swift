// AccessibilityManager.swift
// BIT Teaching App

import Foundation
import UIKit
import AVFoundation

class AccessibilityManager: ObservableObject {
    static let shared = AccessibilityManager()
    
    // MARK: - Published Properties
    @Published var isVoiceOverRunning: Bool = UIAccessibility.isVoiceOverRunning
    
    @Published var userWantsSpeech: Bool {
        didSet {
            UserDefaults.standard.set(userWantsSpeech, forKey: "userWantsSpeech")
        }
    }

    // MARK: - Synthesizer
    private let synthesizer = AVSpeechSynthesizer()

    // MARK: - Computed Property
    /// Should speak if VoiceOver is NOT already running and the user has opted-in.
    var shouldSpeak: Bool {
        !isVoiceOverRunning && userWantsSpeech
    }

    // MARK: - Init
    private init() {
        self.userWantsSpeech = UserDefaults.standard.bool(forKey: "userWantsSpeech")

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(voiceOverStatusChanged),
            name: UIAccessibility.voiceOverStatusDidChangeNotification,
            object: nil
        )
    }

    // MARK: - VoiceOver Observer
    @objc private func voiceOverStatusChanged() {
        isVoiceOverRunning = UIAccessibility.isVoiceOverRunning
    }

    // MARK: - Text-to-Speech API
    /// Speak the given text if in-app speech is enabled and VoiceOver is off.
    func speak(_ text: String) {
        guard shouldSpeak, !synthesizer.isSpeaking else { return }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}

