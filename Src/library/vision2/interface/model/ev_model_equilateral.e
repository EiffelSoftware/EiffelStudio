indexing
	description: "[
	
					 co
					/ |  \
				   /  |	  \	 
				  |	  ce   |
				   \      /
				    \    /	  
					  -	
					  
				Equilateral with side_count sides the same size. ce is center_point and co is corner_point.
				ce == point_array.item (0)
				co == point_array.item (1)
				
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, equilateral, hexagon, octagon"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_EQUILATERAL

inherit
	EV_MODEL_CLOSED
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
			-- Create with 8 sides.
		do
			side_count := 8
			Precursor {EV_MODEL_CLOSED}
			create point_array.make (2)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 0)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 1)
		end

feature -- Access

	side_count: INTEGER
			-- Number of sides.
			
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
			Result := line_angle (ce.x_precise, ce.y_precise, co.x_precise, co.y_precise) - pi / 2
		end
			
feature -- Status report

	is_rotatable: BOOLEAN is True
			-- Is rotatable? (Yes)
		
	is_scalable: BOOLEAN is False
			-- Is scalable? (No)
			-- All sides must have the same length.
			-- Use EV_FIGURE_POLYGONE if you need scaling abilities.
			
	is_transformable: BOOLEAN is False
			-- Is transformable? (No)

feature -- Status setting

	set_side_count (n: INTEGER) is
			-- Assign `n' to `side_count'.
		require
			n_greater_than_two: n > 2
		do
			side_count := n
			invalidate
		ensure
			side_count_assigned: side_count = n
		end
		
feature -- Element change

	set_point_a_position (ax, ay: INTEGER) is
			-- Set position of `center_point' to position of `a_point_a'.
		do
			set_x_y (ax, ay)
		end
		
	set_point_b_position (ax, ay: INTEGER) is
			-- Set position of `corner_point' to position of `a_point_b'.
		do
			point_array.item (1).set_precise (ax, ay)
			invalidate
			center_invalidate
		end

feature -- Implementation

	polygon_array: ARRAY [EV_COORDINATE] is
			-- Absolute coordinates of all corner points.
		local
			i, nb: INTEGER
			radius: DOUBLE
			ang, ang_step: DOUBLE
			crd: EV_COORDINATE
			ce, co: EV_COORDINATE
			cex, cey, cox, coy: DOUBLE
		do
			ce := point_array.item (0)
			cex := ce.x_precise
			cey := ce.y_precise
			co := point_array.item (1)
			cox := co.x_precise
			coy := co.y_precise
			from
				radius := distance (cex, cey, cox, coy)
				create Result.make (1, side_count)
				i := 1
				nb := side_count
				ang_step := pi_times_two / side_count
				ang := line_angle (cex, cey, cox, coy)
			until
				i > nb
			loop
				create crd.make_precise (
					cex + delta_x (ang, radius),
					cey + delta_y (ang, radius))
				Result.put (crd, i)
				ang := ang + ang_step
				i := i + 1
			end
		ensure
			Result_correct_size: Result.count = side_count
		end

	position_on_figure (ax,ay: INTEGER): BOOLEAN is
			-- Is (`ax', `ay') on this figure?
		local
			i, nb: INTEGER
			radius: DOUBLE
			ang, ang_step: DOUBLE
			ce, co: EV_COORDINATE
			cex, cey, cox, coy: DOUBLE
			poly: like point_array
		do
			ce := point_array.item (0)
			cex := ce.x_precise
			cey := ce.y_precise
			co := point_array.item (1)
			cox := co.x_precise
			coy := co.y_precise
			from
				radius := distance (cex, cey, cox, coy)
				i := 0
				nb := side_count - 1
				create poly.make (side_count)
				ang_step := pi_times_two / side_count
				ang := line_angle (cex, cey, cox, coy)
				
				ang := ang + ang_step
			until
				i > nb
			loop
				poly.put (create {EV_COORDINATE}.make_precise (cex + delta_x (ang, radius), cey + delta_y (ang, radius)), i)
				ang := ang + ang_step
				i := i + 1
			end
			Result := point_on_polygon (ax, ay, poly)
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			min_x, min_y, max_x, max_y, lw2: DOUBLE
			i, nb, lw: INTEGER
			ax, ay, w, h: INTEGER
			poly: SPECIAL [EV_COORDINATE]
		do
			if internal_bounding_box /= Void then
				Result := internal_bounding_box.twin
			else
				from
					poly := polygon_array.area
					min_x := poly.item (0).x_precise
					min_y := poly.item (0).y_precise
					max_x := min_x
					max_y := min_y
					i := 1
					nb := poly.count - 1
				until
					i > nb
				loop
					min_x := poly.item (i).x_precise.min (min_x)
					min_y := poly.item (i).y_precise.min (min_y)
					max_x := poly.item (i).x_precise.max (max_x)
					max_y := poly.item (i).y_precise.max (max_y)
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
		ensure then
			Result_exists: Result /= Void
		end

feature {NONE} -- Implementation

	set_center is
			-- Set center to center.
		local
			ce: EV_COORDINATE
		do
			ce := point_array.item (0)
			center.set_precise (ce.x_precise, ce.y_precise)
			is_center_valid := True
		end

invariant
	side_count_bigger_than_two: side_count > 2

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




end -- class EV_MODEL_EQUILATERAL

