indexing
	description:
		"Figure that is equilateral (i.e. all its sides have the same size)%N%
		%Defined by a center point and one corner point. The rest of the%N%
		%corner points are calculated through the number of sides."
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
			bounding_box,
			make_for_test
		end

create
	default_create,
	make_with_points,
	make_for_test

feature -- Initialization

	default_create is
			-- Create with 8 sides.
		do
			Precursor
			side_count := 8
		end

	make_with_points (p1, p2: EV_RELATIVE_POINT) is
			-- Create with points `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p1_not_in_figure: p1.figure = Void
			p2_exists: p2 /= Void
			p2_not_in_figure: p2.figure = Void
		do
			default_create
			set_center_point (p1)
			set_corner_point (p2)
		ensure
			center_point_assigned: center_point = p1
			corner_point_assigned: corner_point = p2
		end

	make_for_test is
			-- Create interesting to display.
		do
			Precursor
			set_side_count (11)
		end

feature -- Access

	side_count: INTEGER
			-- The number of sides of this equilateral.

	point_count: INTEGER is
			-- A line consists of 2 points.
		once
			Result := 2
		end

	center_point: EV_RELATIVE_POINT is
			-- The center coordinates of the equilateral.
		do
			Result := get_point_by_index (1)
		end

	corner_point: EV_RELATIVE_POINT is
			-- One of the corner-coordinates of the equilateral.
		do
			Result := get_point_by_index (2)
		end

feature -- Status setting

	set_side_count (n: INTEGER) is
				-- Set the `side_count' to `n'.
		require
			n_bigger_than_two: n > 2
		do
			side_count := n
		end

	set_center_point (p1: EV_RELATIVE_POINT) is
			-- Change the reference of `center_point' with `p1'.
		require
			p1_exists: p1 /= Void
			p1_not_in_figure: p1.figure = Void
		do
			set_point_by_index (1, p1)
		ensure
			center_point_assigned: p1 = center_point
		end

	set_corner_point (p2: EV_RELATIVE_POINT) is
			-- Change the reference of `corner_point' with `p2'.
		require
			p2_exists: p2 /= Void
			p2_not_in_figure: p2.figure = Void
		do
			set_point_by_index (2, p2)
		ensure
			corner_point_assigned: p2 = corner_point
		end

feature -- Implementation

	polygon_array: ARRAY [EV_COORDINATES] is
			-- Return all corner points.
		local
			n: INTEGER
			radius: INTEGER
			ang, ang_step: REAL
		do
			from
				radius := distance (center_point.x_abs, center_point.y_abs,
					corner_point.x_abs, corner_point.y_abs)
				create Result.make (1, side_count)
				Result.put (create {EV_COORDINATES}.set (
					corner_point.x_abs, corner_point.y_abs), 1)
				n := 2
				ang_step := 2 * Pi / side_count
				ang := line_angle (center_point.x_abs, center_point.y_abs,
					corner_point.x_abs, corner_point.y_abs)
			until
				n > side_count
			loop
				ang := ang + ang_step
				Result.put (create {EV_COORDINATES}.set (
					center_point.x + delta_x (ang, radius),
					center_point.y + delta_y (ang, radius)), n)

				--| FIXME
				--| Sometimes, there is a segmentation violation in this
				--| function. It might be a bug in ARRAY...

				n := n + 1
			end
		ensure
			Result_correct_size: Result.count = side_count
		end

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			Result := point_on_polygon (x, y, polygon_array)
		end

	bounding_box: EV_RECTANGLE is
			-- Calculate the smallest box all points
			-- of this figure fit in.
		local
			min_x, min_y, max_x, max_y, n: INTEGER
			poly: ARRAY [EV_COORDINATES]
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
			create Result.set (create {EV_COORDINATES}.set (min_x, min_y),
				max_x - min_x + 1, max_y - min_y + 1)
		ensure then
			Result_exists: Result /= Void
		end

invariant
	side_count_bigger_than_two: side_count > 2

end -- class EV_FIGURE_EQUILATERAL

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/04/27 19:10:50  brendel
--| Centralized testing code.
--|
--| Revision 1.6  2000/04/26 16:27:06  brendel
--| Cosmetics.
--|
--| Revision 1.5  2000/04/26 15:56:34  brendel
--| Added CVS Log.
--| Added copyright notice.
--| Improved description.
--| Added keywords.
--| Formatted for 80 columns.
--| Added make_for_test.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

