indexing
	description:
		"Facilities class for EV_FIGURE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "math"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_DOUBLE_MATH

inherit
	DOUBLE_MATH

feature -- Implementation

	distance (x1, y1, x2, y2: DOUBLE): DOUBLE is
			-- Calculate distance between (`x1', `y1') and (`x2', `y2').
		do
			Result := sqrt ((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
		end

	distance_from_line (x, y, x1, y1, x2, y2: DOUBLE): DOUBLE is
			-- Calculate distance between (`x', `y') and (`x1', `y1')-(`x2', `y2').
			-- The line is considered to be infinite.
		local
			dx, dy: DOUBLE
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
			Result := sqrt (x_dist ^ 2 + y_dist ^ 2)
		end

	line_angle (x1, y1, x2, y2: DOUBLE): DOUBLE is
			-- Return angle of line from (`x1', `y1') to (`x2', `y2') relative to world.
			-- clockwise. 0.0 is 3 o'clock.
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

	delta_x (angle: DOUBLE; length: DOUBLE): DOUBLE is
			-- Get dx component of line segment with `length' and `angle'.
		do
			Result := (cosine (angle) * length)
		end

	delta_y (angle: DOUBLE; length: DOUBLE): DOUBLE is
			-- Get dy component of line segment with `length' and `angle'.
		do
			Result := (sine (angle) * length)
		end

	point_on_line (x, y, x1, y1, x2, y2, width: DOUBLE): BOOLEAN is
			-- Is (`x', `y') on line from (`x2', `y2') to (`x1', `y1') with `width'?
		local
			t, rsq, dx, dy, dpx, dpy: DOUBLE
		do
			if x1 = x2 and y1 = y2 then
				Result := distance (x, y, y1, x1) <= (width / 2)
			elseif x1 = x2 then
				Result := (x - x1).abs < width / 2
			elseif y1 = y2 then
				Result := (y - y1).abs < width / 2
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

	point_on_segment (x, y, x1, y1, x2, y2, width: DOUBLE): BOOLEAN is
			-- Is (`x', `y') on segment [(`x2', `y2'), (`x1', `y1')] with `width'?
		local
			half_dx, half_dy, dpx, dpy: DOUBLE
		do
			if x1 = x2 and y1 = y2 then
				Result := distance (x, y, y1, x1) <= (width / 2)
			elseif (x1 - x2).abs < 3 then
				Result := between (y, y1, y2) and (x - x1).abs <= width / 2
			elseif (y1 - y2).abs < 3 then
				Result := between (x, x1, x2) and (y - y1).abs <= width / 2
			else
				half_dx := (x2 - x1) / 2
				half_dy := (y2 - y1) / 2
				dpx := x1 + half_dx - x
				dpy := y1 + half_dy - y
				Result := (dpx.abs <= half_dx.abs) and then
					(dpy.abs <= half_dy.abs) and then
					point_on_line (x, y, x1, y1, x2, y2, width)
			end
		end

	point_on_ellipse (x, y, xc, yc, r1, r2: DOUBLE): BOOLEAN  is
			-- Is (`x', `y') inside specified ellipse?
			--| With orientation 0.0.
		do
			Result := ((x - xc) / r1) ^ 2 + ((y - yc) / r2) ^ 2 <= 1
		ensure
			equals_point_on_rotated: Result = point_on_rotated_ellipse (x, y, xc, yc, r1, r2, 0.0)
		end
		
	point_on_rotated_ellipse (x, y, xc, yc, r1, r2, angle: DOUBLE): BOOLEAN is
			-- Is ('x', `y') inside specified ellipse?
			--| With orientation angle clockwise.
		local
			px, py, cos, sin: DOUBLE
		do
			px := x - xc
			py := y - yc
			cos := cosine (-angle)
			sin := sine (-angle)
			Result := ( (px * cos - py * sin) / r1) ^ 2 + ((px * sin + py * cos) / r2) ^ 2 <= 1
		end

	point_on_ellipse_boundary (x, y, xc, yc, r1, r2, width: DOUBLE): BOOLEAN  is
			-- Is (`x', `y') on specified ellipse border?
			--| With orientation 0.0.
		local
			tmp, semi_width_ratio: DOUBLE
		do
			tmp := ((x - xc) / r1) ^ 2 + ((y - yc) / r2) ^ 2
			semi_width_ratio := width / 100
			Result := tmp <= (1 + semi_width_ratio) and tmp >= (1 - semi_width_ratio)
		end
		
	point_on_rotated_ellipse_boundary (x, y, xc, yc, r1, r2, angle, width: DOUBLE): BOOLEAN is
			-- Is (`x', `y') on specified ellipse border?
			--| With orientation angle.
		local
			tmp, semi_width_ratio: DOUBLE
			px, py, cos, sin: DOUBLE
		do
			px := x - xc
			py := y - yc
			cos := cosine (angle)
			sin := sine (angle)
			tmp := ( (px * cos - py * sin) / r1) ^ 2 + ((px * sin + py * cos) / r2) ^ 2
			semi_width_ratio := width / 100
			Result := tmp <= (1 + semi_width_ratio) and tmp >= (1 - semi_width_ratio)
		end

	point_on_rectangle (x, y, x1, y1, x2, y2: DOUBLE): BOOLEAN is
			-- Is (`x', `y') inside specified box?
			--| With orientation 0.0.
		do
			Result := between (x, x1, x2) and then between (y, y1, y2)
		end

	point_on_polygon (x, y: DOUBLE; points: SPECIAL [EV_COORDINATE]): BOOLEAN is
			-- Is (`x', `y') contained in polygon with `points'?
			-- Based on code by Hanpeter van Vliet.
		local
			hits, n, i, nb, j, base: INTEGER
			y_save, rx, ry, dx, dy, min, max: DOUBLE
			s, val: DOUBLE
			pa, pb: EV_COORDINATE
		do
			if points.count <= 1 then
				Result := False
			elseif points.count = 2 then
				pa := points.item (0)
				pb := points.item (1)
				Result := point_on_segment (x, y, pa.x_precise, pa.y_precise, pb.x_precise, pb.y_precise, 6)
			else
				if all_on_horizontal_line (points) then
					min := points.item (0).x_precise
					max := min
					from
						i := 1
						nb := points.count - 1
					until
						i > nb
					loop
						val := points.item (i).x_precise
						min := min.min (val)
						max := max.max (val)
						i := i + 1
					end
					Result := point_on_segment (x, y, min, points.item (0).y_precise, max, points.item (0).y_precise, 6)
				else
					if all_on_vertical_line (points) then
						min := points.item (0).y_precise
						max := min
						from
							i := 1
							nb := points.count - 1
						until
							i > nb
						loop
							val := points.item (i).y_precise
							min := min.min (val)
							max := max.max (val)
							i := i + 1
						end
						Result := point_on_segment (x, y, points.item (0).x_precise, min, points.item (0).x_precise, max, 6)
					else
						
						base := 0
			
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
							nb := points.count - 1
						until
							n > nb
						loop
							j := (i + 1) \\ points.count
							dx := points.item (j + base).x_precise - points.item (i + base).x_precise
							dy := points.item (j + base).y_precise - points.item (i + base).y_precise
			
								-- Ignore horizontal edges completely.
							if dy /= 0 then
			
									-- Check to see if the edge intersects the
									-- horizontal halfline through (x, y).
								rx := x - points.item (i + base).x_precise
								ry := y - points.item (i + base).y_precise
			
									-- Deal with edges starting or ending the halfline.
								if points.item (j + base).y_precise = y and then points.item (j + base).x_precise >= x then
									y_save := points.item (i + base).y_precise
								end
								if points.item (i + base).y_precise = y and then points.item (i + base).x_precise >= x then
									if (y_save > y) /= (points.item (j + base).y_precise > y) then
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
				end
			end
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

	between (n, a, b: DOUBLE): BOOLEAN is
			-- Is `n' a value between `a' and `b'?
		do
			Result := n >= a.min (b) and then n <= a.max (b)
		end		
		
feature {NONE} -- Implementation
		
	all_on_vertical_line (points: SPECIAL [EV_COORDINATE]): BOOLEAN is
			-- Are all `points' an a vertical line?
			-- That is all x positions are equal
		require
			points_exists: points /= Void
		local
			i, nb: INTEGER
			p, q: INTEGER
		do
			Result := True
			nb := points.count - 1
			if nb > 0 then
				from
					i := 1
					p := points.item (0).x
				until
					i > nb or not Result
				loop
					q := points.item (i).x
					Result := p = q
					i := i + 1
					p := q
				end
			end
		end
		
	all_on_horizontal_line (points: SPECIAL [EV_COORDINATE]): BOOLEAN is
			-- Are all `points' an a vertical line?
			-- That is all y positions are equal.
		require
			points_exists: points /= Void
		local
			i, nb: INTEGER
			p, q: INTEGER
		do
			Result := True
			nb := points.count - 1
			if nb > 0 then
				from
					i := 0
					p := points.item (0).y
				until
					i > nb or not Result
				loop
					q := points.item (i).y
					Result := p = q
					i := i + 1
					p := q
				end
			end
		end
		
	as_integer (a_value: DOUBLE): INTEGER is
			-- Truncat `a_value' to INTEGER.
		do
			if a_value > 0 then
				Result := (a_value + 0.5).truncated_to_integer
			else
				Result := (a_value - 0.5).truncated_to_integer
			end
		end

	pi_half: DOUBLE is 1.57079632679489661923
					   
	pi_times_two: DOUBLE is 6.28318530717958647693 
	
	pi_half_times_three: DOUBLE is 4.71238898038468985769;

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




end -- class EV_MODEL_DOUBLE_MATH

