// SpeedBallLessonView.swift
// BIT Teaching App
//
// Created by Ryan Hernandez on 5/11/25.
//

import SwiftUI

struct SpeedBallLessonView: View {
    @EnvironmentObject var accessibilityManager: AccessibilityManager

    // Full recap, starting with your Core Concepts Summary
    private var summaryText: String {
        """
        Core Concepts Summary:
        • Acceleration measures how fast you change speed.
        • More force = more acceleration if mass stays constant.
        • Speed Ball helps demonstrate Newton’s Second Law in real time.
        • Tactile experience paired with audio feedback deepens understanding.

        Tactile Module Instructions:
        • Soft 3D-printed or foam-covered ball with embedded sensors.
        • Bluetooth connection to phone or app.
        • Audio feedback of speed & acceleration via app.

        Step-by-Step:
        1. Hold the Speed Ball. Feel its shape and any sensor hardware inside.
        2. Gently drop the ball and listen: "Velocity: 3 meters per second."
        3. Drop with more force and compare new velocity and acceleration.
        4. Roll the ball—feel smoother motion and reduced acceleration.
        5. Take turns dropping and comparing with a partner.
        6. Discuss who had more momentum and how mass and speed affect force.
        """
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Speed Ball – Motion & Acceleration")
                    .font(.largeTitle)
                    .bold()

                Text("""
                This lesson explores how objects move using a Speed Ball equipped with motion sensors. You’ll learn how velocity, acceleration, and distance relate to one another, and how force and motion are calculated using Newton’s Laws. Students can feel the motion through throwing and observe results through audio or app feedback.
                """)
                .font(.body)

                Group {
                    Text("Key Concepts")
                        .font(.title2).bold()
                    Text("• Velocity (v): Speed in a specific direction (e.g., 5 m/s forward).")
                    Text("• Acceleration (a): The rate of change of velocity.")
                    Text("• Distance (d): How far something travels.")
                    Text("• Time (t): Duration of motion.")
                    Text("• Newton’s Second Law: F = m × a (Force = Mass × Acceleration)")
                    Text("• Motion Sensors: Devices in the ball that measure acceleration & velocity.")
                }

                Group {
                    Text("Equations & Examples")
                        .font(.title2).bold()
                    Text("• Velocity = Distance ÷ Time (v = d / t)")
                    Text("• Acceleration = Change in Velocity ÷ Time (a = Δv / t)")
                    Text("• Newton’s 2nd Law: Force = Mass × Acceleration (F = m × a)")
                    Text("• Example: A 2 kg ball accelerates at 3 m/s² → F = 2 × 3 = 6 N")
                }

                Group {
                    Text("Real-World Applications")
                        .font(.title2).bold()
                    Text("• Sports: Athletes optimize velocity & acceleration.")
                    Text("• Car Design: Safety & performance rely on these calculations.")
                    Text("• NASA: Uses these laws to launch & navigate rockets.")
                    Text("• EdTech: Speed Ball tools visualize Newton's Laws in action.")
                }

                Group {
                    Text("Tactile Module Instructions")
                        .font(.title2).bold()
                    Text("• Soft 3D-printed or foam-covered ball with sensors.")
                    Text("• Bluetooth link to app.")
                    Text("• Audio feedback of speed & acceleration.")

                    Text("\nStep-by-Step Instructions:")
                    Text("1. Hold the ball; feel its shape and sensors.")
                    Text("2. Drop it; listen: 'Velocity: 3 meters per second.'")
                    Text("3. Drop harder; notice increased velocity/acceleration.")
                    Text("4. Roll it; feel smoother motion, less acceleration.")
                    Text("5. Compare drops with a partner.")
                    Text("6. Discuss momentum differences and force effects.")
                }

                Group {
                    Text("Core Concepts Summary")
                        .font(.title2).bold()
                    Text("• Acceleration measures how fast you change speed.")
                    Text("• More force = more acceleration if mass stays constant.")
                    Text("• Speed Ball helps demonstrate Newton’s Second Law in real time.")
                    Text("• Tactile experience paired with audio feedback deepens understanding.")
                }

                // Only show the recap button if voice feedback is enabled
                if accessibilityManager.userWantsSpeech {
                    Button("Speak Summary") {
                        accessibilityManager.speak(summaryText)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
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
                // Initial announcement only if voice feedback is on
                if accessibilityManager.userWantsSpeech {
                    accessibilityManager.speak(
                        "Speed Ball lesson. Motion and acceleration using a tactile Speed Ball."
                    )
                }
            }
        }
        .navigationTitle("Speed Ball Lesson")
    }
}

struct SpeedBallLessonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SpeedBallLessonView()
                .environmentObject(AccessibilityManager.shared)
        }
        .preferredColorScheme(.light)
    }
}
