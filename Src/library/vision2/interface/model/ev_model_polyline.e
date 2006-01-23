indexing
	description:
		"Sequences of lines through `point_array'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, polyline, line"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_POLYLINE

inherit
	EV_MODEL_ATOMIC
		redefine
			default_create
		end

	EV_MODEL_MULTI_POINTED
		undefine
			default_create,
			bounding_box
		end

	EV_MODEL_ARROWED
		undefine
			default_create
		redefine
			start_angle,
			end_angle
		end

create
	default_create,
	make_with_coordinates

feature {NONE} -- Initialization

	default_create is
			-- Initialize with no points.
		do
			Precursor {EV_MODEL_ATOMIC}
			create point_array.make (0)
			set_arrow_size (10)
		end

	make_with_coordinates (coords: ARRAY [EV_COORDINATE]) is
			-- Initialize with points in `coords'.
		require
			coords_exist: coords /= Void
		local
			i: INTEGER
		do
			default_create
			from
				i := coords.lower
			until
				i > coords.upper
			loop
				extend_point (coords.item (i))
				i := i + 1
			end
			set_center
		end

feature -- Access

	angle: DOUBLE is 0.0
			-- `Current' is allways in upright position.

feature -- Status report

	is_closed: BOOLEAN
			-- Should this polyline be closed?
			-- i.e. should first and last point be connected?
			
	is_rotatable: BOOLEAN is True
			-- Is rotatable? (Yes)
			
	is_scalable: BOOLEAN is True
			-- Is scalable? (Yes)
			
	is_transformable: BOOLEAN is True
			-- Is transformable? (Yes)

	line_count: INTEGER is
			-- Returns number of lines this polyline has.
		do
			if point_count <= 1 then
				Result := 0
			elseif point_count = 2 then
				Result := 1
			elseif is_closed then
				Result := point_count
			else
				Result := point_count- 1
			end
		ensure
			Result_not_bigger_than_point_count: Result <= point_count
		end

	extract_line (index: INTEGER): EV_MODEL_LINE is
			-- Create a line-object for line with `index'.
		require
			index_within_bounds: index > 0 and then index <= line_count
		do
			if is_closed and index = line_count then
				create Result.make_with_points (start_point, end_point)
			else
				create Result.make_with_points (
					point_array.item (index - 1),
					point_array.item (index))
			end
		ensure
			Result_exists: Result /= Void
		end

feature -- Status setting

	enable_closed is
			-- Set `is_closed' `True'.
		do
			is_closed := True
			invalidate
		ensure
			is_closed: is_closed
		end

	disable_closed is
			-- Set `is_closed' `False'.
		do
			is_closed := False
			invalidate
		ensure
			is_open: not is_closed
		end

feature {EV_MODEL_DRAWING_ROUTINES, EV_MODEL} -- Implementation

	start_point: EV_COORDINATE is
			-- Point where `start_arrow' is drawn.
		do
			Result := point_array.item (0)
		end

	end_point: EV_COORDINATE is
			-- Point where `end_arrow' is drawn.
		do
			Result := point_array.item (point_array.count - 1)
		end

feature -- Events

	position_on_figure (ax, ay: INTEGER): BOOLEAN is
			-- Is (`ax', `ay') on this figure? i.e. is it
			-- on any of lines of this polyline?
		local
			p: EV_COORDINATE
			i, nb: INTEGER
			l_point_array: like point_array
			px, py, qx, qy: DOUBLE
			lw: DOUBLE
		do
			if point_count <= 1 then
				Result := False
			else
				from
					l_point_array := point_array
					i := 1
					nb := l_point_array.count - 1
					p := l_point_array.item (0)
					px := p.x_precise
					py := p.y_precise
					lw := line_width.max (6)
				until
					Result or i > nb
				loop
					p := l_point_array.item (i)
					qx := p.x_precise
					qy := p.y_precise
					Result := point_on_segment (ax, ay, px, py, qx, qy, lw)
					px := qx
					py := qy
					i := i + 1
				end
				if point_count > 2 and then is_closed then
					p := l_point_array.item (0)
					Result := Result or point_on_segment (ax, ay, p.x_precise, p.y_precise, px, py, lw)
				end
			end
		end
		
feature {NONE} -- Implementation

	start_angle: DOUBLE is
			-- Angle that line begins on relative to world.
		local
			a_point, b_point: EV_COORDINATE
		do
			if point_count = 2 then
				Result := Precursor {EV_MODEL_ARROWED}
			elseif point_count < 2 then
				Result := 0
			else
				a_point := point_array.item (0)
				b_point := point_array.item (1)
				Result := line_angle (a_point.x_precise, a_point.y_precise, b_point.x_precise, b_point.y_precise)
			end
		end

	end_angle: DOUBLE is
			-- Angle that line ends on relative to world.
		local
			a_point, b_point: EV_COORDINATE
		do
			if point_count = 2 then
				Result := Precursor {EV_MODEL_ARROWED}
			elseif point_count < 2 then
				Result := 0
			else
				a_point := point_array.item (point_count - 1)
				b_point := point_array.item (point_count - 2)
				Result := line_angle (a_point.x_precise, a_point.y_precise, b_point.x_precise, b_point.y_precise)
			end
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




end -- class EV_MODEL_POLYLINE

