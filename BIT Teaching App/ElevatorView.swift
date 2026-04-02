//
//  ElevatorView.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 3/3/25.
//

import SwiftUI

struct ElevatorView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("3D Printed Elevator - Forces & Mechanics")
                .font(.largeTitle)
                .bold()
                .padding()
                .accessibilityLabel("3D Printed Elevator. Forces and Mechanics.")
                .accessibilityAddTraits(.isHeader)

            Text("This tool demonstrates how forces work in an elevator system. Students can feel how weight changes as the elevator moves up and down.")
                .padding()
                .accessibilityLabel("This tool demonstrates how forces work in an elevator system.")
                .accessibilityHint("Students can feel how weight changes as the elevator moves up and down.")
        }
        .padding()
        .accessibilityElement(children: .combine)
    }
}

