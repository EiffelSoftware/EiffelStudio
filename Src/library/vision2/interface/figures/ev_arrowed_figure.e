indexing
	description:
		"Figure that is can have an arrowhead at its start or endpoint."
	status: "See notice at end of class"
	keywords: "figure, line, arrow"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ARROWED_FIGURE

inherit
	EV_FIGURE_MATH

feature -- Access

	is_start_arrow: BOOLEAN is
			-- Does `point_a' have an arrow?
		do
			Result := start_arrow /= Void
		end

	is_end_arrow: BOOLEAN is
			-- Does `point_b' have an arrow?
		do
			Result := end_arrow /= Void
		end

	arrow_size: INTEGER is 10

feature -- Status setting

	enable_end_arrow is
			-- Set `is_end_arrow' `True'.
		do
			if end_arrow = Void then
				build_end_arrow
			end
		end

	disable_end_arrow is
			-- Set `is_end_arrow' `False'.
		do
			end_arrow := Void
		end

	enable_start_arrow is
			-- Set `is_start_arrow' `True'.
		do
			if start_arrow = Void then
				build_start_arrow
			end
		end

	disable_start_arrow is
			-- Set `is_start_arrow' `False'.
		do
			start_arrow := Void
		end

	line_width: INTEGER is
		deferred
		end

feature {EV_FIGURE_DRAWING_ROUTINES, EV_FIGURE} -- Implementation

	start_arrow: EV_FIGURE_POLYGON
			-- Triangle acting as arrow on `point_a'.

	end_arrow: EV_FIGURE_POLYGON
			-- Triangle acting as arrow on `point_b'.

	update_arrows is
			-- Call after `line_width' changed.
		local
			s: INTEGER
		do
			s := Arrow_size + line_width
			if end_arrow /= Void then
				end_draw_point.set_x (line_width)
				end_arrow.i_th_point (1).set_position (s, -s // 2)
				end_arrow.i_th_point (3).set_position (s, s // 2)
			end
			if start_arrow /= Void then
				start_draw_point.set_x (-line_width)
				start_arrow.i_th_point (1).set_position (-s, -s // 2)
				start_arrow.i_th_point (3).set_position (-s, s // 2)
			end
		end

	build_start_arrow is
			-- Create `start_arrow'.
		do
			create start_arrow
			start_arrow.set_point_count (3)
			start_arrow.i_th_point (2).set_origin (start_point)
			start_arrow.i_th_point (1).set_origin (start_arrow.i_th_point (2))
			start_arrow.i_th_point (3).set_origin (start_arrow.i_th_point (2))
			create start_draw_point
			start_draw_point.set_origin (start_arrow.i_th_point (2))
			update_arrows
		end

	build_end_arrow is
			-- Create `end_arrow'.
		do
			create end_arrow
			end_arrow.set_point_count (3)
			end_arrow.i_th_point (2).set_origin (end_point)
			end_arrow.i_th_point (1).set_origin (end_arrow.i_th_point (2))
			end_arrow.i_th_point (3).set_origin (end_arrow.i_th_point (2))
			create end_draw_point
			end_draw_point.set_origin (end_arrow.i_th_point (2))
			update_arrows
		end

	start_point: EV_RELATIVE_POINT is
			-- Point where `start_arrow' is drawn.
		deferred
		end

	start_ref_point: EV_RELATIVE_POINT is
			-- Point that determines the angle for `start_point'.
		deferred
		end

	end_point: EV_RELATIVE_POINT is
			-- Point where `end_arrow' is drawn.
		deferred
		end

	end_ref_point: EV_RELATIVE_POINT is
			-- Point that determines the angle for `end_point'.
		deferred
		end

	start_angle: DOUBLE is
			-- Actual angle the line is on relative to the world.
		do
			Result := line_angle (start_point.x_abs, start_point.y_abs,
				end_point.x_abs, end_point.y_abs)
		end

	end_angle: DOUBLE is
			-- Actual angle the line is on relative to the world.
		do
			Result := -line_angle (start_point.x_abs, start_point.y_abs,
				end_point.x_abs, end_point.y_abs)
		end

	end_draw_point: EV_RELATIVE_POINT
			-- Actual ending point of drawn line when arrow is visible.

	start_draw_point: EV_RELATIVE_POINT
			-- Actual starting point of drawn line when arrow is visible.

end -- class EV_ARROWED_FIGURE

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
