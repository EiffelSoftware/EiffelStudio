indexing
	description:
		"`line_count' lines emerging from `center_point'.%N%
		%First line is from `center_point' to `corner_point."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, star, plus"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_STAR

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create,
			bounding_box
		end

	EV_DOUBLE_POINTED_FIGURE
		rename
			point_a as center_point,
			point_b as corner_point
		undefine
			default_create
		end

create
	default_create,
	make_with_points

feature {NONE} -- Initialization

	default_create is
			-- Create with 6 lines.
		do
			line_count := 6
			Precursor {EV_ATOMIC_FIGURE}
		end

feature -- Access

	line_count: INTEGER
			-- Number of lines.

feature -- Status setting

	set_line_count (n: INTEGER) is
			-- Set `line_count' to `n'.
		require
			n_bigger_than_two: n > 2
		do
			line_count := n
		end

feature -- Implementation

	polygon_array: ARRAY [EV_COORDINATE] is
			-- Return all corner points.
		local
			n: INTEGER
			radius: INTEGER
			ang, ang_step: DOUBLE
			crd: EV_COORDINATE
		do
			from
				radius := distance (center_point.x_abs, center_point.y_abs,
					corner_point.x_abs, corner_point.y_abs)
				create Result.make (1, line_count)
				n := 1
				ang_step := 2 * Pi / line_count
				ang := line_angle (center_point.x_abs, center_point.y_abs,
					corner_point.x_abs, corner_point.y_abs)
			until
				n > line_count
			loop
				create crd.set (
					center_point.x_abs + delta_x (ang, radius),
					center_point.y_abs + delta_y (ang, radius))
				Result.put (crd, n)
				ang := ang + ang_step
				n := n + 1
			end
		ensure
			Result_correct_size: Result.count = line_count
		end

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') on this figure?
		do
			Result := point_on_polygon (x, y, polygon_array)
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			min_x, min_y, max_x, max_y, n: INTEGER
			poly: ARRAY [EV_COORDINATE]
		do
			from
				poly := polygon_array
				n := poly.lower
				min_x := poly.item (n).x
				min_y := poly.item (n).y
				max_x := min_x
				max_y := min_y
				n := n + 1
			until
				n > poly.upper
			loop
				min_x := poly.item (n).x.min (min_x)
				min_y := poly.item (n).y.min (min_y)
				max_x := poly.item (n).x.max (max_x)
				max_y := poly.item (n).y.max (max_y)
				n := n + 1
			end
			create Result.set (
				min_x, min_y,
				max_x - min_x + 1,
				max_y - min_y + 1
			)
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




end -- class EV_FIGURE_STAR

