indexing
	description: "Facilities class for EV_FIGURE."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_MATH

inherit
	SINGLE_MATH

feature -- Implementation

	distance (x1, y1, x2, y2: INTEGER): INTEGER is
			-- Calculate the distance between (`x1', `y1') and (`x2', `y2').
		do
			Result := sqrt ((x1 - x2) ^ 2 + (y1 - y2) ^ 2).rounded
		end

	distance_from_line (x, y, x1, y1, x2, y2: INTEGER): INTEGER is
			-- Calculate the distance between (`x', `y') and (`x1', `y1')-(`x2', `y2').
			-- The line is considered to be infinite.
			--| FIXME Look at it. Doesn't work 100% yet.
			--| It's not used by the way...
		local
			dx, dy: INTEGER
			alpha, beta: REAL
			sine_theta: REAL
			x_dist, y_dist: REAL
		do
			dx := (x - x1).abs
			dy := (y - y1).abs
			alpha := arc_tangent ((y2 - y1) / (x2 - x1))
			beta := arc_tangent (dy / dx)
			sine_theta := sine (beta - alpha)
			x_dist := sine_theta * dx
			y_dist := sine_theta * dy
			Result := sqrt (x_dist ^ 2 + y_dist ^ 2).rounded
		end

	line_angle (x1, y1, x2, y2: INTEGER): REAL is
			-- Return the angle of the line.
		do
			Result := arc_tangent ((y2 - y1) / (x2 - x1))
		end

	delta_x (angle: REAL; length: INTEGER): INTEGER is
			-- Get the dx component of line segment with `length' and `angle'.
		do
			Result := (cosine (angle) * length).rounded
		end

	delta_y (angle: REAL; length: INTEGER): INTEGER is
			-- Get the dy component of line segment with `length' and `angle'.
		do
			Result := (sine (angle) * length).rounded
		end

	point_on_line (x, y, x1, y1, x2, y2, width: INTEGER): BOOLEAN is
			-- Is the point on the line with `width'?
		local
			t, rsq, dx, dy, dpx, dpy: REAL
                do
			if x1 /= x2 or else y1 /= y2 then
				dx := x2 - x1
				dy := y2 - y1
				dpx := x1 - x
				dpy := y1 - y
				t := - (dpx * dx + dpy * dy) / (dx ^ 2 + dy ^ 2)
				dpx := dpx + t * dx
				dpy := dpy + t * dy
				rsq := dpx ^ 2 + dpy ^ 2
				Result := rsq <= (width / 2) ^ 2
			else
				Result := distance (x, y, y1, x1) <= (width / 2)
			end
		end

	point_on_segment (x, y, x1, y1, x2, y2, width: INTEGER): BOOLEAN is
			-- Is the point on the line segment with `width'?
			--| FIXME The line is not cut off correctly at the ends.
                local
			half_dx, half_dy, dpx, dpy: INTEGER
                do
			half_dx := (x2 - x1) // 2
			half_dy := (y2 - y1) // 2
                        dpx := x1 + half_dx - x
                        dpy := y1 + half_dy - y
                        Result := (dpx.abs <= half_dx.abs) and then
				(dpy.abs <= half_dy.abs) and then
				point_on_line (x, y, x1, y1, x2, y2, width)
                end

	point_on_ellipse (x, y, xc, yc, r1, r2: INTEGER): BOOLEAN  is
			-- Determine whether (`x', `y') is inside the specified ellipse.
			--| With orientation 0.0.
		do
			Result := ((x - xc) / r1) ^ 2 + ((y - yc) / r2) ^ 2 <= 1
		end

	point_on_rectangle (x, y, x1, y1, x2, y2: INTEGER): BOOLEAN is
			-- Determine whether (`x', `y') is inside the specified box.
			--| With orientation 0.0.
		do
			Result := between (x, x1, x2) and then between (y, y1, y2)
		end

	point_on_polygon (x, y: INTEGER; points: ARRAY [EV_COORDINATES]): BOOLEAN is
			-- Is the point (`x', `y') contained in the polygon with `points'?
			-- Based on code by Hanpeter van Vliet.
		local
			hits, y_save, n, i, j, dx, dy, rx, ry, base: INTEGER
			s: REAL
		do
			base := points.lower
			-- Find a vertex that is not on the halfline.
			from
				i := 0
			until
				not (i < points.count and then points.item (i + base).y = y)
			loop
				i := i + 1
			end
			-- Walk the edges of the polygon.
			from
				n := 0
			until
				n >= points.count
			loop
				j := (i + 1) \\ points.count
				dx := points.item (j + base).x - points.item (i + base).x
				dy := points.item (j + base).y - points.item (i + base).y
				-- Ignore horizontal edges completely.
				if dy /= 0 then
					-- Check to see if the edge intersects the
					-- horizontal halfline through (x, y).
					rx := x - points.item (i + base).x
					ry := y - points.item (i + base).y
					-- Deal with edges starting or ending the halfline.
					if points.item (j + base).y = y and then points.item (j + base).x >= x then
						y_save := points.item (i + base).y
					end
					if points.item (i + base).y = y and then points.item (i + base).x >= x then
						if (y_save > y) /= (points.item (j + base).y > y) then
							hits := hits - 1
						end
					end
					-- Tally intersections with halfline.
					s := ry / dy
					if s >= 0.0 and then s <= 1.0 and then (s * dx) >= rx then
						hits := hits + 1
					end
				end
				i := j
				n := n + 1
			end
			-- Inside if number of intersections odd.
			Result := (hits \\ 2) /= 0
		end

	between (n, a, b: INTEGER): BOOLEAN is
			-- Is `n' a value between `a' and `b'?
		do
			Result := n >= a.min (b) and then n <= a.max (b)
		end		

end -- class EV_FIGURE_MATH
