indexing
	description:
		"Figure that can have an arrowhead at its start or endpoint."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, line, arrow"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_ARROWED

inherit
	ANY

	EV_MODEL_DOUBLE_MATH
		export
			{NONE} all
		end

feature -- Access

	is_start_arrow: BOOLEAN
			-- Does `point_a' have an arrow?

	is_end_arrow: BOOLEAN
			-- Does `point_b' have an arrow?

	arrow_size: INTEGER
			-- Size of the arrow.

	line_width: INTEGER is
			-- Line width.
		deferred
		end

feature -- Status setting

	enable_end_arrow is
			-- Set `is_end_arrow' `True'.
		do
			is_end_arrow := True
		end

	disable_end_arrow is
			-- Set `is_end_arrow' `False'.
		do
			is_end_arrow := False
		end

	enable_start_arrow is
			-- Set `is_start_arrow' `True'.
		do
			is_start_arrow := True
		end

	disable_start_arrow is
			-- Set `is_start_arrow' `False'.
		do
			is_start_arrow := False
		end

feature -- Element change

	set_arrow_size (an_arrow_size: like arrow_size) is
			-- Set `arrow_size' to `an_arrow_size'.
		require
			an_arrow_size_positive: an_arrow_size > 0
		do
			arrow_size := an_arrow_size
		ensure
			set: arrow_size = an_arrow_size
		end

feature {EV_MODEL_DRAWING_ROUTINES, EV_MODEL} -- Implementation

	start_arrow: EV_MODEL_POLYGON is
			-- Triangle acting as arrow on `point_a'.
		local
			l_angle: DOUBLE
			p: EV_COORDINATE
		do
			if is_start_arrow then

				l_angle := start_angle
				p := start_point

				if internal_start_arrow = Void then
					create internal_start_arrow
					internal_start_arrow.set_point_count (3)
					set_arrow (internal_start_arrow, l_angle, p)
					internal_start_angle := l_angle
					internal_start_point_x := p.x_precise
					internal_start_point_y := p.y_precise
					internal_arrow_size := arrow_size
				elseif
					internal_arrow_size /= arrow_size or else
					l_angle /= internal_start_angle or else
					internal_start_point_x /= p.x_precise or else
					internal_start_point_y /= p.y_precise
				then
					set_arrow (internal_end_arrow, l_angle, p)
					internal_start_angle := l_angle
					internal_start_point_x := p.x_precise
					internal_start_point_y := p.y_precise
					internal_arrow_size := arrow_size
				end

				Result := internal_start_arrow
			else
				create Result
			end
		end

	end_arrow: EV_MODEL_POLYGON is
			-- Triangle acting as arrow on `point_b'.
		local
			l_angle: DOUBLE
			p: EV_COORDINATE
		do
			if is_end_arrow then

				l_angle := end_angle
				p := end_point

				if internal_end_arrow = Void then
					create internal_end_arrow
					internal_end_arrow.set_point_count (3)

					set_arrow (internal_end_arrow, l_angle, p)
					internal_end_angle := l_angle
					internal_end_point_x := p.x_precise
					internal_end_point_y := p.y_precise
					internal_arrow_size := arrow_size
				elseif
					internal_arrow_size /= arrow_size or else
					l_angle /= internal_end_angle or else
					internal_end_point_x /= p.x_precise or else
					internal_end_point_y /= p.y_precise
				then
					set_arrow (internal_end_arrow, l_angle, p)
					internal_end_angle := l_angle
					internal_end_point_x := p.x_precise
					internal_end_point_y := p.y_precise
					internal_arrow_size := arrow_size
				end

				Result := internal_end_arrow
			else
				create Result
			end
		end

	start_point: EV_COORDINATE is
			-- Point where `start_arrow' is drawn.
		deferred
		end

	end_point: EV_COORDINATE is
			-- Point where `end_arrow' is drawn.
		deferred
		end

feature {NONE} -- Implementation

	start_angle: DOUBLE is
			-- Angle that line begins on relative to world.
		local
			sp, ep: EV_COORDINATE
		do
			sp := start_point
			ep := end_point
			Result := line_angle (sp.x, sp.y, ep.x, ep.y)
		end

	end_angle: DOUBLE is
			-- Angle that line ends on relative to world.
		local
			sp, ep: EV_COORDINATE
		do
			sp := start_point
			ep := end_point
			Result := line_angle (ep.x, ep.y, sp.x, sp.y)
		end

	set_arrow (arrow: EV_MODEL_POLYGON; angle: DOUBLE; point: EV_COORDINATE) is
			-- Set `arrow' pointing to `point' with `angle'
		local
			s: INTEGER
			sh: DOUBLE
			cos, sin: DOUBLE
			scos,hssin: DOUBLE
			ssin,hscos: DOUBLE
			p: DOUBLE
		do
			s := Arrow_size + line_width
			cos := cosine (angle)
			sin := sine (angle)
			scos := s * cos
			ssin := s * sin
			sh := s/2
			hssin := sh * sin
			hscos := sh * cos

			p := point.x_precise
			arrow.set_i_th_point_x (1, as_integer(p))--p.truncated_to_integer)
			arrow.set_i_th_point_x (2, as_integer(p + scos - hssin))--.truncated_to_integer)
			arrow.set_i_th_point_x (3, as_integer(p + scos + hssin))--.truncated_to_integer)
			p := point.y_precise
			arrow.set_i_th_point_y (1, as_integer(p))--p.truncated_to_integer)
			arrow.set_i_th_point_y (2, as_integer(p + ssin + hscos))--.truncated_to_integer)
			arrow.set_i_th_point_y (3, as_integer(p + ssin - hscos))--.truncated_to_integer)
		end

	internal_start_arrow: EV_MODEL_POLYGON
	internal_start_angle: DOUBLE
	internal_start_point_x, internal_start_point_y: DOUBLE
			-- Values needed to speed up calculation of `start_arrow'.

	internal_end_arrow: EV_MODEL_POLYGON
	internal_end_angle: DOUBLE
	internal_end_point_x, internal_end_point_y: DOUBLE
			-- Values needed to speed up calculation of `end_arrow'.

	internal_arrow_size: INTEGER;

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




end -- class EV_MODEL_ARROWED

