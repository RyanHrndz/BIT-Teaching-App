//
//  BreadboardView.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 3/3/25.
//

import SwiftUI

struct BreadboardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Breadboard - Electricity & Circuits")
                .font(.largeTitle)
                .bold()
                .padding()
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel("Breadboard. Electricity and Circuits.")

            Text("Students will learn about circuits by physically building one on the breadboard.")
                .padding()
                .accessibilityLabel("Students will learn about circuits by physically building one on the breadboard.")
                .accessibilityHint("This lesson is hands-on and ideal for blind or low vision students.")
        }
        .padding()
        .accessibilityElement(children: .combine)
    }
}
