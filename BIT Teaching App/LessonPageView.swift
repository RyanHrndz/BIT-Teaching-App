//
//  LessonPageView.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 4/17/25.
//

import SwiftUI
import AVFoundation

struct LessonPageView: View {
    let title: String
    let stepText: String
    let stepIndex: Int
    let totalSteps: Int
    let onNext: () -> Void
    let onRepeat: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text(title)
                .font(.title)
                .bold()
                .accessibilityAddTraits(.isHeader)

            Text(stepText)
                .font(.title2)
                .padding()
                .multilineTextAlignment(.center)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .accessibilityLabel("Step \(stepIndex + 1) of \(totalSteps)")
                .accessibilityValue(stepText)

            HStack(spacing: 30) {
                Button("Repeat") {
                    onRepeat()
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .accessibilityLabel("Repeat step")

                if stepIndex < totalSteps - 1 {
                    Button("Next") {
                        onNext()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .accessibilityLabel("Next step")
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            if !UIAccessibility.isVoiceOverRunning {
                let utterance = AVSpeechUtterance(string: stepText)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                AVSpeechSynthesizer().speak(utterance)
            }
        }
    }
}
