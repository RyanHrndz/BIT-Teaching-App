//
//  WaveBoardView.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 3/3/25.
//

import SwiftUI

struct WaveBoardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Wave Board - Wave Types & Feel")
                .font(.largeTitle)
                .bold()
                .padding()
                .accessibilityLabel("Wave Board. Wave types and touch-based learning.")
                .accessibilityAddTraits(.isHeader)

            Text("This 3D printed board allows students to feel the differences between transverse and longitudinal waves.")
                .padding()
                .accessibilityLabel("This board lets you feel wave types.")
                .accessibilityHint("Use your hands to explore transverse and longitudinal waves through touch.")
        }
        .padding()
        .accessibilityElement(children: .combine)
    }
}
