// WaveBoardLessonView.swift
// BIT Teaching App
//
// Created by Ryan Hernandez on 5/11/25.
//

import SwiftUI

struct WaveBoardLessonView: View {
    @EnvironmentObject var accessibilityManager: AccessibilityManager

    // Full recap, starting with Core Concepts Summary
    private var summaryText: String {
        """
        Core Concepts Summary:
        • Transverse waves move up and down (like light).
        • Longitudinal waves move forward and back (like sound).
        • Photons are packets of electromagnetic energy.
        • Amplitude is wave height; frequency is cycles per second.
        • EM spectrum runs from radio waves to gamma rays.

        Real-World Applications:
        • Sound waves (longitudinal) carry audio through air.
        • Light waves (transverse) span 400–700 nm in the visible band.
        • Radio broadcasts use long wavelengths.
        • Microwaves heat food; X-rays image tissue; gamma rays treat cancer.

        Tactile Module Instructions:
        1. Hold board so the two cut corners are on top.
        2. Feel each of the seven horizontal rows:
           – Radio: straight line (lowest energy).
           – Microwave: slight curve.
           – Infrared: curved line with dotted grooves.
           – Visible Light: dots spaced from wide (red) to tight (violet).
           – Ultraviolet: line with circular bumps.
           – X-ray: jagged edges.
           – Gamma: rigid, sharp spikes (highest energy).
        3. Notice textures change as energy increases and wavelength shortens.
        """
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Wave Board – Electromagnetic Radiation")
                    .font(.largeTitle)
                    .bold()
                    .accessibilityAddTraits(.isHeader)

                Text("""
                This lesson explains how the Wave Board represents different electromagnetic waves using tactile textures. You'll explore wave types, particle behavior, and the full electromagnetic spectrum.
                """)
                .font(.body)

                Group {
                    Text("Key Concepts")
                        .font(.title2).bold()
                    Text("• Transverse Wave: Moves up and down.")
                    Text("• Longitudinal Wave: Moves forward and back.")
                    Text("• Photon: A packet of electromagnetic energy.")
                    Text("• Amplitude: Wave height — more energy = higher amplitude.")
                    Text("• Wavelength (λ): Distance between peaks.")
                    Text("• Frequency (f): Cycles per second.")
                    Text("• EM Spectrum: Radio → gamma rays.")
                }

                Group {
                    Text("Equations & Examples")
                        .font(.title2).bold()
                    Text("• v = f × λ")
                    Text("• E = h × f")
                    Text("• f = c / λ")
                    Text("• Example: λ = 450 nm → E ≈ 4.4 × 10⁻¹⁹ J")
                }

                Group {
                    Text("Real-World Applications")
                        .font(.title2).bold()
                    Text("• Sound: Longitudinal waves carry speech/music.")
                    Text("• Visible Light: Transverse waves we see (400–700 nm).")
                    Text("• Radio: Music broadcast on long wavelengths.")
                    Text("• Microwaves: Used in cooking.")
                    Text("• X-rays & Gamma: Medical imaging & treatment.")
                }

                Group {
                    Text("Tactile Module Instructions")
                        .font(.title2).bold()
                    Text("• Hold the board so the two cut corners are on top.")
                    Text("• There are seven rows, bottom to top:")
                    Text("   1. Radio – straight line.")
                    Text("   2. Microwave – slight curve.")
                    Text("   3. Infrared – curved with dotted grooves.")
                    Text("   4. Visible Light – dots spaced Red→Violet.")
                    Text("   5. Ultraviolet – circular bumps.")
                    Text("   6. X-ray – jagged edges.")
                    Text("   7. Gamma – sharp spikes.")
                    Text("• Energy increases & wavelength shortens as you move up.")
                }

                Group {
                    Text("Core Concepts Summary")
                        .font(.title2).bold()
                    Text("• Transverse waves move up/down; longitudinal front/back.")
                    Text("• Photons are particle-like wave packets.")
                    Text("• Amplitude = height; frequency = cycles/sec.")
                    Text("• EM spectrum from radio (low E) to gamma (high E).")
                }

                // Speak Summary button, shown only if voice feedback is enabled
                if accessibilityManager.userWantsSpeech {
                    Button("Speak Summary") {
                        accessibilityManager.speak(summaryText)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .accessibilityHint("Double-tap to hear the full lesson summary.")
                }
            }
            .padding()
            // Magic-tap (two-finger double-tap) triggers the same recap
            .accessibilityAction(.magicTap) {
                if accessibilityManager.userWantsSpeech {
                    accessibilityManager.speak(summaryText)
                }
            }
            .onAppear {
                // Initial announcement only if user wants speech
                if accessibilityManager.userWantsSpeech {
                    accessibilityManager.speak(
                        "Wave Board lesson. Explore the electromagnetic spectrum through tactile textures."
                    )
                }
            }
        }
        .navigationTitle("Wave Board Lesson")
    }
}

struct WaveBoardLessonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WaveBoardLessonView()
                .environmentObject(AccessibilityManager.shared)
        }
        .preferredColorScheme(.light)
    }
}
