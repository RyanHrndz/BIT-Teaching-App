// QuizView.swift
// BIT Teaching App

import SwiftUI
import CoreNFC

struct QuizView: View {
    // MARK: — Environment
    @EnvironmentObject var accessibilityManager: AccessibilityManager

    // MARK: — Data & State
    private let promptData = PromptData.shared
    @State private var initialDeck: [Int]    // full list of questions
    @State private var questionQueue: [Int]  // questions yet to be asked
    @State private var reviewQueue: [Int] = [] // questions answered incorrectly
    @State private var currentKey: Int?       // the key we’re showing
    
    @State private var hintCount    = 0
    @State private var showAnswer   = false
    @State private var correctCount = 0
    
    @AppStorage("QuizHighScore") private var highScore = 0
    private let haptic = UINotificationFeedbackGenerator()
    
    @State private var nfcSession: NFCNDEFReaderSession?
    @State private var nfcDelegate: NFCSessionDelegate?
    
    @State private var showingSummary = false

    init() {
        let sorted = Array(PromptData.shared.promptDictionary.keys).sorted()
        _initialDeck   = State(initialValue: sorted)
        _questionQueue = State(initialValue: sorted)
        _currentKey    = State(initialValue: sorted.first)
    }

    var body: some View {
        VStack(spacing: 16) {
            // — Progress & Score —
            Text(progressText)
                .font(.subheadline)
                .padding(.horizontal)

            Divider()

            // — Prompt & Hints —
            if let key = currentKey, let prompt = promptData.promptDictionary[key] {
                VStack(alignment: .leading, spacing: 8) {
                    Text(prompt.p1)
                        .font(.title2)
                        .onAppear {
                            accessibilityManager.speak(prompt.p1)
                        }

                    if hintCount >= 1, let p2 = prompt.p2 {
                        Text("💡 \(p2)").italic()
                    }
                    if hintCount >= 2, let p3 = prompt.p3 {
                        Text("💡 \(p3)").italic()
                    }
                }
                .padding(.horizontal)
                .onChange(of: hintCount) {
                    if hintCount == 1, let p2 = prompt.p2 {
                        accessibilityManager.speak(p2)
                    }
                    if hintCount == 2, let p3 = prompt.p3 {
                        accessibilityManager.speak(p3)
                    }
                }
            }

            Divider()

            // — Answer —
            if showAnswer, let key = currentKey {
                ScrollView {
                    Text(shapesDictionary[String(key)] ?? "No answer available.")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxHeight: 300)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                .onAppear {
                    let ans = shapesDictionary[String(key)] ?? ""
                    accessibilityManager.speak(ans)
                }
            }

            Spacer()

            // — Controls —
            HStack(spacing: 12) {
                Button {
                    beginScanning()
                } label: {
                    Text("🔍\nCheck Answer")
                        .multilineTextAlignment(.center)
                        .frame(width: 100, height: 60)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button {
                    hintCount = min(hintCount + 1, 2)
                } label: {
                    Text("💡\nHint")
                        .multilineTextAlignment(.center)
                        .frame(width: 100, height: 60)
                        .background(hintCount >= 2 ? Color.gray : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(hintCount >= 2)

                Button {
                    moveToNext()
                } label: {
                    Text("⏭️\nNext")
                        .multilineTextAlignment(.center)
                        .frame(width: 100, height: 60)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom)
        }
        .padding(.top)
        .navigationTitle("Shapes Quiz")
        .onChange(of: showAnswer) {
            if showAnswer {
                accessibilityManager.speak(currentAnswer)
            }
        }
        .alert("Quiz Complete!", isPresented: $showingSummary) {
            Button("Restart") { restartQuiz() }
        } message: {
            Text("You got \(correctCount) correct out of \(initialDeck.count).")
        }
    }

    // MARK: — Computed Properties

    private var progressText: String {
        let asked = initialDeck.count - questionQueue.count
        let total = initialDeck.count + reviewQueue.count
        return "Question \(asked + 1) of \(total)  |  Score: \(correctCount)"
    }

    private var currentAnswer: String {
        guard let key = currentKey else { return "" }
        return shapesDictionary[String(key)] ?? "No answer available."
    }

    // MARK: — Quiz Flow

    private func moveToNext() {
        if correctCount > highScore { highScore = correctCount }
        showAnswer = false
        hintCount  = 0

        if !questionQueue.isEmpty {
            currentKey = questionQueue.removeFirst()
        } else if !reviewQueue.isEmpty {
            questionQueue = reviewQueue
            reviewQueue.removeAll()
            currentKey = questionQueue.removeFirst()
        } else {
            showingSummary = true
        }
    }

    private func restartQuiz() {
        correctCount  = 0
        hintCount     = 0
        showAnswer    = false
        reviewQueue.removeAll()
        questionQueue = initialDeck
        currentKey    = questionQueue.first
    }

    // MARK: — NFC & Answer Evaluation

    private func beginScanning() {
        guard NFCNDEFReaderSession.readingAvailable,
              let key = currentKey else { return }

        let delegate = NFCSessionDelegate { _ in
            evaluateAnswer(for: key)
        }
        nfcDelegate = delegate

        let session = NFCNDEFReaderSession(
            delegate: delegate,
            queue: nil,
            invalidateAfterFirstRead: true
        )
        session.alertMessage = showAnswer
            ? "Answer already revealed."
            : "Scan a tag to check the answer."
        nfcSession = session
        session.begin()
    }

    private func evaluateAnswer(for key: Int) {
        guard let payload = nfcDelegate?.lastScannedTagPayload else { return }
        let isCorrect = (payload.lowercased() == String(key))
        showAnswer = true

        if isCorrect {
            correctCount += 1
            haptic.notificationOccurred(.success)
        } else {
            reviewQueue.append(key)
            haptic.notificationOccurred(.error)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizView()
                .environmentObject(AccessibilityManager.shared)
        }
        .preferredColorScheme(.dark)
    }
}
