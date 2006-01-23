indexing
	description:
		"Filled area's defined by any number of `points'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, polygon"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_POLYGON

inherit
	EV_CLOSED_FIGURE

	EV_MULTI_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_coordinates

feature {NONE} -- Initialization

	make_with_coordinates (coords: ARRAY [EV_COORDINATE]) is
			-- Initialize with points in `coords'.
		require
			coords_exist: coords /= Void
		local
			new_point: EV_RELATIVE_POINT
			i: INTEGER
		do
			default_create
			from
				i := coords.lower
			until
				i > coords.upper
			loop
				create new_point.make_with_position (
					coords.item (i).x,
					coords.item (i).y)
				extend_point (new_point)
				i := i + 1
			end
		end

feature -- Status report

	side_count: INTEGER is
			-- Returns number of sides this polyline has.
		do
			if points.count <= 1 then
				Result := 0
			elseif points.count = 2 then
				Result := 1
			else
				Result := points.count - 1
			end
		ensure
			Result_not_bigger_than_point_count: Result <= points.count
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') contained in this figure?
		do
			Result := point_on_polygon (x, y, point_array)
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




end -- class EV_FIGURE_POLYGON

