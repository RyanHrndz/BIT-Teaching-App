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

### 1. Clone the Repository

```bash
git clone https://github.com/YourUsername/BIT-Teaching-App.git
cd BIT-Teaching-App
