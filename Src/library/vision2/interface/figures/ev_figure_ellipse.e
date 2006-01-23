indexing
	description:
		"Biggest ellipse fitting in imaginary rectangle defined by%N%
		%`point_a' and `point_b'."
	legal: "See notice at end of class."
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

	center: EV_COORDINATE is
			-- Center point of ellipse.
		do
			create Result.set (center_x, center_y)
		end

	center_x: INTEGER is
			-- Horizontal position of center point.
		do
			Result := (point_a.x_abs + point_b.x_abs) // 2
		end

	center_y: INTEGER is
			-- Vertical position of center point.
		do
			Result := (point_a.y_abs + point_b.y_abs) // 2
		end

	radius1: INTEGER is
			-- Horizontal component of radius.
		do
			Result := ((point_a.x_abs - point_b.x_abs) // 2).abs
		end

	radius2: INTEGER is
			-- Vertical component of radius.
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
				ax.min (bx),
				ay.min (by),
				(ax - bx).abs,
				(ay - by).abs
			]
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




end -- class EV_FIGURE_ELLIPSE

