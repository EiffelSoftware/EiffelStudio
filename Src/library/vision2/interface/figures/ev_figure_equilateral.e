indexing
	description:
		"Figures with its sides the same size."
	status: "See notice at end of class"
	keywords: "figure, equilateral, hexagon, octagon"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_EQUILATERAL

inherit
	EV_CLOSED_FIGURE
		redefine
			default_create,
			bounding_box
		end

	EV_DOUBLE_POINTED_FIGURE
		rename
			point_a as center_point,
			point_b as corner_point
		undefine
			default_create
		end

create
	default_create,
	make_with_points

feature {NONE} -- Initialization

	default_create is
			-- Create with 8 sides.
		do
			side_count := 8
			Precursor {EV_CLOSED_FIGURE}
		end

feature -- Access

	side_count: INTEGER
			-- Number of sides.

feature -- Status setting

	set_side_count (n: INTEGER) is
			-- Assign `n' to `side_count'.
		require
			n_greater_than_two: n > 2
		do
			side_count := n
		ensure
			side_count_assigned: side_count = n
		end

feature -- Implementation

	polygon_array: ARRAY [EV_COORDINATE] is
			-- Absolute coordinates of all corner points.
		local
			n: INTEGER
			radius: INTEGER
			ang, ang_step: DOUBLE
			crd: EV_COORDINATE
		do
			from
				radius := distance (center_point.x_abs, center_point.y_abs,
					corner_point.x_abs, corner_point.y_abs)
				create Result.make (1, side_count)
				n := 1
				ang_step := 2 * Pi / side_count
				ang := line_angle (center_point.x_abs, center_point.y_abs,
					corner_point.x_abs, corner_point.y_abs)
			until
				n > side_count
			loop
				create crd.set (
					center_point.x_abs + delta_x (ang, radius),
					center_point.y_abs + delta_y (ang, radius))
				Result.put (crd, n)
				ang := ang + ang_step
				n := n + 1
			end
		ensure
			Result_correct_size: Result.count = side_count
		end

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') on this figure?
		do
			Result := point_on_polygon (x, y, polygon_array)
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			min_x, min_y, max_x, max_y, n: INTEGER
			poly: ARRAY [EV_COORDINATE]
		do
			from
				poly := polygon_array
				n := poly.lower
				min_x := poly.item (n).x
				min_y := poly.item (n).y
				max_x := min_x
				max_y := min_y
				n := n + 1
			until
				n > poly.upper
			loop
				min_x := poly.item (n).x.min (min_x)
				min_y := poly.item (n).y.min (min_y)
				max_x := poly.item (n).x.max (max_x)
				max_y := poly.item (n).y.max (max_y)
				n := n + 1
			end
			create Result.set (min_x, min_y, max_x - min_x + 1, max_y - min_y + 1)
		ensure then
			Result_exists: Result /= Void
		end

invariant
	side_count_bigger_than_two: side_count > 2

end -- class EV_FIGURE_EQUILATERAL

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

