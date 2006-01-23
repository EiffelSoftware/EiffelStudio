indexing
	description: "[	
								..corner.
							...     |     ...
	                     ..         |        ..
					    ..          |          ..
					   ..		 center        ..
						..			           ..
						 ..			          ..
							...		      ... 
								.........
								
						A star with line_count lines emergin from center.
						
							center == point_array.item (0)
							corner == point_array.item (1)
								
						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, star, plus"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_STAR

inherit
	EV_MODEL_ATOMIC
		undefine
			point_count
		redefine
			default_create,
			bounding_box
		end

	EV_MODEL_DOUBLE_POINTED
		rename
			point_a as center_point,
			point_a_x as center_point_x,
			point_a_y as center_point_y,
			point_b as corner_point,
			point_b_x as corner_point_x,
			point_b_y as corner_point_y
		undefine
			default_create
		end

create
	default_create,
	make_with_points,
	make_with_positions

feature {NONE} -- Initialization

	default_create is
			-- Create with 6 lines.
		local
			i, nb: INTEGER
		do
			line_count := 6
			Precursor {EV_MODEL_ATOMIC}
			create point_array.make (line_count + 1)
			from
				i := 0
				nb := line_count
			until
				i > nb
			loop
				point_array.put (create {EV_COORDINATE}.make (0, 0), i)
				i := i + 1
			end
		end

feature -- Access

	line_count: INTEGER
			-- Number of lines.
		
	corner_point_x: INTEGER is
			-- x position of `center_point'.
		do
			Result := point_array.item (1).x
		end
		
	corner_point_y: INTEGER is
			-- y position of `center_point'.
		do
			Result := point_array.item (1).y
		end
		
	center_point_x: INTEGER is
			-- x position of `center_point'.
		do
			Result := point_array.item (0).x
		end
		
	center_point_y: INTEGER is
			-- y position of `center_point'.
		do
			Result := point_array.item (0).y
		end
		
	angle: DOUBLE is
			-- Upright position.
		local
			ce, co: EV_COORDINATE
		do
			ce := point_array.item (0)
			co := point_array.item (1)
			Result := line_angle (co.x_precise, co.y_precise, ce.x_precise, ce.y_precise) - pi_half
		end

feature -- Status

	is_scalable: BOOLEAN is True
			-- Is scalable? (Yes)
			
	is_rotatable: BOOLEAN is True
			-- Is rotatable? (Yes)
			
	is_transformable: BOOLEAN is True
			-- Is transformable? (Yes)
			
feature -- Element change

	set_line_count (n: INTEGER) is
			-- Set `line_count' to `n'.
		require
			n_bigger_than_two: n > 2
		local
			old_count, i, nb: INTEGER
			new_array: like point_array
		do
			old_count := line_count
			line_count := n
			if n > old_count then
				point_array := point_array.resized_area (n + 1)
				from
					i := old_count + 1
					nb := n
				until
					i > nb
				loop
					point_array.put (create {EV_COORDINATE}, i)
					i := i + 1
				end
				set_corner_points
				invalidate
			elseif n < old_count then
				create new_array.make (n + 1)
				from
					i := 0
				until
					i > n
				loop
					new_array.put (point_array.item (i), i)
					i := i + 1
				end
				point_array := new_array
				set_corner_points
				invalidate
			end
		end
		
	set_point_a_position (ax, ay: INTEGER) is
			-- Set position of `center_point' to position of `a_point_a'
		do
			set_x_y (ax, ay)
		end
		
	set_point_b_position (ax, ay: INTEGER) is
			-- Set position of `corner_point' to postion of `a_point_b'
		do
			point_array.item (1).set_precise (ax, ay)
			set_corner_points
			invalidate
		end

feature -- Events

	position_on_figure (ax, ay: INTEGER): BOOLEAN is
			-- Is (`ax', `ay') on this figure?	
		do
			Result := point_on_polygon (ax, ay, corner_points)
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			min_x, min_y, max_x, max_y, lw2, val: DOUBLE
			i, nb, ax, ay, w, h, lw: INTEGER
			l_point_array: like point_array
			l_point: EV_COORDINATE
		do
			if internal_bounding_box /= Void then
				Result := internal_bounding_box.twin
			else
				from
					l_point_array := point_array
					l_point := l_point_array.item (1)
					min_x := l_point.x_precise
					min_y := l_point.y_precise
					max_x := min_x
					max_y := min_y
					i := 2
					nb := l_point_array.count - 1
				until
					i > nb
				loop
					l_point := l_point_array.item (i)
					val := l_point.x_precise
					min_x := min_x.min (val)
					max_x := max_x.max (val)
					val := l_point.y_precise
					min_y := min_y.min (val)
					max_y := max_y.max (val)
					i := i + 1
				end
				lw := line_width
				lw2 := lw / 2
				ax := as_integer (min_x - lw2)
				ay := as_integer (min_y - lw2)
				w := as_integer (max_x - min_x + lw) + 2
				h := as_integer (max_y - min_y + lw) + 2
				create Result.set (ax, ay, w, h)
				internal_bounding_box := Result.twin
			end
		end

feature {NONE} -- Implementation

	set_center is
			-- Set the center.
		local
			ce: EV_COORDINATE
		do
			ce := point_array.item (0)
			center.set_precise (ce.x_precise, ce.y_precise)
			is_center_valid := True
		end
		
	set_corner_points is
			-- Set position of corner points
		local
			n: INTEGER
			radius: DOUBLE
			ang, ang_step: DOUBLE
			co, ce: EV_COORDINATE
			cex, cey, cox, coy: DOUBLE
		do
			from
				co := point_array.item (1)
				ce := point_array.item (0)
				cex := ce.x_precise
				cey := ce.y_precise
				cox := co.x_precise
				coy := co.y_precise
				radius := distance (cex, cey, cox, coy)
				n := 1
				ang_step := pi_times_two / line_count
				ang := line_angle (cex, cey, cox, coy)
			until
				n > line_count
			loop
				point_array.item (n).set_precise (cex + delta_x (ang, radius), cey + delta_y (ang, radius))
				ang := ang + ang_step
				n := n + 1
			end
		end
		
	corner_points: like point_array is
			-- Corner points.
		local
			i, nb: INTEGER
			l_point_array: like point_array
		do
			create Result.make (line_count)
			from
				i := 1
				nb := line_count
				l_point_array := point_array
			until
				i > nb
			loop
				Result.put (l_point_array.item (i), i - 1)
				i := i + 1
			end
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




end -- class EV_MODEL_STAR

