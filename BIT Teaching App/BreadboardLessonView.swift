// BreadboardLessonView.swift
// BIT Teaching App
//
// Created by Ryan Hernandez on 5/11/25.
//

import SwiftUI

struct BreadboardLessonView: View {
    @EnvironmentObject var accessibilityManager: AccessibilityManager

    // Consolidate your summary text here
    private var summaryText: String {
        """
        Electricity flows in closed loops. Breadboards help us explore and build circuits safely using voltage, current, and resistance.
        
        Step-by-Step Recap:
        1. Start by exploring the board with your hands. Feel the corners to orient the board.
        2. The button is in the bottom-right corner, the resistor is centered at the bottom, and the buzzer is near the top-right.
        3. Locate the resistor. Feel its size and wire ends — it resists how fast electricity moves.
        4. Press the button gently. It will click and complete the circuit.
        5. Hold the button — listen for the buzzer. This means the circuit is closed and electricity is flowing.
        6. Release the button — the buzzer stops. The circuit is now open.
        7. Repeat pressing the button and feel how your action controls the circuit.
        """
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Breadboard – Electricity & Circuits")
                    .font(.largeTitle)
                    .bold()

                Text("""
                This lesson explores how electricity flows through a circuit using a breadboard. You’ll discover the difference between open and closed circuits, feel the flow of energy, and learn to connect components safely.
                """)
                .font(.body)

                Group {
                    Text("Key Concepts")
                        .font(.title2).bold()
                    Text("• Circuit: A path for electricity to flow.")
                    Text("• Closed Circuit: A complete loop — electricity can move through.")
                    Text("• Open Circuit: The loop is broken — electricity stops flowing.")
                    Text("• Voltage (V): The force that pushes electric current through.")
                    Text("• Current (I): The rate at which electric charge flows.")
                    Text("• Resistance (R): A material’s opposition to flow.")
                    Text("• Ohm’s Law: Describes the relationship between voltage, current, and resistance.")
                    Text("• Battery: Provides voltage and starts the flow of current.")
                    Text("• Breadboard: A tool to build circuits without soldering.")
                }

                Group {
                    Text("Equations & Examples")
                        .font(.title2).bold()
                    Text("• Ohm’s Law: V = I × R")
                    Text("• Example 1: A circuit has 2 A of current and 5 Ω of resistance. V = 2 × 5 = 10 V")
                    Text("• Example 2: A battery provides 9 V and resistance is 3 Ω. I = 9 ÷ 3 = 3 A")
                }

                Group {
                    Text("Real-World Applications")
                        .font(.title2).bold()
                    Text("• Light switches: Complete or break a circuit to turn on/off a light.")
                    Text("• Phone chargers: Deliver controlled voltage through circuits.")
                    Text("• Computers: Use thousands of microscopic circuits to run programs.")
                    Text("• Medical Devices: Use circuits to monitor and deliver care (example: pacemakers).")
                }

                Group {
                    Text("Tactile Module Instructions")
                        .font(.title2).bold()
                    Text("Components:")
                    Text("• In front of you, you will feel a board with tactile components: a buzzer, resistor, battery pack with wires, and a switch/button.")

                    Text("\nStep-by-Step Instructions:")
                    Text("1. Start by exploring the board with your hands. Feel the corners to orient the board.")
                    Text("2. The button is in the bottom-right corner, the resistor is centered at the bottom, and the buzzer is near the top-right.")
                    Text("3. Locate the resistor. Feel its size and wire ends — it resists how fast electricity moves.")
                    Text("4. Press the button gently. It will click and complete the circuit.")
                    Text("5. Hold the button — listen for the buzzer. This means the circuit is closed and electricity is flowing.")
                    Text("6. Release the button — the buzzer stops. The circuit is now open.")
                    Text("7. Repeat pressing the button and feel how your action controls the circuit.")

                    Text("\nReflect:")
                    Text("Electricity cannot flow without a closed circuit. You controlled the entire system with just a button.")
                }

                Group {
                    Text("Core Concepts Summary")
                        .font(.title2).bold()
                    Text("• Current only flows in closed loops.")
                    Text("• Resistors slow down current to protect devices.")
                    Text("• Voltage is the push, current is the flow, and resistance is the friction.")
                }

                // ONLY show the recap button if voice feedback is enabled
                if accessibilityManager.userWantsSpeech {
                    Button("Speak Summary") {
                        accessibilityManager.speak(summaryText)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
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
                        "Breadboard lesson. Build and connect simple circuits using a breadboard."
                    )
                }
            }
        }
        .navigationTitle("Breadboard Lesson")
    }
}

struct BreadboardLessonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BreadboardLessonView()
                .environmentObject(AccessibilityManager.shared)
        }
        .preferredColorScheme(.light)
    }
}
