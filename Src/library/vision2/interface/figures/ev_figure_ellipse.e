indexing
	description:
		"Biggest ellipse fitting in imaginary rectangle defined by%N%
		%`point_a' and `point_b'."
	status: "See notice at end of class."
	keywords: "figure, ellipse, circle"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_ELLIPSE

inherit
	EV_CLOSED_FIGURE

	EV_DOUBLE_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_points

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') on this figure?
		local
			m: like metrics
		do
			m := metrics
			Result := point_on_ellipse (
				x, y,
				center_x, center_y,
				radius1, radius2
			)
		end

feature -- Status report

	center: EV_COORDINATES is
			-- get the center point of the ellipse.
		do
			create Result.set (center_x, center_y)
		end

	center_x: INTEGER is
			-- The horizontal position of the center point.
		do
			Result := (point_a.x_abs + point_b.x_abs) // 2
		end

	center_y: INTEGER is
			-- The vertical position of the center point.
		do
			Result := (point_a.y_abs + point_b.y_abs) // 2
		end

	radius1: INTEGER is
			-- The horizontal component of the radius.
		do
			Result := ((point_a.x_abs - point_b.x_abs) // 2).abs
		end

	radius2: INTEGER is
			-- The vertical component of the radius.
		do
			Result := ((point_a.y_abs - point_b.y_abs) // 2).abs
		end

feature {EV_FIGURE_DRAWING_ROUTINES} -- Access

	metrics: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER] is
			-- [`x', `y', `width', `height']
		local
			ay, ax, bx, by: INTEGER
		do
			ax := point_a.x_abs
			ay := point_a.y_abs
			bx := point_b.x_abs
			by := point_b.y_abs
			Result := [
				ax,
				ay,
				(ax - bx).abs,
				(ay - by).abs
			]
		end

end -- class EV_FIGURE_ELLIPSE

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
