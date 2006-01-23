indexing
	description:
		"Slices from an ellipse with `center_point'. Size is determined by%N%
		%`aperture' [0..2*Pi]. See EV_FIGURE_ARC for more informations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, slice, pizza, pie"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_PIE_SLICE

inherit
	EV_MODEL_ELLIPTIC
		redefine
			default_create
		end
		
	EV_MODEL_CLOSED
		undefine
			bounding_box,
			default_create,
			point_count
		end

create
	default_create,
	make_with_positions,
	make_with_points

feature {NONE} -- Initialization

	default_create is
			-- Create with some `start_angle' and `aperture'.
		do
			Precursor {EV_MODEL_ELLIPTIC}
			start_angle := 0.2
			aperture := Pi / 2
		end

feature -- Access

	start_angle: DOUBLE
			-- Angle that defines start of arc.

	aperture: DOUBLE
			-- Angle that defines percentage of arc.

feature -- Element change

	set_start_angle (a_start_angle: DOUBLE) is
			-- Set `start_angle' to `a_start_angle'.
		require
			a_start_angle_within_bounds:
				a_start_angle >= 0 and a_start_angle <= 2 * Pi
		do
			start_angle := a_start_angle
			invalidate
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
			invalidate
		ensure
			aperture_assigned: aperture = an_aperture
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN is
			-- Is (`a_x', `a_y') on this figure?
		local
			cx, cy, p0x, p0y: DOUBLE
			an_angle, end_angle, r1, r2: DOUBLE
			angle_inside: BOOLEAN
			p0, p1: EV_COORDINATE
			l_point_array: like point_array
		do
			if aperture /= 0.0 then
				l_point_array := point_array
				p0 := l_point_array.item (0)
				p1 := l_point_array.item (1)
				
				p0x := p0.x_precise
				p0y := p0.y_precise
				
				cx := (p0x + p1.x_precise) / 2
				cy := (p0y + p1.y_precise) / 2
				
				r1 := (cx - p0x).abs
				r2 := (cy - p0y).abs
				
				an_angle := pi_times_two - line_angle (cx, cy, a_x, a_y)
				end_angle := modulo (start_angle + aperture, pi_times_two)
				if start_angle < end_angle then
					angle_inside := an_angle >= start_angle and an_angle <= end_angle
				else
					angle_inside := an_angle >= start_angle or an_angle <= end_angle
				end
				
				Result := angle_inside and then point_on_ellipse (a_x, a_y, cx, cy, r1, r2)
			else
				Result := False
			end	
		end

invariant
	start_angle_within_bounds: start_angle >= 0 and then start_angle <= 2 * Pi
	aperture_within_bounds: aperture >= 0 and then aperture <= 2 * Pi

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




end -- class EV_MODEL_PIE_SLICE

