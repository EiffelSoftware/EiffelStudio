indexing
	description:
		"Figure that is a triangle defined by its 3 corner points."
	status: "See notice at end of file"
	keywords: "figure, triangle"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_TRIANGLE

inherit
	EV_CLOSED_FIGURE

create
	default_create,
	make_with_points,
	make_for_test

feature {NONE} -- Initialization

	make_with_points (p1, p2, p3: EV_RELATIVE_POINT) is
			-- Create with position `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p2_exists: p2 /= Void
			p3_exists: p3 /= Void
		do
			default_create
			set_point_a (p1)
			set_point_b (p2)
			set_point_c (p3)
		end

	make_for_test is
			-- Create interesting to display.
		do
			default_create
			get_point_by_index (1).set_x (3)
			get_point_by_index (1).set_y (3)
			get_point_by_index (2).set_x (97)
			get_point_by_index (2).set_y (197)
			get_point_by_index (2).set_x (10)
			get_point_by_index (2).set_y (180)
			set_foreground_color (create {EV_COLOR}.make_with_rgb (0.5, 0.5, 0.9))
			set_line_width (4)
		end

feature -- Status report

	point_count: INTEGER is
			-- A triangle consists of 3 points.
		once
			Result := 3
		end

	point_a: EV_RELATIVE_POINT is
			-- The first coordinates of the triangle.
		do
			Result := get_point_by_index (1)
		end

	point_b: EV_RELATIVE_POINT is
			-- The second coordinates of the triangle.
		do
			Result := get_point_by_index (2)
		end

	point_c: EV_RELATIVE_POINT is
			-- The third coordinates of the triangle.
		do
			Result := get_point_by_index (3)
		end

feature -- Status setting

	set_point_a (p1: EV_RELATIVE_POINT) is
			-- Change the reference of `position_a' with `p1'.
		require
			p1_exists: p1 /= Void
		do
			set_point_by_index (1, p1)
		ensure
			point_a_assigned: p1 = point_a
		end

	set_point_b (p2: EV_RELATIVE_POINT) is
			-- Change the reference of `position_b' with `p2'.
		require
			p2_exists: p2 /= Void
		do
			set_point_by_index (2, p2)
		ensure
			point_b_assigned: p2 = point_b
		end

	set_point_c (p3: EV_RELATIVE_POINT) is
			-- Change the reference of `point_c' with `p3'.
		require
			p3_exists: p3 /= Void
		do
			set_point_by_index (3, p3)
		ensure
			point_c_assigned: p3 = point_c
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			--| FIXME Always filled?
			--| We can use optimized alg.'s for triangle.
			Result := point_on_polygon (x, y, point_array)
		end

end -- class EV_FIGURE_TRIANGLE

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
