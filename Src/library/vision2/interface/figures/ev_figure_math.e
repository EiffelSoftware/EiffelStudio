indexing
	description:
		"Facilities class for EV_FIGURE."
	status: "See notice at end of class"
	keywords: "math"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_MATH

inherit
	DOUBLE_MATH

feature -- Implementation

	distance (x1, y1, x2, y2: INTEGER): INTEGER is
			-- Calculate distance between (`x1', `y1') and (`x2', `y2').
		do
			Result := sqrt ((x1 - x2) ^ 2 + (y1 - y2) ^ 2).truncated_to_integer
		end

	distance_from_line (x, y, x1, y1, x2, y2: INTEGER): INTEGER is
			-- Calculate distance between (`x', `y') and (`x1', `y1')-(`x2', `y2').
			-- The line is considered to be infinite.
		local
			dx, dy: INTEGER
			alpha, beta: DOUBLE
			sine_theta: DOUBLE
			x_dist, y_dist: DOUBLE
		do
			dx := (x - x1).abs
			dy := (y - y1).abs
			alpha := arc_tangent ((y2 - y1) / (x2 - x1))
			beta := arc_tangent (dy / dx)
			sine_theta := sine (beta - alpha)
			x_dist := sine_theta * dx
			y_dist := sine_theta * dy
			Result := sqrt (x_dist ^ 2 + y_dist ^ 2).truncated_to_integer
		end

	line_angle (x1, y1, x2, y2: INTEGER): DOUBLE is
			-- Return angle of line from (`x1', `y1') to (`x2', `y2') relative to world.
		do
			if x2 = x1 then
				if y1 > y2 then
					Result := pi_half_times_three
				else
					Result := pi_half
				end
			else
				Result := arc_tangent ((y1 - y2) / (x1 - x2))
				if x1 > x2 then
					Result := Result - Pi
				end
				Result := modulo (Result, pi_times_two)
			end
		end

	delta_x (angle: DOUBLE; length: INTEGER): INTEGER is
			-- Get dx component of line segment with `length' and `angle'.
		do
			Result := (cosine (angle) * length).rounded
		end

	delta_y (angle: DOUBLE; length: INTEGER): INTEGER is
			-- Get dy component of line segment with `length' and `angle'.
		do
			Result := (sine (angle) * length).rounded
		end

	point_on_line (x, y, x1, y1, x2, y2, width: INTEGER): BOOLEAN is
			-- Is (`x', `y') on line from (`x2', `y2') to (`x1', `y1') with `width'?
		local
			t, rsq, dx, dy, dpx, dpy: DOUBLE
		do
			if x1 = x2 and y1 = y2 then
				Result := distance (x, y, y1, x1) <= (width / 2)
			elseif x1 = x2 then
				Result := (x - x1).abs < width // 2
			elseif y1 = y2 then
				Result := (y - y1).abs < width // 2
			else
				dx := x2 - x1
				dy := y2 - y1
				dpx := x1 - x
				dpy := y1 - y
				t := - (dpx * dx + dpy * dy) / (dx ^ 2 + dy ^ 2)
				dpx := dpx + t * dx
				dpy := dpy + t * dy
				rsq := dpx ^ 2 + dpy ^ 2
				Result := rsq <= (width / 2) ^ 2
			end
		end

	point_on_segment (x, y, x1, y1, x2, y2, width: INTEGER): BOOLEAN is
			-- Is (`x', `y') on segment [(`x2', `y2'), (`x1', `y1')] with `width'?
		local
			half_dx, half_dy, dpx, dpy: INTEGER
		do
			if x1 = x2 and y1 = y2 then
				Result := distance (x, y, y1, x1) <= (width / 2)
			elseif x1 = x2 then
				Result := between (y, y1, y2) and (x - x1).abs < width // 2
			elseif y1 = y2 then
				Result := between (x, x1, x2) and (y - y1).abs < width // 2
			else
				half_dx := (x2 - x1) // 2
				half_dy := (y2 - y1) // 2
				dpx := x1 + half_dx - x
				dpy := y1 + half_dy - y
				Result := (dpx.abs <= half_dx.abs) and then
					(dpy.abs <= half_dy.abs) and then
					point_on_line (x, y, x1, y1, x2, y2, width)
			end
		end

	point_on_ellipse (x, y, xc, yc, r1, r2: INTEGER): BOOLEAN  is
			-- Is (`x', `y') inside specified ellipse?
			--| With orientation 0.0.
		do
			Result := ((x - xc) / r1) ^ 2 + ((y - yc) / r2) ^ 2 <= 1
		end

	point_on_ellipse_boundary (x, y, xc, yc, r1, r2, width: INTEGER): BOOLEAN  is
			-- Is (`x', `y') on specified ellipse border?
			--| With orientation 0.0.
		local
			tmp, semi_width_ratio: DOUBLE
		do
			tmp := ((x - xc) / r1) ^ 2 + ((y - yc) / r2) ^ 2
			semi_width_ratio := width / 100
			Result := tmp <= (1 + semi_width_ratio) and tmp >= (1 - semi_width_ratio)
		end

	point_on_rectangle (x, y, x1, y1, x2, y2: INTEGER): BOOLEAN is
			-- Is (`x', `y') inside specified box?
			--| With orientation 0.0.
		do
			Result := between (x, x1, x2) and then between (y, y1, y2)
		end

	point_on_polygon (x, y: INTEGER; points: ARRAY [EV_COORDINATE]): BOOLEAN is
			-- Is (`x', `y') contained in polygon with `points'?
			-- Based on code by Hanpeter van Vliet.
		local
			hits, y_save, n, i, j, dx, dy, rx, ry, base: INTEGER
			s: DOUBLE
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

				-- Walk edges of the polygon.
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

	modulo (a, b: DOUBLE): DOUBLE is
			-- `a' modulo `b'.
			--| Should be in DOUBLE_REF.
		require
			divisible: b /= 0.0
		do
			if a >= 0.0 and a < b then
				Result := a
			elseif a >= 0.0 then
				Result := modulo (a - b, b)
			else
				Result := modulo (a + b, b)
			end
		ensure
			in_interval: Result >= 0.0 and Result < b
		end

	between (n, a, b: INTEGER): BOOLEAN is
			-- Is `n' a value between `a' and `b'?
		do
			Result := n >= a.min (b) and then n <= a.max (b)
		end		
		
	pi_half: DOUBLE is 1.57079633
	
	pi_quater: DOUBLE is 0.785398163
	
	pi_times_two: DOUBLE is 6.28318531
	
	pi_times_three: DOUBLE is 9.42477796
	
	pi_half_times_three: DOUBLE is 4.71238898

end -- class EV_FIGURE_MATH

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

