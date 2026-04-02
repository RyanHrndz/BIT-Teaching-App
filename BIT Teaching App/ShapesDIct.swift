//
//  ShapesDict.swift
//  Tap_n_Math
//
//  Created by Bryce Swearingen on 5/8/24.
//
import Foundation

let shapesDictionary: [String: String] = [
    "2": """

           Circle:

       
           Equations: The area of a circle is equal to pi times the radius squared, represented by A equals 2 pi r squared.

            The circumference of a circle is equal to 2 pi times the radius, represented by C equals 2 pi r.

           Definition: A round-shaped figure that doesn’t have corners or edges. The diameter is a line segment that passes through the center and its endpoints are on the circumference. The radius is equal to half of the diameter.

       """,

    

       "1": """

           Rectangle and Square:

       
           Equations: The area of a rectangle is equal to the base times the height, represented by A equals l w.

            The perimeter is equal to two times the sum of the base and the height, represented by P equals 2 l plus 2 w.

           Definition: A polygon with four sides (quadrilateral) whose opposite sides are equal and parallel. Its four angles are all congruent and equal to ninety degrees. Therefore, the sum of the angles is three hundred and sixty degrees. A square is a special case where all four sides are congruent.

       """,

    

       "9": """

           Trapezoid:


           Equations: The area of a trapezoid is one-half times the height times the sum of the parallel side lengths, represented by A equals one-half (A plus b) h.

            The perimeter is the sum of the side lengths, represented by P equals A, plus b, plus c, plus d.

           Definition: A polygon with four sides (quadrilateral) and one set of parallel sides.

       """,

    

       "8": """

           Parallelogram and Rhombus:


           Equations: The area of a parallelogram is equal to the base times the height, represented by A equals b h.

            The perimeter of a parallelogram is two times the sum of its two adjacent sides, represented by P equals 2 (A plus b).

           Definition: A polygon with four sides (quadrilateral) with two pairs of parallel sides. The opposite sides are equal in length and the opposite angles are equal in measure. A rhombus is a special case where all of the sides are equal in length.

       """,

    

       "4": """

           Regular Triangle:


           Equations: The area of a triangle is one-half times the base times the height, represented by A equals one-half b h.

            The perimeter of a triangle is the sum of all the sides, represented by P equals A, plus b, plus c.

           Definition: A three-sided polygon that has three edges and three vertices. The sum of the interior angles is equal to one hundred and eighty degrees.

       """,

    

       "6": """

           Right Triangle:


           Equations: The hypotenuse squared is equal to both of the legs squared, where the hypotenuse is represented by c, and the legs are represented by A, and b. This is known as the Pythagorean Theorem. This is represented by A squared plus b squared equals c squared.

           Definition: A fundamental relationship between the three sides of a right triangle. It is only true for right triangles. Right triangles are triangles that have one angle equal to ninety degrees.

       """,

    

       "3": """

           Equilateral Triangle:


           Equations: The area of an equilateral triangle is one-half times the base times the height, represented by A equals one-half b h.

            The perimeter of an equilateral triangle is the sum of all the sides, represented by P equals A, plus b, plus c.

           Definition: A triangle with three congruent sides and three congruent interior angles of sixty degrees.

       """,

    

       "5": """

           Isosceles Triangle:


           Equations: The area of an isosceles triangle is one-half times the base times the height, represented by A equals one-half b h.

            The perimeter of an isosceles triangle is the sum of all the sides, represented by P equals A, plus b, plus c.

           Definition: A triangle with two congruent sides and congruent base angles.

       """,

    

       "7": """

           Scalene Triangle:


            Equations: The area of a scalene triangle is one-half times the base times the height, represented by A equals one-half b h.

            The perimeter of a scalene triangle is the sum of all the sides, represented by P equals A, plus b, plus c.

           Definition: A triangle in which all three sides are different in length and all three angles are in different measure.

       """,

    

       "10": """

           Parallel Lines:


           Definition: Two or more lines that are always the same distance apart and never intersect, even if they are extended infinitely in both directions.

       """,

       "12": """

           Acute Angle:

        
           Definition: An angle that is less than ninety degrees.

       """,

    

       "11": """

           Right Angle:


           Definition: An angle that is equal to ninety degrees. When two lines are perpendicular to each other, they form a right angle.

       """,

    

       "13": """

           Obtuse Angle:
        

           Definition: An angle that is greater than ninety degrees but less than one hundred and eighty degrees.

       """,

    

       "14": """

           The Pi Symbol:

           Definition: The ratio of the circumference of a circle to its diameter. It is a constant that is approximately equal to 3.14 and represented by its Greek letter.

       """,


       "15": """

           The Angle Symbol:

           Definition: This symbol represents the character to denote an angle.

       """,

    

       "16": """

           The Degree Symbol:

           Definition: This symbol is used to represent degrees of an arc.

       """,

    

       "17": """

           Rectangular Prism:
        

           Equation: The volume is equal to the length times the width times the height. The dimensions of this shape are L, W, and H.

           Definitions: A three-dimensional shape that has six faces, eight vertices, and twelve edges. All faces are rectangular which results in three pairs of identical faces.

       """,

    

       "18": """

           Square Pyramid:
        

           Equation: The volume is equal to one-third times the length, times the width, times the height. The dimensions of this shape are L and W.

           Definitions: A three-dimensional shape with five faces, five vertices, and eight edges. A rectangle or square is the base of the pyramid with four connected triangles that meet at a common vertex.

       """,


       "19": """

           Triangular Prism:
        

           Equation: The volume is equal to the area of the triangular base times the length, represented by V equals one-half (b h) l.

           Definitions: A three-dimensional shape with five faces, six vertices, and nine edges. There are two triangular bases and three rectangular sides.

       """,

       "20": """

           Cylinder:
        

           Equation: The volume is equal to pi times the radius of the base circle squared times the height, represented by V equals 2 pi r h.

           Definitions: A three-dimensional shape with two flat faces, one curved surface, and two curved edges. There are two parallel circles for the bases that are joined by a curved surface.

       """,

       "21": """

           Cone:
        

           Equation: The volume is equal to one-third times pi, times the radius of the base circle squared, times the height. The dimension on this shape is r.

           Definitions: A three-dimensional shape with one flat surface, one curved surface, one vertex, and one curved edge. The base is a circle and the curved surface narrows from the base to a vertex.

       """,

       "22": """

           Sphere:
        

           Equation: The volume of a sphere is four-thirds times pi times the radius cubed.

           Definitions: A three-dimensional shape with no faces, vertices, or edges.

       """,
    "23": """
    
        Test Plate:
    
        Row one, capital letters:
            P, L, W, A, C, H, V.
        
        Row two, lowercase letters:
            B, H, A, C, D, R.
        
        Row three, exponents:
            R squared, R cubed, A squared, B squared, C squared.
    
        Row four, numbers:
            One Half, One Third, Four Thirds, 90.
    
        Row five, symbols:
            Open Parenthesis, Plus sign, Equals sign, Pi, Close Parenthesis.
    
    
    """

   ]
