indexing
	description: "[
					An EV_TRANSFORMATION is basicaly a matrix
					discribing a projection from one coordinate system
					into another with homogeneouse coordinates.
					You can use an EV_TRANSFORMATION to change
					shape of any transformable EV_FIGURE.

					examples:
						translating (x, y) to (x + dx, y + dy):

						| 1  0  dx |    |x|    |x + dx|
						| 0  1  dy |  * |y|  = |y + dy|
						| 0  0  1  |    |1|    |  1   |

						rotation matrix around (0, 0) for angle:

						| cosine angle   -sine angle   0 |
						|  sine angle   cosine angle   0 |
						|      0             0         1 |

						scaling for sx in x direction and sy in y direction:

						| sx  0   0 |
						|  0 sy   0 |
						|  0  0   1 |

					This transformations can be combined by just multipling the
					matrixes togetter. For example a rotation around (px, py) is
					achieved by first translating a point such that px, py is at
					(0, 0), then rotating and then translating back:

					|1 0 px|   |cosine angle   -sine angle  0|   |1 0 -px|
					|0 1 py| * | sine angle   cosine angle  0| * |0 1 -py|
					|0 0 1 |   |    0              0        1|   |0 0  1 |

					(read from right to left)
					The result matrix is build when calling rotate.

					The beauty of the approach is no matter how
					complex your transformation is the complexity is allways:
						4 multiplications and 4 additions per point (see project)

					See the book: Computer Graphics by Foley et all, side 201 for more informations.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_TRANSFORMATION

inherit
	ANY

	DOUBLE_MATH
		export
			{NONE} all
		end

create
	make_zero,
	make_id

feature {NONE} -- Initialization

	make_zero is
			-- Create a transformation matrix with all elements 0.0
		do
			create area.make (9)
		end

	make_id is
			-- Create an identity transformation matrix
		do
			create area.make (9)
			area.put (1.0, 0)
			area.put (1.0, 4)
			area.put (1.0, 8)
		end

feature -- Access

	item (row, column: INTEGER): DOUBLE is
			-- Entry at position (`row', `column')
		require
			valid_row: (1 <= row) and (row <= height)
			valid_column: (1 <= column) and (column <= width)
		do
			Result := area.item ((column-1) + (row - 1) * 3)
		end

	height: INTEGER is 3
			-- Number of rows in the matrix.

	width: INTEGER is 3
			-- Number of columns in the matrix.

feature -- Element change

	put (v: like item; row, column: INTEGER) is
			-- Put `v' to position (`row', `column')
		require
			valid_row: (1 <= row) and (row <= height)
			valid_column: (1 <= column) and (column <= width)
		do
			area.put (v, (column-1) + (row - 1) * 3)
		end

feature -- Basic operation

	rotate (an_angle: like item; a_x: like item; a_y: like item) is
			-- Set values of matrix describing a
			-- rotation around the point (`a_x', `a_y') for
			-- angle (clockwise).
		local
			sin, cos: like item
			one_minus_cos: like item
			l_area: like area
		do
			sin := sine (an_angle)
			cos := cosine (an_angle)
			one_minus_cos := 1 - cos

			l_area :=  area
			l_area.put (cos, 0); l_area.put (-sin, 1); l_area.put (a_x * one_minus_cos + a_y * sin, 2)
			l_area.put (sin, 3); l_area.put (cos, 4);  l_area.put (a_y * one_minus_cos - a_x * sin, 5)
			l_area.put (0.0, 6); l_area.put (0.0, 7);  l_area.put (1.0, 8)
		end

	translate (a_x: like item; a_y: like item) is
			-- Build a matrix describing a translation for
			-- `a_x' `a_y' pixel.
		local
			l_area: like area
		do
			l_area :=  area
			l_area.put (1.0, 0); l_area.put (0.0, 1); l_area.put (a_x, 2)
			l_area.put (0.0, 3); l_area.put (1.0, 4); l_area.put (a_y, 5)
			l_area.put (0.0, 6); l_area.put (0.0, 7); l_area.put (1.0, 8)
		end

	scale (a_scale_x: like item; a_scale_y: like item; a_x: like item; a_y: like item; an_angle: like item) is
			-- Build a matrix describing a rotation around (`a_x', `a_y') for -`an_angle', a scale
			-- of `a_scale_x' in x direction and a scale of `a_scale_y' in
			-- y direction and a rotation of `angle' around (`a_x', `a_y')
		local
			sin, cos: like item
			sin2, cos2: like item
			sincos: like item
			sxcos2, sxsin2, sycos2, sysin2: like item
			sxsincos, sysincos: like item
			one_minus_cos: like item
			l_area: like area
		do
			if an_angle = 0.0 then
				l_area :=  area
				l_area.put (a_scale_x, 0);	l_area.put (0, 1); 			l_area.put (a_x * (1 - a_scale_x), 2)
				l_area.put (0, 3); 			l_area.put (a_scale_y, 4);	l_area.put (a_y * (1 - a_scale_y), 5)
				l_area.put (0.0, 6);        l_area.put (0.0, 7);      	l_area.put (1.0, 8)
			else
				sin := sine (an_angle)
				sin2 := sin ^ 2
				cos := cosine (an_angle)
				cos2 := cos ^ 2
				sincos := sin * cos
				sxcos2 := a_scale_x * cos2
				sxsin2 := a_scale_x * sin2
				sysin2 := a_scale_y * sin2
				sycos2 := a_scale_y * cos2
				sxsincos := a_scale_x * sincos
				sysincos := a_scale_y * sincos

				one_minus_cos := 1 - cos

				l_area :=  area
				l_area.put (sxcos2 + sysin2, 0);     l_area.put (sxsincos - sysincos, 1); l_area.put (-a_x * sxcos2 - a_y * sxsincos - a_x * sysin2 + a_y * sysincos + a_x, 2)
				l_area.put (sxsincos - sysincos, 3); l_area.put (sxsin2 + sycos2, 4);     l_area.put (-a_x * sxsincos - a_y * sxsin2 + a_x * sysincos - a_y * sycos2 + a_y, 5)
				l_area.put (0.0, 6);                 l_area.put (0.0, 7);                 l_area.put (1.0, 8)
			end
		end

	scale_abs (a_scale_x: like item; a_scale_y: like item; a_x: like item; a_y: like item) is
			-- Build a matrix describing a translation to -`ax' -`ay', a scale
			-- of `a_scale_x' in x direction and a scale of `a_scale_y' in
			-- y direction and a translation to `ax' `ay'.
		local
			l_area: like area
		do
			l_area :=  area
			l_area.put (a_scale_x, 0);	l_area.put (0, 1);			l_area.put (-a_x * a_scale_x + a_x, 2)
			l_area.put (0, 3); 			l_area.put (a_scale_y, 4);	l_area.put (-a_y * a_scale_y + a_y, 5)
			l_area.put (0.0, 6);		l_area.put (0.0, 7);		l_area.put (1.0, 8)
		end

	infix "*" (other: like Current): like Current is
			-- Calculate result := Current * other.
		require
			other_not_void: other /= Void
		local
			l_area: like area
			e_11, e_21, e_12, e_22: like item
		do
			create Result.make_zero

			l_area := area
			e_11 := area.item (0)
			e_21 := area.item (3)
			e_12 := area.item (1)
			e_22 := area.item (4)

			Result.put (e_11 * other.item (1, 1) + e_12 * other.item (2, 1), 1, 1)
			Result.put (e_11 * other.item (1, 2) + e_12 * other.item (2, 2), 1, 2)
			Result.put (e_11 * other.item (1, 3) + e_12 * other.item (2, 3) + item (1, 3), 1, 3)
			Result.put (e_21 * other.item (1, 1) + e_22 * other.item (2, 1), 2, 1)
			Result.put (e_21 * other.item (1, 2) + e_22 * other.item (2, 2), 2, 2)
			Result.put (e_21 * other.item (1, 3) + e_22 * other.item (2, 3) + item (2, 3), 2, 3)
		ensure
			result_not_void: Result /= Void
		end

	project (point: EV_COORDINATE) is
			-- Project `point' using `Current' transformation.
		do
			point.set_precise ((area.item (0) * point.x_precise + area.item (1) * point.y_precise + area.item (2)),
								(area.item (3) * point.x_precise + area.item (4) * point.y_precise + area.item (5)))
		end


feature {NONE} -- Implementation

	area: SPECIAL [like item]
			-- The matrix describing the transformation.
			-- The elements are arragend like that:
			-- 0  1  2    1,1 1,2 1,3
			-- 3  4  5    2,1 2,2 2,3
			-- 6  7  8    3,1 3,2 3,3

invariant

	area_not_void: area /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MODEL_TRANSFORMATION

