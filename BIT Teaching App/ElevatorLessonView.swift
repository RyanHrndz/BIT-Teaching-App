// ElevatorLessonView.swift
// BIT Teaching App
//
// Created by Ryan Hernandez 
//

import SwiftUI

struct ElevatorLessonView: View {
    @EnvironmentObject var accessibilityManager: AccessibilityManager

    // Consolidated lesson recap with Core Concepts Summary first
    private var summaryText: String {
        """
        Core Concepts Summary:
        • Newton’s Third Law: For every action, there is an equal and opposite reaction.
        • Force: A push or pull between objects that interact.
        • Momentum: Mass times velocity; heavier or faster objects have more momentum.
        • Force Pairs: Two connected forces acting in opposite directions, such as crank and elevator.
        • Conservation of Momentum: Momentum is transferred and conserved during stops or collisions.
        • No net force means the object stays at rest unless acted upon by an external force.

        Tactile Module Instructions:
        • Crankshaft Handle: On the elevator frame — rotate it to move the elevator up/down.
        • Elevator Compartment: Holds weights and moves vertically.
        • Weight/Load: Add to the compartment to increase mass.
        • Pulley System: Connects the crank to the elevator.

        Step-by-Step Instructions:
        1. Start empty, turn the crank. Feel the resistance.
        2. Add weight and crank again. Feel the change in force.
        3. Try stopping it — it's harder with more mass.
        4. Notice the jerk you feel when it stops; that's conservation of momentum.
        """
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Elevator – Force Pairs & Momentum")
                    .font(.largeTitle)
                    .bold()

                Text("""
                This lesson explains how elevators use force to lift people and objects. We’ll explore Newton’s Laws and how mass affects movement and momentum.
                """)
                .font(.body)

                Group {
                    Text("Key Concepts")
                        .font(.title2).bold()
                    Text("• Newton’s Third Law: For every action, there is an equal and opposite reaction.")
                    Text("• Force: A push or pull between objects that interact.")
                    Text("• Momentum: Mass times velocity; heavier or faster objects have more momentum.")
                    Text("• Force Pairs: Two connected forces acting in opposite directions, such as crank and elevator.")
                    Text("• Conservation of Momentum: Momentum is transferred and conserved during stops or collisions.")
                    Text("• No net force means the object stays at rest unless acted upon by an external force.")
                }

                Group {
                    Text("Equations & Examples")
                        .font(.title2).bold()
                    Text("• Momentum = Mass × Velocity")
                    Text("• Example 1: You push the crank with 10 N. It pushes back with 10 N — Newton’s Third Law.")
                    Text("• Example 2: An apple weighing 10 kg moving at 10 m/s has 100 kg·m/s of momentum.")
                }

                Group {
                    Text("Real-World Applications")
                        .font(.title2).bold()
                    Text("• Elevators lifting heavy loads.")
                    Text("• Construction cranes moving materials.")
                    Text("• Motor design in elevators to handle force safely.")
                    Text("• A bat hitting a baseball.")
                }

                Group {
                    Text("Tactile Module Instructions")
                        .font(.title2).bold()
                    Text("Components:")
                    Text("• Crankshaft Handle: On the elevator frame — rotate it to move the elevator up/down.")
                    Text("• Elevator Compartment: Holds weights and moves vertically.")
                    Text("• Weight/Load: Add to the compartment to increase mass.")
                    Text("• Pulley System: Connects the crank to the elevator.")

                    Text("\nStep-by-Step Instructions:")
                    Text("1. Start empty, turn the crank. Feel the resistance.")
                    Text("2. Add weight and crank again. Feel the change in force.")
                    Text("3. Try stopping it — it's harder with more mass.")
                    Text("4. Notice the jerk you feel when it stops; that's conservation of momentum.")
                }

                // New Core Concepts Summary section for extra teaching material
                Group {
                    Text("Core Concepts Summary")
                        .font(.title2).bold()
                    Text("• Newton’s Third Law: For every action, there is an equal and opposite reaction.")
                    Text("• Force: A push or pull between objects that interact.")
                    Text("• Momentum: Mass times velocity; heavier or faster objects have more momentum.")
                    Text("• Force Pairs: Two connected forces acting in opposite directions, such as crank and elevator.")
                    Text("• Conservation of Momentum: Momentum is transferred and conserved during stops or collisions.")
                    Text("• No net force means the object stays at rest unless acted upon by an external force.")
                }

                // Only show the recap button if voice feedback is enabled
                if accessibilityManager.userWantsSpeech {
                    Button("Speak Summary") {
                        accessibilityManager.speak(summaryText)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
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
                        "Elevator lesson. Learn how force pairs, momentum, and mass control elevator motion."
                    )
                }
            }
        }
        .navigationTitle("Elevator Lesson")
    }
}

struct ElevatorLessonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ElevatorLessonView()
                .environmentObject(AccessibilityManager.shared)
        }
    }
}
