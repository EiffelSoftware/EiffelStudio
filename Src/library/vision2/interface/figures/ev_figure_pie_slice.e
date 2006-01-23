indexing
	description:
		"Slices from an ellipse with `center_point'. Size is determined by%N%
		%`aperture' [0..2*Pi]."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			default_create,
			bounding_box
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
			-- Angle that defines start of arc.

	aperture: DOUBLE
			-- Angle that defines percentage of arc.

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

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			theta_start, theta_end: DOUBLE
			leftmost, rightmost, topmost, bottommost: INTEGER
			a, b, center_x, center_y: INTEGER
			top, left, bottom, right: INTEGER
			pax, pay, pbx, pby: INTEGER
			end_angle: DOUBLE
			cosine_theta_start, cosine_theta_end, sine_theta_start, sine_theta_end: DOUBLE
		do
			pax := point_a.x_abs
			pay := point_a.y_abs
			pbx := point_b.x_abs
			pby := point_b.y_abs
			
			end_angle := start_angle + aperture
			
			top := pay.min (pby)
			left := pax.min (pbx)
			bottom := pby.max (pay)
			right := pbx.max (pax)
			
			center_x := (left + right) // 2
			center_y := (top + bottom) // 2
			  
			a := (right - left) // 2
			b := (bottom - top) // 2 -- positive downwards
	  
			-- The calculations for the bounding box start here
			-- Map the image angles to the parametric angles, correcting for the tangent
			theta_start := arc_tangent (a / b * tangent(start_angle))
			if start_angle > pi_half and start_angle < pi_half_times_three then
				theta_start := theta_start + Pi
			end
			theta_end := arc_tangent(a / b * tangent(end_angle))
			if modulo(end_angle, pi_times_two) > pi_half and modulo(end_angle, pi_times_two) < pi_half_times_three then
				theta_end := theta_end + Pi
			end
			
			-- Find the bounding box for the three points on the pie
			-- Watch the signs because conventions are not completely observed
			
			cosine_theta_start := cosine(theta_start)
			cosine_theta_end := cosine(theta_end)
			sine_theta_start := sine(theta_start)
			sine_theta_end := sine(theta_end)
			
			leftmost := (center_x + a * (0.0).min(cosine_theta_start.min(cosine_theta_end))).floor
			rightmost := (center_x + a * (0.0).max(cosine_theta_start.max(cosine_theta_end))).ceiling
			topmost := (center_y - b * (0.0).max(sine_theta_start.max(sine_theta_end))).floor
			bottommost := (center_y - b * (0.0).min(sine_theta_start.min(sine_theta_end))).ceiling
			
			-- Adjust for extreme excursions of the pie, when the box is tangent to the curve
			-- Assumes positve values for aperture and start_angle
			
			if 
				(start_angle < pi_half and start_angle + aperture > pi_half) or
				(start_angle > pi_half and start_angle + aperture > pi_half_times_three + pi)
			then
				topmost := top
			end
			
			if 
				(start_angle < Pi and start_angle + aperture > Pi) or
				(start_angle > pi and start_angle + aperture > pi_times_three)
			then
				leftmost := left
			end
			 
			if 
				(start_angle < pi_half_times_three and start_angle + aperture > pi_half_times_three) or
				(start_angle > pi_half_times_three and start_angle + aperture > 7 * pi_half)
			then
				bottommost := bottom
			end
			 
			if 
				start_angle + aperture > pi_times_two
			then
				rightmost := right
			end
			
			create Result.make (leftmost, topmost, rightmost - leftmost, bottommost - topmost)
		end
		
	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') on this figure?
		local
			ay, ax, bx, by, cx, cy, top, left: INTEGER
			angle, end_angle: DOUBLE
			angle_inside: BOOLEAN
		do
			if aperture /= 0.0 then
				ax := point_a.x_abs
				ay := point_a.y_abs
				bx := point_b.x_abs
				by := point_b.y_abs
				left := ax.min (bx)
				top := ay.min (by)
				cx := left + (bx - ax).abs // 2
				cy := top + (by - ay).abs // 2
				angle := line_angle (x, y, cx, cy)
				end_angle := modulo (start_angle + aperture, pi_times_two)
				if start_angle < end_angle then
					angle_inside := angle >= start_angle and angle <= end_angle
				else
					angle_inside := angle >= start_angle or angle <= end_angle
				end
				Result := point_on_ellipse (x, y, cx, cy, cx - left, cy - top) and angle_inside
			else
				Result := False
			end	
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
			Result := [ax.min (bx), ay.min (by), (bx - ax).abs, (by - ay).abs]	
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




end -- class EV_FIGURE_PIE_SLICE

