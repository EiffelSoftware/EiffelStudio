indexing
	description:
		"Figure that is an ellipse exactly fitting inside an imaginary%N%
		%rectangle defined by 2 points."
	status: "See notice at end of class."
	keywords: "figure, ellipse, circle"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_ELLIPSE

inherit
	EV_CLOSED_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make_with_points,
	make_for_test

feature -- Initialization

	default_create is
			-- Create in (0, 0) with dimensions 0.
		do
			Precursor
		end

	make_with_points (p1, p2: EV_RELATIVE_POINT) is
			-- Create with position `p1' and `p2'.
		require
			p1_exists: p1 /= Void
			p2_exists: p2 /= Void
		do
			default_create
			set_point_a (p1)
			set_point_b (p2)
		end

	make_for_test is
			-- Create interesting to display.
		do
			default_create
			get_point_by_index (1).set_x (10)
			get_point_by_index (1).set_y (10)
			get_point_by_index (2).set_x (90)
			get_point_by_index (2).set_y (190)
			set_foreground_color (create {EV_COLOR}.make_with_rgb (
				0.5, 1.0, 0.5))
			set_fill_color (create {EV_COLOR}.make_with_rgb (0.5, 0.0, 1.0))
			set_line_width (7)
		end

feature -- Access

	point_count: INTEGER is
			-- A line consists of 2 points.
		once
			Result := 2
		end

	point_a: EV_RELATIVE_POINT is
			-- The first point of the ellipse.
		do
			Result := get_point_by_index (1)
		end

	point_b: EV_RELATIVE_POINT is
			-- The opposing point of the ellipse.
		do
			Result := get_point_by_index (2)
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
			point_a_assigned: p2 = point_b
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			Result := point_on_ellipse (x, y,
				(point_a.x_abs + point_b.x_abs) // 2,
				(point_a.y_abs + point_b.y_abs) // 2,
				radius1, radius2)
		end

feature -- Status report

	center: EV_COORDINATES is
			-- get the center point of the ellipse.
		do
			create Result.set (
				(point_a.x_abs + point_b.x_abs) // 2,
				(point_a.y_abs + point_b.y_abs) // 2)
		end

	radius1: INTEGER is
			-- The horizontal component of the radius.
		do
			Result := ((point_a.x_abs - point_b.x_abs) // 2).abs
		end

	radius2: INTEGER is
			-- The vertical component of the radius.
		do
			Result := ((point_a.y_abs - point_b.y_abs) // 2).abs
		end

end -- class EV_FIGURE_ELLIPSE

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
--| Revision 1.6  2000/04/26 15:56:34  brendel
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

