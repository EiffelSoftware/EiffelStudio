indexing
	description:
		"Figure that is a line segment between 2 points."
	status: "See notice at end of class"
	keywords: "figure, line, segment, arrow"
	date: "$Date$"
	revision: "$Revision$"

	--| FIXME To be implemented:
	--| Optional arrowhead on either point.

class
	EV_FIGURE_LINE

inherit
	EV_ATOMIC_FIGURE

create
	default_create,
	make_with_points,
	make_with_positions,
	make_for_test

feature {NONE} -- Initialization

	make_with_points (p1, p2: EV_RELATIVE_POINT) is
			-- Create with points `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p1_not_in_figure: p1.figure = Void
			p2_exists: p2 /= Void
			p2_not_in_figure: p2.figure = Void
		do
			default_create
			set_point_a (p1)
			set_point_b (p2)
		ensure
			point_a_assigned: point_a = p1
			point_b_assigned: point_b = p2
		end

	make_with_positions (x1, y1, x2, y2: INTEGER) is
			-- Create on (x1, y1)-(x2, y2).
		do
			default_create
			get_point_by_index (1).set_x (x1)
			get_point_by_index (1).set_y (y1)
			get_point_by_index (2).set_x (x2)
			get_point_by_index (2).set_y (y2)
		ensure
			point_a_x_assigned: point_a.x = x1
			point_a_y_assigned: point_a.y = y1
			point_b_x_assigned: point_b.x = x2
			point_b_y_assigned: point_b.y = y2
		end

	make_for_test is
			-- Create interesting to display.
		do
			default_create
			get_point_by_index (1).set_x (3)
			get_point_by_index (1).set_y (3)
			get_point_by_index (2).set_x (97)
			get_point_by_index (2).set_y (197)
			set_foreground_color (create {EV_COLOR}.make_with_rgb (
				0.5, 1.0, 0.5))
			set_line_width (4)
		end

feature -- Access

	point_count: INTEGER is
			-- A line consists of 2 points.
		once
			Result := 2
		end

	point_a: EV_RELATIVE_POINT is
			-- The first coordinates of the line.
		do
			Result := get_point_by_index (1)
		end

	point_b: EV_RELATIVE_POINT is
			-- The first coordinates of the line.
		do
			Result := get_point_by_index (2)
		end

feature -- Status setting

	set_point_a (p1: EV_RELATIVE_POINT) is
			-- Change the reference of `position_a' with `p1'.
		require
			p1_exists: p1 /= Void
			p1_not_in_figure: p1.figure = Void
		do
			set_point_by_index (1, p1)
		ensure
			point_a_assigned: p1 = point_a
		end

	set_point_b (p2: EV_RELATIVE_POINT) is
			-- Change the reference of `position_b' with `p2'.
		require
			p2_exists: p2 /= Void
			p2_not_in_figure: p2.figure = Void
		do
			set_point_by_index (2, p2)
		ensure
			point_a_assigned: p2 = point_b
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			Result := point_on_segment (x, y,
				point_a.x_abs, point_a.y_abs,
				point_b.x_abs, point_b.y_abs, line_width)
		end

end -- class EV_FIGURE_LINE

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
--| Revision 1.7  2000/04/26 15:56:34  brendel
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
