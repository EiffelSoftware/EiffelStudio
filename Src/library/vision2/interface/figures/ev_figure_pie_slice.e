indexing
	description:
		"A figure that is a part of circle enclosed by two lines from its%N%
		%center. Defined by a center point, one of the corner points and an%N%
		%aperture."
	status: "See notice at end of file"
	keywords: "figure, slice, pizza, pie"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_PIE_SLICE

inherit
	EV_CLOSED_FIGURE
		export
			{ANY} Pi
		redefine
			default_create
		end

create
	default_create,
	make_with_points,
	make_for_test

feature -- Initialization

	default_create is
			-- Default situation.
		do
			Precursor
			aperture := Pi / 4
		end

	make_with_points (a_center, a_corner: EV_RELATIVE_POINT) is
			-- Create with points `center' and `corner'.
		require
			a_center_exists: a_center /= Void
			a_center_not_in_figure: a_center.figure = Void
			a_corner_exists: a_corner /= Void
			a_corner_not_in_figure: a_corner.figure = Void
		do
			default_create
			set_center (a_center)
			set_corner (a_corner)
		ensure
			center_assigned: center = a_center
			corner_assigned: corner = a_corner
		end

	make_for_test is
			-- Create interesting to display.
		do
			default_create
			get_point_by_index (1).set_x (70)
			get_point_by_index (1).set_y (130)
			get_point_by_index (2).set_x (90)
			get_point_by_index (2).set_y (30)
			set_foreground_color (create {EV_COLOR}.make_with_rgb (
				0.5, 1.0, 0.5))
			set_fill_color (create {EV_COLOR}.make_with_rgb (0.0, 0.0, 0.0))
			set_line_width (1)
		end

feature -- Access

	aperture: REAL
			-- Angle that denotes the size of the pie slice.

	point_count: INTEGER is
			-- A pie slice consists of 2 points.
		once
			Result := 2
		end

	center: EV_RELATIVE_POINT is
			-- The center of the pie slice.
		do
			Result := get_point_by_index (1)
		end

	corner: EV_RELATIVE_POINT is
			-- One of the corner coordinates.
		do
			Result := get_point_by_index (2)
		end

feature -- Status setting

	set_aperture (an_aperture: REAL) is
			-- Set `aperture' to `an_aperture'.
		require
			an_aperture_bigger_than_minus_two_times_pi: an_aperture >= -2 * Pi
			an_aperture_smaller_than_two_times_pi: an_aperture <= 2 * Pi
		do
			aperture := an_aperture
		ensure
			aperture_assigned: aperture = an_aperture
		end

	set_center (a_center: EV_RELATIVE_POINT) is
			-- Change the reference of `center' with `a_center'.
		require
			a_center_exists: a_center /= Void
			a_center_not_in_figure: a_center.figure = Void
		do
			set_point_by_index (1, a_center)
		ensure
			center_assigned: a_center = center
		end

	set_corner (a_corner: EV_RELATIVE_POINT) is
			-- Change the reference of `corner' with `a_corner'.
		require
			a_corner_exists: a_corner /= Void
			a_corner_not_in_figure: a_corner.figure = Void
		do
			set_point_by_index (2, a_corner)
		ensure
			corner_assigned: a_corner = corner
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			Result := False
			--| FIXME To be implemented.
		end

invariant
	aperture_within_bounds: aperture >= -2 * Pi and then aperture <= 2 * Pi

end -- class EV_FIGURE_PIE_SLICE

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
