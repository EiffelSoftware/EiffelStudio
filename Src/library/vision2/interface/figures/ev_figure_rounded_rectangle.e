indexing
	description:
		"Rectangular figures with rounded corners."
	status: "See notice at end of class"
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

	default_create is
			-- Create with `radius' 10.
		do
			radius := 10
			Precursor {EV_CLOSED_FIGURE}
		end

feature -- Access

	radius: INTEGER
			-- Size in pixels of rounded corners.

feature -- Element change

	set_radius (a_radius: INTEGER) is
			-- Assign `a_radius' to `radius'.
		require
			a_radius_non_negative: a_radius >= 0
		do
			radius := a_radius
		ensure
			radius_assigned: radius = a_radius
		end

feature -- Status report

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			Result := point_on_polygon (x, y, polygon_array)
		end

feature {EV_FIGURE_DRAWER, EV_FIGURE_POSTSCRIPT_DRAWER} -- Implementation

	polygon_array: ARRAY [EV_COORDINATES] is
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
			create Result.make (1, 12)
			Result.put (create {EV_COORDINATES}.set (ax + r, ay), 1)
			Result.put (create {EV_COORDINATES}.set (ax + ror, ay + ror), 2)
			Result.put (create {EV_COORDINATES}.set (ax, ay + r), 3)
			Result.put (create {EV_COORDINATES}.set (ax, by - r), 4)
			Result.put (create {EV_COORDINATES}.set (ax + ror, by - ror), 5)
			Result.put (create {EV_COORDINATES}.set (ax + r, by), 6)
			Result.put (create {EV_COORDINATES}.set (bx - r, by), 7)
			Result.put (create {EV_COORDINATES}.set (bx - ror, by - ror), 8)
			Result.put (create {EV_COORDINATES}.set (bx, by - r), 9)
			Result.put (create {EV_COORDINATES}.set (bx, ay + r), 10)
			Result.put (create {EV_COORDINATES}.set (bx - ror, ay + ror), 11)
			Result.put (create {EV_COORDINATES}.set (bx - r, ay), 12)
		end

	Radius_offset: DOUBLE is 0.2928932188134
			-- 1 - (sqrt (2)) / 2

invariant
	radius_non_negative: radius >= 0

end -- class EV_FIGURE_ROUNDED_RECTANGLE

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
