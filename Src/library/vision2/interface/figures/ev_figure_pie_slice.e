indexing
	description:
		"Slices from a circle with `center_point'. Size is determined by%N%
		%`aperture' [-2*Pi..2*Pi]."
	status: "See notice at end of class"
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

	EV_DOUBLE_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_points

feature {NONE} -- Initialization

	default_create is
			-- Create with some `start_angle' and `aperture'.
		do
			Precursor {EV_CLOSED_FIGURE}
			start_angle := 0.0
			aperture := Pi / 2
		end

feature -- Access

	start_angle: DOUBLE
			-- Angle that defines the start of the arc.

	aperture: DOUBLE
			-- Angle that defines the percentage of the arc.

feature -- Status setting

	set_start_angle (a_start_angle: DOUBLE) is
			-- Set `start_angle' to `a_start_angle'.
		require
			a_start_angle_within_bounds:
				a_start_angle >= 0 and a_start_angle <= 2 * Pi
		do
			start_angle := a_start_angle
		ensure
			start_angle_assigned: start_angle = a_start_angle
		end

	set_aperture (an_aperture: DOUBLE) is
			-- Set `aperture' to `an_aperture'.
		require
			an_aperture_within_bounds:
				an_aperture >= 0 and an_aperture <= 2 * Pi
		do
			aperture := an_aperture
		ensure
			aperture_assigned: aperture = an_aperture
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			--| FIXME To be implemented
			Result := False
		end

feature {EV_FIGURE_DRAWING_ROUTINES} -- Access

	metrics: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER] is
			-- [`top_left_x', `top_left_y', `width', `height']
		local
			ay, ax, bx, by: INTEGER
		do
			ax := point_a.x_abs
			ay := point_a.y_abs
			bx := point_b.x_abs
			by := point_b.y_abs
			Result := [ax, ay, (bx - ax), (by - ay)]
		end

invariant
	start_angle_within_bounds: start_angle >= 0 and then start_angle <= 2 * Pi
	aperture_within_bounds: aperture >= 0 and then aperture <= 2 * Pi

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
