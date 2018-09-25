note
	description: "Same as {EV_MODEL_POLYLINE}, but with a double line."
	date: "$Date$"
	revision: "$Revision$"

class ES_DOUBLE_POLYLINE

inherit
	EV_MODEL_POLYLINE
		redefine
			default_create,
			project
		end

create
	default_create

feature {NONE} -- Creation

	default_create
			-- <Precursor>
			-- Initialize inner line object.
		do
			Precursor
			create inner_line
			inner_line.set_foreground_color (default_colors.white)
		end

feature {NONE} -- Access

	inner_line: EV_MODEL_POLYLINE
			-- Inner line to be drawn over the main one to make an effect of double line.

feature -- Output

	project (p: EV_MODEL_PROJECTION_ROUTINES)
			-- <Precursor>
		local
			width: like line_width
			inner: like inner_line
			i: like point_count
			n: like point_count
			a: EV_MODEL_POLYGON
			a1, a2: EV_COORDINATE
			x2, y2: like i_th_point_x
		do
			Precursor (p)
				-- Decide if inner line needs to be projected.
			width := line_width
			if width >= 3 then
					-- Update inner line before projection.
				inner := inner_line
					-- Update coordinates.
				n := point_count
				inner.set_point_count (n)
				from
					i := n
				invariant
					across 1 |..| n as c all
						c.item > i implies
							(i_th_point_x (c.item) = inner.i_th_point_x (c.item) and
							i_th_point_y (c.item) = inner.i_th_point_y (c.item))
					end
				until
					i <= 0
				loop
					inner.set_i_th_point_position (i, i_th_point_x (i), i_th_point_y (i))
					i := i - 1
				variant
					i
				end
					-- Set coordinate of the last point.
				a := end_arrow
				a1 := a.point_array.item (1)
				a2 := a.point_array.item (2)
				x2 := as_integer ((a1.x_precise + a2.x_precise) / 2)
				y2 := as_integer ((a1.y_precise + a2.y_precise) / 2)
				inner.set_i_th_point_position (n, x2, y2)
					-- Update inner line width.
				inner.set_line_width ((width - 1) // 2)
					-- Project inner line.
				inner.project (p)
			end
		end

end
