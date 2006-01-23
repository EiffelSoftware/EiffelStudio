indexing
	description:
		"Figure that is can have an arrowhead at its start or endpoint."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, line, arrow"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ARROWED_FIGURE

inherit
	ANY

	EV_FIGURE_MATH
		export
			{NONE} all
		end

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
				end_arrow.i_th_point (1).set_position (-s, -s // 2)
				end_arrow.i_th_point (3).set_position (-s, s // 2)
			end
			if start_arrow /= Void then
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
			update_arrows
		end

	start_point: EV_RELATIVE_POINT is
			-- Point where `start_arrow' is drawn.
		deferred
		end

	start_ref_point: EV_RELATIVE_POINT is
			-- Point that determines angle for `start_point'.
		deferred
		end

	end_point: EV_RELATIVE_POINT is
			-- Point where `end_arrow' is drawn.
		deferred
		end

	end_ref_point: EV_RELATIVE_POINT is
			-- Point that determines angle for `end_point'.
		deferred
		end

	start_angle: DOUBLE is
			-- Angle that line begins on relative to world.
		do
			Result := modulo (Pi + line_angle (start_point.x_abs, start_point.y_abs,
				end_point.x_abs, end_point.y_abs), 2 * Pi)
		end

	end_angle: DOUBLE is
			-- Angle that line ends on relative to world.
		do
			Result := modulo (line_angle (start_point.x_abs, start_point.y_abs,
				end_point.x_abs, end_point.y_abs), 2 * Pi)
		end

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




end -- class EV_ARROWED_FIGURE

