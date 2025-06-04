# BIT Teaching App

> An iOS application designed to teach physics and basic electronics concepts to blind or visually impaired students using interactive lessons, NFC-triggered content, and VoiceOver accessibility support.

---

## Table of Contents

1. [Overview](#overview)  
2. [Features](#features)  
3. [Requirements](#requirements)  
4. [Project Structure](#project-structure)  
5. [Getting Started](#getting-started)  
6. [How to Use](#how-to-use)  
7. [Adding New Lessons / Future Development](#adding-new-lessons--future-development)  
8. [Accessibility & VoiceOver](#accessibility--voiceover)  
9. [Testing](#testing)  
10. [Troubleshooting](#troubleshooting)  
11. [Contributing](#contributing)  
12. [License](#license)  

---

## Overview

The BIT Teaching App brings hands-on physics and electronics learning to blind or visually impaired students. Each lesson is tied to a physical object (e.g., a 3D-printed elevator model, a breadboard, a guitar) equipped with an NFC tag. When the student scans the tag, the app navigates to a lesson page that presents audio-guided instructions, interactive quizzes, and tactile diagrams that leverage VoiceOver.

Key goals:

- Provide **audio-first** lesson content that is fully navigable via VoiceOver.
- Allow quick transitions from NFC tag scanning to the corresponding lesson.
- Offer multiple lesson modules (Breadboard, Elevator, Guitar, Speed Ball, Wave Board, Physics) in one unified app.
- Enable administrators (educators) to modify lesson prompts and shapes in one place (`PromptDict` and `ShapesDict`).

---

## Features

- **NFC-Triggered Navigation**  
  - Scan an NFC tag on a compatible physical object to jump to the correct lesson view automatically.
- **Multiple Lesson Modules**  
  - Breadboard electronics  
  - Elevator mechanics  
  - Guitar acoustics (sound waves)  
  - Speed Ball motion demonstration  
  - Wave board wave types  
  - General Physics introductions  
- **Interactive Quizzes**  
  - `QuizView` provides short question-and-answer checks at the end of each lesson.
- **Accessibility Manager**  
  - Detects whether VoiceOver is enabled and dynamically adjusts content delivery.
- **Global Settings Screen**  
  - Toggle “Read Content Aloud” if VoiceOver is not already running.
- **Bluetooth LE (BLE) Support (BLEManager)**  
  - Placeholder for future BLE sensor integrations (e.g., Speed Ball data collection).
- **Modular Code Organization**  
  - Each lesson has its own SwiftUI view and logic file.
- **Preview Content**  
  - SwiftUI preview providers to help developers see changes in Xcode without running on a device.

---

## Requirements

- **Xcode Version:**  
  Xcode 14.0 or higher (Swift 5.7+)

- **iOS Deployment Target:**  
  iOS 14.0 or higher (NFC scanning requires iOS 13+, but advanced NFC features work best on iOS 14+)

- **Device:**  
  iPhone or iPad with NFC support (iPhone 7 or later)

- **Swift Packages / Dependencies:**  
  No external dependencies. All code is pure Swift/SwiftUI.

---

## Project Structure

BIT Teaching App/
├─ BIT Teaching App.xcodeproj # Xcode project file
├─ BIT Teaching App/
│ ├─ Preview Content/ # SwiftUI preview assets
│ │ └─ PreviewAssets.swift # Sample data for previews
│ ├─ Assets.xcassets/ # App icons, color sets, etc.
│ ├─ AccessibilityManager.swift # Detect VoiceOver, manage TTS fallback
│ ├─ BIT_Teaching_AppApp.swift # @main App entry point
│ ├─ BLEManager.swift # Placeholder BLE logic for future sensor data
│ ├─ BreadboardLessonView.swift # SwiftUI lesson screen for breadboard
│ ├─ BreadboardView.swift # Static breadboard diagram / tactile info
│ ├─ ContentView.swift # Initial launch view (e.g., HomeView wrapper)
│ ├─ ElevatorLessonView.swift # Lesson screen for elevator demo
│ ├─ ElevatorView.swift # Static elevator diagram / tactile info
│ ├─ GuitarLessonView.swift # Lesson screen for guitar demo (sound waves)
│ ├─ GuitarView.swift # Static guitar diagram / tactile info
│ ├─ HomeView.swift # Main menu / home interface
│ ├─ LessonManager.swift # Central logic for loading lesson data (prompts, shapes)
│ ├─ LessonPageView.swift # UI container for lesson content + quiz button
│ ├─ LessonView.swift # Generic lesson UI components (text, images, TTS)
│ ├─ NFCDestination.swift # Enum mapping NFC tag IDs to lessons
│ ├─ NFCScannerView.swift # UI & logic to scan an NFC tag and navigate
│ ├─ NFCSessionDelegate.swift # iOS CoreNFC delegate to handle tag callbacks
│ ├─ PhysicsView.swift # General physics lesson (force, energy, etc.)
│ ├─ PromptDict.swift # Dictionary of spoken prompts keyed by lesson ID
│ ├─ QuizView.swift # Quiz UI to validate student understanding
│ ├─ SettingsView.swift # Toggle “Read Aloud” and other accessibility toggles
│ ├─ ShapesDict.swift # Data structure for tactile shape metadata
│ ├─ SpeedBallLessonView.swift # Lesson screen for Speed Ball demo
│ ├─ SpeedBallView.swift # Static Speed Ball diagram / tactile info
│ ├─ WaveBoardLessonView.swift # Lesson screen for Wave Board demo
│ └─ WaveBoardView.swift # Static Wave Board diagram / tactile info
├─ BIT Teaching AppTests/ # Unit test targets
│ └─ BIT_Teaching_AppTests.swift
├─ BIT Teaching AppUITests/ # UI test targets
│ └─ BIT_Teaching_AppUITests.swift
└─ README.md # ← You are here!

**Key Files & Folders**  
- **`AccessibilityManager.swift`**  
  Detects whether VoiceOver is currently enabled. If VoiceOver is off but “Read Content Aloud” is turned on in Settings, the manager triggers text-to-speech.  
- **`BLEManager.swift`**  
  Stub for any BLE integrations (e.g., collecting real-time sensor data from an Arduino Nano or Speed Ball).  
- **Lesson Views (`*LessonView.swift` and `*View.swift`)**  
  - Each lesson has two files:  
    - `XyzLessonView.swift` (lesson logic + text prompts + navigation)  
    - `XyzView.swift` (static visual/tactile diagram or description)  
- **`NFCScannerView.swift` & `NFCSessionDelegate.swift`**  
  - Handle NFC scanning.  
  - Map scanned tag’s identifier to an `NFCDestination` enum.  
  - Navigate to the corresponding `LessonPageView`.  
- **`PromptDict.swift` & `ShapesDict.swift`**  
  - Centralized dictionaries: `PromptDict` holds all spoken-text content keyed by lesson ID.  
  - `ShapesDict` holds metadata for tactile shapes or accessibility descriptions.  
- **`LessonManager.swift` & `LessonPageView.swift`**  
  - `LessonManager` coordinates fetching prompt text, tracking progress, and supplying quiz questions.  
  - `LessonPageView` is a container that displays lesson content and offers a “Go to Quiz” button.  
- **`SettingsView.swift`**  
  - Toggle whether lessons should be read aloud even if VoiceOver is off.  
  - Persist settings in `UserDefaults`.  
- **`QuizView.swift`**  
  - A multiple-choice or true/false interface that tests learners after each lesson.  
- **Tests**  
  - `BIT Teaching AppTests` contains unit tests for `LessonManager` logic, `PromptDict`, and any non-UI code.  
  - `BIT Teaching AppUITests` simulates user flows (scanning an NFC tag, navigating to a lesson, tapping through settings).  

---

## Getting Started
How to Use
Home Screen (HomeView)

Displays a menu of all installed lessons (Breadboard, Elevator, Guitar, Speed Ball, Wave Board, Physics).

A “Settings” button in the top-right corner leads to SettingsView.

Settings (SettingsView)

Toggle “Read Content Aloud”:

If turned on and VoiceOver is off, each lesson’s text will be spoken via TTS.

If turned off and VoiceOver is off, text is presented visually only.

VoiceOver users will automatically hear all content, regardless of this toggle.

NFC Scanning (NFCScannerView)

Tap “Scan NFC Tag” from the Home screen (or hold the top of your device near an NFC tag).

When the tag is recognized, the app automatically navigates to the correct lesson.

Under the hood, NFCSessionDelegate reads the tag’s identifier, maps it via NFCDestination enum, and calls a navigation action.

Lesson Page (LessonPageView)

Displays the lesson title, a tactile description (via XyzView.swift), and step-by-step prompts (pulled from PromptDict).

At the bottom, a button “Take the Quiz” launches QuizView.

Quiz (QuizView)

Presents 3–5 questions (stored in LessonManager) that reinforce key lesson concepts.

Provides immediate feedback (“Correct” / “Try Again”).

Upon completion, the user can return to Home or re-review the lesson.

Adding New Lessons / Future Development
As you expand the BIT Teaching App, follow these guidelines to integrate a brand-new lesson module:

Create NFC Tag & Identifier

Physically assign an NFC tag to the new object.

Record its unique identifier (UID).

In NFCDestination.swift, add a new enum case, e.g., case newLessonID = "04A224B3C41280".

Add Prompt Content

In PromptDict.swift, add a new key under the prompts dictionary:

swift
Copy
Edit
static let prompts: [NFCDestination: [String]] = [
  // … existing lessons ...
  .newLessonID: [
    "Welcome to the New Lesson. In this lesson, you will learn about …",
    "Step 1: Place your hands on the object. Notice the shape and texture…",
    "Step 2: We will demonstrate how force and motion work by…",
    // Add as many steps as needed
  ]
]
Each string in the array represents a sequential “screen” or bullet-point that either VoiceOver will read or that appears in a visually formatted Text block.

Define Tactile Shapes / Descriptions

In ShapesDict.swift, add the description or metadata for the new lesson’s tactile diagram:

swift
Copy
Edit
static let shapes: [NFCDestination: String] = [
  // … existing lessons ...
  .newLessonID: "A triangular block with a ramp on one side, 4″ tall and 6″ long. Braille labels indicate force direction."
]
Create SwiftUI Views

NewLessonView.swift: Build a SwiftUI view to present any static images, simple shapes, or diagrams. For accessibility, include accessibilityLabel or custom VoiceOver hints.

NewLessonLessonView.swift: Create a companion that wraps LessonView with lesson-specific logic. Example:

swift
Copy
Edit
struct NewLessonLessonView: View {
  @ObservedObject var manager = LessonManager(destination: .newLessonID)
  
  var body: some View {
    LessonPageView(
      title: "New Lesson Title",
      contentView: AnyView(NewLessonView()),
      prompts: manager.prompts,
      onQuizTap: { manager.showQuiz = true }
    )
    .sheet(isPresented: $manager.showQuiz) {
      QuizView(questions: manager.quizQuestions)
    }
  }
}
Make sure to add NewLessonLessonView to your app’s navigation (or let NFCScannerView index it via the new NFCDestination).

Add Quiz Questions

In LessonManager.swift, detect the new NFCDestination.newLessonID case and supply an array of Question structs for quizQuestions. E.g.:

swift
Copy
Edit
switch destination {
  case .newLessonID:
    return [
      Question(text: "What is the primary concept illustrated by the new lesson?", choices: ["Option A", "Option B", "Option C"], correctIndex: 0),
      // … more questions …
    ]
}
Adjust the scoring or feedback logic if needed.

Update HomeView or Navigation Logic

If you display a manual list of lessons in HomeView, add a new NavigationLink for “New Lesson.” Otherwise, rely entirely on NFC navigation.

Test With Physical NFC Tag

Build and run on a device, then tap the NFC tag to ensure it navigates to NewLessonLessonView.

Verify VoiceOver reads your prompts in order and that the tactile diagrams have appropriate labels.

Document in README

Add a brief note under Future Development about registering new NFC UIDs and lesson files.

Accessibility & VoiceOver
VoiceOver Integration

All lesson text is stored in PromptDict. When VoiceOver is enabled, the system reads each Text view natively.

If VoiceOver is off but “Read Content Aloud” is toggled on (in Settings), the AccessibilityManager triggers AVSpeechSynthesizer to read each prompt automatically.

Tactile Diagrams

In your XyzView.swift files (e.g., BreadboardView.swift), include both:

A concise but descriptive accessibilityLabel on every Image or shape.

Clear instructions in prompts that guide the student’s hands to feel particular features (e.g., “Place your fingertips on the breadboard’s red bus line…”).

SettingsView

Persist the user’s preference in UserDefaults.standard.set(isReadAloudEnabled, forKey: "ReadAloud").

AccessibilityManager reads from that key to decide whether to fire AVSpeechSynthesizer if VoiceOver is off.

Best Practices

Always test with VoiceOver on a real device—listen for any unlabeled or confusing UI elements.

Use accessibilityHidden(true) on purely decorative images.

Add accessibilityHint when a UI element’s purpose might not be obvious (e.g., “Swipe left or right to access the next section”).

Testing
Unit Tests (BIT Teaching AppTests)

Verify that PromptDict.prompts[NFCDestination.breadboardID] exists and has at least 3 steps.

Confirm ShapesDict.shapes returns a non-empty string for each lesson.

Validate LessonManager produces the correct quizQuestions array for each NFCDestination.

UI Tests (BIT Teaching AppUITests)

Simulate scanning (Xcode’s “Simulate NFC Tag” menu action) to ensure the app opens the correct view.

Navigate through SettingsView, toggle “Read Content Aloud,” and assert UserDefaults changes.

Launch a lesson, tap “Take the Quiz,” answer questions, and confirm success/failure flows.

To run all tests:

In Xcode’s Product menu, choose Test (⌘U).

Verify that both Unit Tests and UI Tests pass.

Troubleshooting
“NFC Not Supported” or “Cannot Detect Tag”

Make sure you’re running on a real device with NFC (iPhone 7 or later).

Under your project target’s Signing & Capabilities, ensure the “Near Field Communication Tag Reading” capability is present.

If building to a physical device for the first time, unplug and replug your iPhone so Xcode can reindex capabilities.

VoiceOver Reads Incorrect Order

Check that each Text view is placed in the correct SwiftUI stack.

Verify you’re not accidentally calling accessibilitySortPriority(_) out of sequence.

Audio Overlaps / Double Reading

If VoiceOver is on, do not trigger AVSpeechSynthesizer. The AccessibilityManager should detect .isVoiceOverRunning and skip its TTS.

If audio overlaps, pause any active AVSpeechSynthesizer sessions before starting a new prompt.

Lesson Content Not Updating

Clean Derived Data (Xcode → Preferences → Locations → Derived Data → Delete) and rebuild.

Confirm that you updated the correct NFCDestination enum case and matching key in PromptDict.

Contributing
Thank you for your interest in improving the BIT Teaching App! To contribute:

Fork this repository.

Create a new branch for your feature or bugfix:

bash
Copy
Edit
git checkout -b feature/add-new-lesson
Make your changes, ensuring new code follows the existing Swift/SwiftUI style:

Use camelCase for variable names.

Add doc comments (///) for any new public methods.

Keep functions shorter than 50 lines if possible.

Add unit tests for any new business logic.

Run ⌘U in Xcode to ensure all tests (and UI tests) pass.

Commit your changes, push to your fork, and open a Pull Request.

In your PR description, reference any relevant issue and explain your changes in detail.



### 1. Clone the Repository

```bash
git clone https://github.com/YourUsername/BIT-Teaching-App.git
cd BIT-Teaching-App
