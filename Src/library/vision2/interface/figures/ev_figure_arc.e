indexing
	description:
		"A figure that is a curve through 3 points."
	status: "See notice at end of class"
	keywords: "figure, arc, curve"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_ARC


inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make_with_points,
	make_for_test

feature -- Initialization

	default_create is
			-- Default situation: pa pb and pc are all (0, 0).
		do
			Precursor
		end

	make_with_points (pa, pb, pc: EV_RELATIVE_POINT) is
			-- Create with points `pa', `pb' and `pc'.
		require
			pa_exists: pa /= Void
			pb_exists: pb /= Void
			pc_exists: pc /= Void
		do
			default_create
			set_point_a (pa)
			set_point_b (pb)
			set_point_c (pc)
		end

	make_for_test is
			-- Create interesting to display.
		do
			default_create
			get_point_by_index (1).set_x (30)
			get_point_by_index (1).set_y (10)
			get_point_by_index (2).set_x (90)
			get_point_by_index (2).set_y (110)
			get_point_by_index (3).set_x (10)
			get_point_by_index (3).set_y (170)
			set_foreground_color (create {EV_COLOR}.make_with_rgb (
				1.0, 0.0, 0.0))
			set_line_width (10)
		end

feature -- Access

	point_count: INTEGER is
			-- An arc consists of 3 points.
		once
			Result := 3
		end

	point_a: EV_RELATIVE_POINT is
			-- The starting coordinate of the arc.
		do
			Result := get_point_by_index (1)
		end

	point_b: EV_RELATIVE_POINT is
			-- The coordinates on the line of the arc.
		do
			Result := get_point_by_index (2)
		end

	point_c: EV_RELATIVE_POINT is
			-- The ending coordinate of the arc.
		do
			Result := get_point_by_index (3)
		end

feature -- Status setting

	set_point_a (pa: EV_RELATIVE_POINT) is
			-- Change the reference of `point_a' with `pa'.
		require
			pa_exists: pa /= Void
			pa_not_in_figure: pa.figure = Void
		do
			set_point_by_index (1, pa)
		ensure
			point_a_assigned: pa = point_a
		end

	set_point_b (pb: EV_RELATIVE_POINT) is
			-- Change the reference of `point_b' with `pb'.
		require
			pb_exists: pb /= Void
			pb_not_in_figure: pb.figure = Void
		do
			set_point_by_index (2, pb)
		ensure
			point_b_assigned: pb = point_b
		end

	set_point_c (pc: EV_RELATIVE_POINT) is
			-- Change the reference of `point_c' with `pc'.
		require
			pc_exists: pc /= Void
			pc_not_in_figure: pc.figure = Void
		do
			set_point_by_index (3, pc)
		ensure
			point_c_assigned: pc = point_c
		end

	center: EV_COORDINATES is
			-- Calculate the center of the arc.
			-- This is the middle of a and c.
		do
			create Result.set (
				(point_a.x_abs + point_c.x_abs) // 2,
				(point_a.y_abs + point_c.y_abs) // 2)
		end

	ellipse_angle: REAL is
			-- Calculate the angle between `center' and `point_b'.
		do
			Result := arc_tangent (
				(center.x - point_b.x_abs) / (center.y - point_b.y_abs))
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			Result := False
		end

end -- class EV_FIGURE_ARC

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
--| Revision 1.6  2000/04/26 17:27:17  brendel
--| Corrected index for point.
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
