// PhysicsView.swift
// BIT Teaching App

import SwiftUI

struct PhysicsView: View {
    @EnvironmentObject var accessibilityManager: AccessibilityManager

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Physics Lessons")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                Text( "Choose a topic to begin." +
                      " Each Lesson has Key Concepts, Equations and Examples, Real World Applications, Tactile Module Instructions, and a Core Concept Summary")
                    .font(.title3)
                    .foregroundColor(.gray)

                Divider().padding(.vertical)

                // Each lesson linked here
                NavigationLink(destination: SpeedBallLessonView()) {
                    lessonTile(
                        title: "Speed Ball",
                        description: "Learn motion, speed, and acceleration.",
                        color: .blue
                    )
                }

                NavigationLink(destination: ElevatorLessonView()) {
                    lessonTile(
                        title: "Elevator",
                        description: "Explore force, mass, and motion.",
                        color: .purple
                    )
                }

                NavigationLink(destination: BreadboardLessonView()) {
                    lessonTile(
                        title: "Breadboard",
                        description: "Understand electricity and circuits.",
                        color: .red
                    )
                }

                NavigationLink(destination: WaveBoardLessonView()) {
                    lessonTile(
                        title: "Wave Board",
                        description: "Explore light, sound, and wave types.",
                        color: .teal
                    )
                }

                NavigationLink(destination: GuitarLessonView()) {
                    lessonTile(
                        title: "Guitar",
                        description: "Learn sound and pitch through vibrations.",
                        color: .gray
                    )
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Physics Lessons")
        .onAppear {
            accessibilityManager.speak(
                "Physics Lessons. Choose a topic to begin.Each Lesson has Key Concepts, Equations and Examples, Real World Applications, Tactile Module Instructions, and a Core Concept Summary "
            )
        }
    }

    func lessonTile(title: String, description: String, color: Color) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.black)

            Text(description)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.3))
        .cornerRadius(15)
        .shadow(radius: 5)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
        .accessibilityHint(description)
    }
}

struct PhysicsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PhysicsView()
                .environmentObject(AccessibilityManager.shared)
        }
        .preferredColorScheme(.light)
    }
}
