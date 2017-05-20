note
	description:
		"Figure that is can have an arrowhead at its start or endpoint."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, line, arrow"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ARROWED_FIGURE

obsolete
	"Use EV_MODEL_ARROWED instead. [2017-05-31]"

inherit
	ANY

	EV_FIGURE_MATH
		export
			{NONE} all
		end

feature -- Access

	is_start_arrow: BOOLEAN
			-- Does `point_a' have an arrow?
		do
			Result := start_arrow /= Void
		end

	is_end_arrow: BOOLEAN
			-- Does `point_b' have an arrow?
		do
			Result := end_arrow /= Void
		end

	arrow_size: INTEGER = 10

feature -- Status setting

	enable_end_arrow
			-- Set `is_end_arrow' `True'.
		do
			if end_arrow = Void then
				build_end_arrow
			end
		end

	disable_end_arrow
			-- Set `is_end_arrow' `False'.
		do
			end_arrow := Void
		end

	enable_start_arrow
			-- Set `is_start_arrow' `True'.
		do
			if start_arrow = Void then
				build_start_arrow
			end
		end

	disable_start_arrow
			-- Set `is_start_arrow' `False'.
		do
			start_arrow := Void
		end

	line_width: INTEGER
		deferred
		end

feature {EV_FIGURE_DRAWING_ROUTINES, EV_FIGURE} -- Implementation

	start_arrow: detachable EV_FIGURE_POLYGON
			-- Triangle acting as arrow on `point_a'.

	end_arrow: detachable EV_FIGURE_POLYGON
			-- Triangle acting as arrow on `point_b'.

	update_arrows
			-- Call after `line_width' changed.
		local
			s: INTEGER
		do
			s := Arrow_size + line_width
			if attached end_arrow as l_end_arrow then
				l_end_arrow.i_th_point (1).set_position (-s, -s // 2)
				l_end_arrow.i_th_point (3).set_position (-s, s // 2)
			end
			if attached start_arrow as l_start_arrow then
				l_start_arrow.i_th_point (1).set_position (-s, -s // 2)
				l_start_arrow.i_th_point (3).set_position (-s, s // 2)
			end
		end

	build_start_arrow
			-- Create `start_arrow'.
		local
			l_start_arrow: like start_arrow
		do
			create l_start_arrow
			start_arrow := l_start_arrow
			l_start_arrow.set_point_count (3)
			l_start_arrow.i_th_point (2).set_origin (start_point)
			l_start_arrow.i_th_point (1).set_origin (l_start_arrow.i_th_point (2))
			l_start_arrow.i_th_point (3).set_origin (l_start_arrow.i_th_point (2))
			update_arrows
		end

	build_end_arrow
			-- Create `end_arrow'.
		local
			l_end_arrow: like end_arrow
		do
			create l_end_arrow
			end_arrow := l_end_arrow
			l_end_arrow.set_point_count (3)
			l_end_arrow.i_th_point (2).set_origin (end_point)
			l_end_arrow.i_th_point (1).set_origin (l_end_arrow.i_th_point (2))
			l_end_arrow.i_th_point (3).set_origin (l_end_arrow.i_th_point (2))
			update_arrows
		end

	start_point: EV_RELATIVE_POINT
			-- Point where `start_arrow' is drawn.
		deferred
		end

	start_ref_point: EV_RELATIVE_POINT
			-- Point that determines angle for `start_point'.
		deferred
		end

	end_point: EV_RELATIVE_POINT
			-- Point where `end_arrow' is drawn.
		deferred
		end

	end_ref_point: EV_RELATIVE_POINT
			-- Point that determines angle for `end_point'.
		deferred
		end

	start_angle: DOUBLE
			-- Angle that line begins on relative to world.
		do
			Result := modulo (Pi + line_angle (start_point.x_abs, start_point.y_abs,
				end_point.x_abs, end_point.y_abs), 2 * Pi)
		end

	end_angle: DOUBLE
			-- Angle that line ends on relative to world.
		do
			Result := modulo (line_angle (start_point.x_abs, start_point.y_abs,
				end_point.x_abs, end_point.y_abs), 2 * Pi)
		end

note
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





