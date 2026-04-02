//
//  LessonManager.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 4/17/25.
//

import Foundation
import AVFoundation
import UIKit

// MARK: - Data Models

struct LessonStep {
    let text: String
    let speak: Bool
}

struct LessonPlan {
    let title: String
    let steps: [LessonStep]
}

// MARK: - Lesson Manager

class LessonManager: ObservableObject {
    static let shared = LessonManager()

    @Published var currentLesson: LessonPlan?
    @Published var currentStepIndex: Int = 0

    private let synthesizer = AVSpeechSynthesizer()

    // MARK: - Lessons Bank
    private let lessons: [String: LessonPlan] = [

        // 🔵 Speed Ball
        "speedball001": LessonPlan(
            title: "Speed Ball Demo",
            steps: [
                LessonStep(text: "Welcome to the Speed Ball lesson.", speak: true),
                LessonStep(text: "Place the ball in your hand. We'll explore how fast it moves.", speak: true),
                LessonStep(text: "Throw the ball forward gently. Sensors will track its motion.", speak: true),
                LessonStep(text: "Speed is how far something moves over time. Faster throws equal higher speed.", speak: true),
                LessonStep(text: "You just measured motion. That’s the first step in learning physics!", speak: true)
            ]
        ),

        // 🟣 Elevator
        "elevator002": LessonPlan(
            title: "Elevator Mechanics",
            steps: [
                LessonStep(text: "This is a model of an elevator. Feel the base and the moving platform.", speak: true),
                LessonStep(text: "When the elevator lifts, it works against gravity. That's a force.", speak: true),
                LessonStep(text: "Newton’s 2nd Law says force equals mass times acceleration.", speak: true),
                LessonStep(text: "Heavier elevators need more force to lift.", speak: true),
                LessonStep(text: "That’s how real elevators move people safely up and down.", speak: true)
            ]
        ),

        // 🔴 Breadboard
        "breadboard003": LessonPlan(
            title: "Electricity & Circuits",
            steps: [
                LessonStep(text: "This is a breadboard. It lets us build circuits without soldering.", speak: true),
                LessonStep(text: "Feel the wires and battery. Electricity flows from one side to the other.", speak: true),
                LessonStep(text: "When the circuit is closed, current flows and powers things like lights.", speak: true),
                LessonStep(text: "Opening the circuit stops the flow. That’s how switches work.", speak: true),
                LessonStep(text: "You just explored the basics of how electricity flows in devices!", speak: true)
            ]
        ),

        // 🌊 Wave Board
        "waveboard004": LessonPlan(
            title: "Types of Waves",
            steps: [
                LessonStep(text: "This board shows different kinds of waves. Move your fingers over the ridges.", speak: true),
                LessonStep(text: "Some waves move up and down. These are transverse waves, like light.", speak: true),
                LessonStep(text: "Others push forward and back. These are longitudinal waves, like sound.", speak: true),
                LessonStep(text: "Waves carry energy, not matter. The wave moves, but the board stays still.", speak: true),
                LessonStep(text: "Now you know the basic ways energy travels through space!", speak: true)
            ]
        ),

        // 🎸 Guitar
        "guitar005": LessonPlan(
            title: "Sound and Vibration",
            steps: [
                LessonStep(text: "This is a 3D printed guitar. Feel the strings and pluck one.", speak: true),
                LessonStep(text: "Vibrations travel through the air to your ears. That’s sound!", speak: true),
                LessonStep(text: "Shorter strings make higher-pitched sounds. Longer strings make lower sounds.", speak: true),
                LessonStep(text: "The speed of vibration is called frequency. Faster equals higher pitch.", speak: true),
                LessonStep(text: "You just explored how music and science come together!", speak: true)
            ]
        )
    ]

    // MARK: - Public Methods

    func loadLesson(by id: String) -> Bool {
        guard let lesson = lessons[id] else {
            currentLesson = nil
            currentStepIndex = 0
            return false
        }
        currentLesson = lesson
        currentStepIndex = 0
        speakCurrentStep()
        return true
    }

    func nextStep() {
        guard let lesson = currentLesson else { return }
        if currentStepIndex + 1 < lesson.steps.count {
            currentStepIndex += 1
            speakCurrentStep()
        }
    }

    func repeatStep() {
        speakCurrentStep()
    }

    func speakCurrentStep() {
        guard
            let lesson = currentLesson,
            lesson.steps.indices.contains(currentStepIndex)
        else { return }

        let step = lesson.steps[currentStepIndex]
        if step.speak && !UIAccessibility.isVoiceOverRunning {
            let utterance = AVSpeechUtterance(string: step.text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.speak(utterance)
        }
    }

    var currentStepText: String {
        guard
            let lesson = currentLesson,
            lesson.steps.indices.contains(currentStepIndex)
        else { return "No lesson loaded." }

        return lesson.steps[currentStepIndex].text
    }
}
