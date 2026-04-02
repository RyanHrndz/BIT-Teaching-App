// NFCDestination.swift
// BIT Teaching App

import SwiftUI

enum NFCDestination: Hashable {
    // only your NFC-based lessons live here now
    case speedBall
    case elevator
    case breadboard
    case waveboard
    case guitar

    @ViewBuilder
    var view: some View {
        switch self {
        case .speedBall:    SpeedBallLessonView()
        case .elevator:     ElevatorLessonView()
        case .breadboard:   BreadboardLessonView()
        case .waveboard:    WaveBoardLessonView()
        case .guitar:       GuitarLessonView()
        }
    }
}
