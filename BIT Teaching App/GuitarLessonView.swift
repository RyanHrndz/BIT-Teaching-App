// GuitarLessonView.swift
// BIT Teaching App
//
// Created by Ryan Hernandez 
//

import SwiftUI

struct GuitarLessonView: View {
    @EnvironmentObject var accessibilityManager: AccessibilityManager

    // Consolidate your full lesson recap here, starting with the core concepts
    private var summaryText: String {
        """
        Core Concepts Summary:
        • Sound = vibration. No vibration = no sound.
        • Pitch depends on frequency. Higher frequency = higher pitch.
        • Amplitude affects loudness. More energy = stronger vibration.
        • Resonance makes sound easier to feel and hear.
        • Feeling different string tensions helps connect physics to music.

        Sound is created by vibration. Short or tight strings make high-pitched sounds. \
        Long or loose strings create lower pitches. The guitar board helps us feel sound \
        and pitch through string vibrations.

        Tactile Module Instructions:
        • Components:
          – 3D-Printed Guitar Plate
          – Resonant vibration zone
          – Orientation pegs in the bottom right

        Step-by-Step:
        1. Hold the board with pegs at the bottom-right to orient yourself.
        2. Feel across the surface to locate the strings.
        3. Gently pluck each string. Feel the difference in vibration.
        4. Compare: Shorter or tighter strings vibrate faster = higher pitch.
        5. Place fingers on the wide groove — feel the amplified resonance.
        6. Pluck strings multiple times and discuss how pitch and strength change.
        """
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("3D Printed Guitar – Sound, Vibration & Acoustics")
                    .font(.largeTitle)
                    .bold()
                    .accessibilityAddTraits(.isHeader)

                Text("""
                This lesson introduces the physics of sound waves and resonance. Students will feel \
                string vibrations and explore how frequency and pitch relate through tactile interaction.
                """)
                .font(.body)

                Group {
                    Text("Key Concepts")
                        .font(.title2).bold()
                    Text("• Vibration: Back-and-forth motion that creates sound.")
                    Text("• Frequency (Hz): Vibrations per second — higher frequency = higher pitch.")
                    Text("• Amplitude: Strength of vibration — greater amplitude = louder sound.")
                    Text("• Pitch: Perceived highness or lowness of sound.")
                    Text("• Resonance: When objects naturally amplify vibration.")
                    Text("• String Length & Tension: Shorter/tighter = faster vibration = higher pitch.")
                }

                Group {
                    Text("Equations & Examples")
                        .font(.title2).bold()
                    Text("• Wave Speed = Frequency × Wavelength")
                    Text("• Example 1: If frequency is 500 Hz and wavelength is 0.686 m → Speed = 343 m/s")
                    Text("• Example 2: Tighter string → higher pitch due to faster vibration.")
                }

                Group {
                    Text("Real-World Applications")
                        .font(.title2).bold()
                    Text("• Guitars, violins, and pianos rely on vibration and string length.")
                    Text("• Speakers vibrate to create sound waves.")
                    Text("• Buildings are engineered to enhance or absorb sound (acoustics).")
                    Text("• Voice tuning and hearing aids amplify vibration-based signals.")
                }

                Group {
                    Text("Tactile Module Instructions")
                        .font(.title2).bold()
                    Text("Components:")
                    Text("• 3D-Printed Guitar Plate")
                    Text("• Resonant vibration zone")
                    Text("• Orientation pegs in the bottom right")

                    Text("\nStep-by-Step:")
                    Text("1. Hold the board with pegs at the bottom-right to orient yourself.")
                    Text("2. Feel across the surface to locate the strings.")
                    Text("3. Gently pluck each string. Feel the difference in vibration.")
                    Text("4. Compare: Shorter or tighter strings vibrate faster = higher pitch.")
                    Text("5. Place fingers on the wide groove — feel the amplified resonance.")
                    Text("6. Pluck strings multiple times and discuss how pitch and strength change.")
                }

                Group {
                    Text("Core Concepts Summary")
                        .font(.title2).bold()
                    Text("• Sound = vibration. No vibration = no sound.")
                    Text("• Pitch depends on frequency. Higher frequency = higher pitch.")
                    Text("• Amplitude affects loudness. More energy = stronger vibration.")
                    Text("• Resonance makes sound easier to feel and hear.")
                    Text("• Feeling different string tensions helps connect physics to music.")
                }

                // Show the recap button only if voice feedback is enabled
                if accessibilityManager.userWantsSpeech {
                    Button("Speak Summary") {
                        accessibilityManager.speak(summaryText)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .accessibilityHint("Double-tap to hear a lesson summary.")
                }
            }
            .padding()
            // Magic-tap (two-finger double-tap) also triggers the recap when enabled
            .accessibilityAction(.magicTap) {
                if accessibilityManager.userWantsSpeech {
                    accessibilityManager.speak(summaryText)
                }
            }
            .onAppear {
                // Initial announcement only if user wants speech
                if accessibilityManager.userWantsSpeech {
                    accessibilityManager.speak(
                        "Guitar lesson. Learn how string vibration and tension produce pitch and timbre."
                    )
                }
            }
        }
        .navigationTitle("Guitar Lesson")
    }
}

struct GuitarLessonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GuitarLessonView()
                .environmentObject(AccessibilityManager.shared)
        }
        .preferredColorScheme(.light)
    }
}
