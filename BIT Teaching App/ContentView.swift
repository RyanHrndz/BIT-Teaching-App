//
//  ContentView.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("BIT Teaching App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityLabel("BIT Teaching App Main Screen")

                NavigationLink(destination: NFCScannerView()) {
                    Text("Go to NFC Scanner")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 60)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .accessibilityLabel("Go to NFC Scanner")
                        .accessibilityHint("Tap to scan a tag and begin a math or physics lesson")
                        .accessibilityAddTraits(.isButton)
                }
            }
            .padding()
            .accessibilityRespondsToUserInteraction(true)
        }
    }
}

#Preview {
    ContentView()
} 
