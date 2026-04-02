//
//  PromptDict.swift
//  BIT Teaching App
//
//  Created by Ryan Hernandez on 3/3/25.
//

//  PromptDict.swift
//  BIT Teaching App

import Foundation

class PromptData {
    static let shared = PromptData()

    let promptDictionary: [Int: (p1: String, p2: String?, p3: String?)] = [
        1: (
            p1: "This quadrilateral has four right angles, and opposite sides are equal in length.",
            p2: "To find the area of this shape, you multiply its length by its width, where all angles are right angles.",
            p3: "Adding twice its length and twice its width gives you the perimeter of this shape, where all angles are right angles."
        ),
        2: (
            p1: "This shape is defined as the set of all points in a plane that are equidistant from a fixed point called the center.",
            p2: "The area of this shape can be calculated using the formula pi r squared, where 'r' represents the length of a certain line segment.",
            p3: "This shape's perimeter is also known as its circumference, and it's calculated using 2 pi r, where 'r' represents the distance from its center to any point on its edge."
        ),
        3: (
            p1: "This shape has three equal sides and three equal angles, each measuring 60 degrees.",
            p2: nil,
            p3: nil
        ),
        4: (
            p1: "This shape is often categorized into specific types based on its side lengths and angles.",
            p2: nil,
            p3: nil
        ),
        5: (
            p1: "This triangle has two equal sides and two equal angles opposite those sides.",
            p2: "To find the perimeter of this triangle, you add the lengths of its two equal sides and the length of the third side.",
            p3: nil
        ),
        6: (
            p1: "This triangle follows the Pythagorean Theorem, where the square of the hypotenuse is equal to the sum of the squares of the other two sides.",
            p2: "Unlike other triangles, this one contains one 90 degree angle.",
            p3: "The relationship of the lengths of the sides in this triangle is expressed by the equation, A squared, plus B squared, equals C squared, where C represents the hypotenuse."
        ),
        7: (
            p1: "This triangle has all three sides of different lengths and all three angles of different measures.",
            p2: nil,
            p3: nil
        ),
        8: (
            p1: "This quadrilateral has opposite sides that are both equal in length and parallel to each other, but not necessarily forming right angles.",
            p2: "In this shape, opposite angles are equal, but unlike rectangles, the angles are not necessarily right angles.",
            p3: "The area of this 4-sided shape can be calculated by multiplying its base length by the perpendicular height drawn from that base, because the side lengths may be slanted."
        ),
        9: (
            p1: "This 2-D shape has four segments, two of which are parallel, but are not necessarily of equal length.",
            p2: "This quadrilateral may have four distinct angles, but must have at least one pair of parallel lines.",
            p3: "The area of this shape is found by taking half the height and multiplying it by the sum of the lengths of its parallel sides."
        ),
        10: (
            p1: "These lines are coplanar and never intersect, no matter how far they are extended.",
            p2: nil,
            p3: nil
        ),
        11: (
            p1: "This type of angle measures exactly 90 degrees.",
            p2: "This type of angle is formed by perpendicular lines.",
            p3: nil
        ),
        12: (
            p1: "This type of angle measures less than 90 degrees.",
            p2: nil,
            p3: nil
        ),
        13: (
            p1: "This type of angle measures more than 90 degrees but less than 180 degrees.",
            p2: nil,
            p3: nil
        ),
        14: (
            p1: "This symbol is used when calculating the area and circumference of a circle.",
            p2: "This Greek letter is a mathematical constant with a value of approximately 3.14.",
            p3: nil
        ),
        15: (
            p1: "This symbol represents the character to denote an angle.",
            p2: nil,
            p3: nil
        ),
        16: (
            p1: "This symbol is used to represent degrees of an arc.",
            p2: nil,
            p3: nil
        ),
        17: (
            p1: "A three-dimensional shape that has six faces, eight vertices, and twelve edges.",
            p2: "To find the volume of this shape, you multiply the length, width, and height together.",
            p3: nil
        ),
        18: (
            p1: "This three-dimensional shape has a rectangular or square base and four triangular faces that meet at a common vertex.",
            p2: "To find the volume of this shape, you multiply the area of the square base by the height and divide by 3.",
            p3: "A three-dimensional shape with five faces, five vertices, and eight edges, with a rectangular or square base."
        ),
        19: (
            p1: "This three-dimensional shape has two congruent triangular bases and three rectangular faces.",
            p2: "To calculate the volume of this shape, you multiply the area of the triangular base by the height.",
            p3: "A three-dimensional shape with five faces, six vertices, and nine edges. There are two triangular bases and three rectangular sides."
        ),
        20: (
            p1: "This three-dimensional shape has two parallel circular bases connected by a curved surface.",
            p2: "To find the volume of this shape, you multiply the area of one of its circular bases by the height.",
            p3: "A three-dimensional shape with two flat faces, one curved surface, and two curved edges. This shape has no vertices."
        ),
        21: (
            p1: "To find the volume of this shape, you multiply the area of its circular base by one-third of its height.",
            p2: "A three-dimensional shape with one flat surface, one curved surface, one vertex, and one curved edge.",
            p3: nil
        ),
        22: (
            p1: "This three-dimensional shape is perfectly symmetrical and has all points on its surface equidistant from its center.",
            p2: "To find the volume of this shape, you multiply four-thirds of pi by the cube of its radius.",
            p3: nil
        )
    ]

    func getRandomPrompt() -> (key: Int, prompt: String) {
        let keys = Array(promptDictionary.keys)
        let randomKey = keys.randomElement() ?? 0
        let promptData = promptDictionary[randomKey]
        
        let availablePrompts = [promptData?.p1, promptData?.p2, promptData?.p3]
            .compactMap { $0 }
            .filter { !$0.isEmpty }

        return (randomKey, availablePrompts.randomElement() ?? "No prompt found.")
    }
}
