//
//  GuitarView.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 3/3/25.
//

import SwiftUI

struct GuitarView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("3D Printed Guitar - Sound Waves & Vibrations")
                .font(.largeTitle)
                .bold()
                .padding()
                .accessibilityLabel("3D Printed Guitar. Sound Waves and Vibrations.")
                .accessibilityAddTraits(.isHeader)

            Text("By plucking the strings, students can feel and hear how sound waves vibrate to create music.")
                .padding()
                .accessibilityLabel("Students can feel and hear how sound waves vibrate.")
                .accessibilityHint("Try plucking the strings to explore pitch and vibration through touch.")
        }
        .padding()
        .accessibilityElement(children: .combine)
    }
}
