//
//  LessonView.swift
//  BIT Teaching App
//
import SwiftUI
import AVFoundation

struct LessonView: View {
    @ObservedObject var lessonManager = LessonManager.shared
    @EnvironmentObject var accessibilityManager: AccessibilityManager
    @State private var path: [Int] = []
    let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 30) {
                if let lesson = lessonManager.currentLesson {
                    Text("Start Lesson")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityLabel("Start Lesson: \(lesson.title)")

                    Text("This lesson has \(lesson.steps.count) steps.")
                        .font(.title2)
                        .padding()
                        .accessibilityHint("Tap below to begin.")

                    Button("Begin") {
                        path.append(0) // start at step 0
                    }
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .accessibilityLabel("Begin lesson")
                    .accessibilityHint("Tap to start from the first step")
                } else {
                    Text("No lesson loaded.")
                        .font(.title2)
                        .foregroundColor(.red)
                        .padding()
                        .accessibilityLabel("No lesson loaded")
                }

                Spacer()
            }
            .padding()
            .navigationDestination(for: Int.self) { stepIndex in
                if let lesson = lessonManager.currentLesson {
                    LessonPageView(
                        title: lesson.title,
                        stepText: lesson.steps[stepIndex].text,
                        stepIndex: stepIndex,
                        totalSteps: lesson.steps.count,
                        onNext: {
                            let nextIndex = stepIndex + 1
                            if nextIndex < lesson.steps.count {
                                path.append(nextIndex)
                            }
                        },
                        onRepeat: {
                            path.removeLast()
                            path.append(stepIndex)
                        }
                    )
                }
            }
        }
    }

    func speak(_ text: String) {
        if accessibilityManager.shouldSpeak {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.speak(utterance)
        }
    }
}
