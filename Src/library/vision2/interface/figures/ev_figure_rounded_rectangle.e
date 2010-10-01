note
	description:
		"Rectangular figures with rounded corners."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, rectangle, rounded, radius"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_ROUNDED_RECTANGLE

inherit
	EV_CLOSED_FIGURE
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

	default_create
			-- Create with `radius' 10.
		do
			radius := 10
			Precursor {EV_CLOSED_FIGURE}
		end

feature -- Access

	radius: INTEGER
			-- Size in pixels of rounded corners.

feature -- Element change

	set_radius (a_radius: INTEGER)
			-- Assign `a_radius' to `radius'.
		require
			a_radius_non_negative: a_radius >= 0
		do
			radius := a_radius
		ensure
			radius_assigned: radius = a_radius
		end

feature -- Status report

	position_on_figure (x, y: INTEGER): BOOLEAN
			-- Is (`x', `y') on this figure?
		do
			Result := point_on_polygon (x, y, polygon_array)
		end

feature {EV_FIGURE_DRAWER, EV_FIGURE_POSTSCRIPT_DRAWER} -- Implementation

	polygon_array: ARRAY [EV_COORDINATE]
			-- Absolute coordinates of `Current' converted to polygon.
		local
			ax, ay, bx, by: INTEGER
			r, ror: INTEGER
		do
			if point_a.x_abs < point_b.x_abs then
				ax := point_a.x_abs
				bx := point_b.x_abs - 1
			else
				ax := point_b.x_abs - 1
				bx := point_a.x_abs
			end
			if point_a.y_abs < point_b.y_abs then
				ay := point_a.y_abs
				by := point_b.y_abs - 1
			else
				ay := point_b.y_abs - 1
				by := point_a.y_abs
			end

			r := radius
			if r * 2 > bx - ax then
				r := (bx - ax) // 2
			end
			if r * 2 > by - ay then
				r := (by - ay) // 2
			end

			ror := (r * Radius_offset).truncated_to_integer
			create Result.make_empty
			Result.force (create {EV_COORDINATE}.set (ax + r, ay), 1)
			Result.force (create {EV_COORDINATE}.set (ax + ror, ay + ror), 2)
			Result.force (create {EV_COORDINATE}.set (ax, ay + r), 3)
			Result.force (create {EV_COORDINATE}.set (ax, by - r), 4)
			Result.force (create {EV_COORDINATE}.set (ax + ror, by - ror), 5)
			Result.force (create {EV_COORDINATE}.set (ax + r, by), 6)
			Result.force (create {EV_COORDINATE}.set (bx - r, by), 7)
			Result.force (create {EV_COORDINATE}.set (bx - ror, by - ror), 8)
			Result.force (create {EV_COORDINATE}.set (bx, by - r), 9)
			Result.force (create {EV_COORDINATE}.set (bx, ay + r), 10)
			Result.force (create {EV_COORDINATE}.set (bx - ror, ay + ror), 11)
			Result.force (create {EV_COORDINATE}.set (bx - r, ay), 12)
		end

	Radius_offset: DOUBLE = 0.2928932188134
			-- 1 - (sqrt (2)) / 2

invariant
	radius_non_negative: radius >= 0

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




end -- class EV_FIGURE_ROUNDED_RECTANGLE

