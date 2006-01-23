indexing
	description:
		"Rectangular figures with rounded corners that can be rotated. Hint: scaling will not change the radius."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, rectangle, rounded, radius"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_ROUNDED_PARALLELOGRAM

inherit
	EV_MODEL_PARALLELOGRAM
		redefine
			position_on_figure,
			default_create,
			make_rectangle,
			set_point_a_position,
			set_point_b_position,
			recursive_transform,
			set_height,
			set_width
		end

create
	default_create,
	make_with_points,
	make_rectangle,
	make_with_positions

feature {NONE} -- Initialization

	default_create is
			-- Create with `radius' 10.
		local
			i: INTEGER
		do
			Precursor {EV_MODEL_PARALLELOGRAM}
			radius := 10
			point_array := point_array.resized_area (16)
			from
				i := 4
			until
				i > 15
			loop
				point_array.put (create {EV_COORDINATE}, i)
				i := i + 1
			end
		end
		
	make_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Create a EV_FIGURE_PARALELLOGRAM with top left position at (`a_x', `a_y') 
			-- and `width' `a_width' and `height' `a_height'
		do
			default_create
			center.set (a_x + a_width // 2, a_y + a_width // 2)
			point_array.item (0).set (a_x, a_y)
			point_array.item (1).set (a_x + a_width, a_y)
			point_array.item (2).set (a_x + a_width, a_y + a_height)
			point_array.item (3).set (a_x, a_y + a_height)
			set_rounded_points
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
			set_rounded_points
			invalidate
		ensure
			radius_assigned: radius = a_radius
		end
		
	set_width (a_width: INTEGER) is
			-- Set `width' to `a_width'.
		do
			Precursor {EV_MODEL_PARALLELOGRAM} (a_width)
			set_rounded_points
		end
		
	set_height (a_height: INTEGER) is
			-- Set the lenght of the line p1 <-> p2 to a_height
		do
			Precursor {EV_MODEL_PARALLELOGRAM} (a_height)
			set_rounded_points
		end
		
	set_point_a_position (ax, ay: INTEGER) is
			-- Set position of `point_a' to position (`ax', `ay').
		do
			Precursor {EV_MODEL_PARALLELOGRAM} (ax, ay)
			set_rounded_points
		end
		
	set_point_b_position (ax, ay: INTEGER) is
			-- Set position of `point_b' to position (`ax', `ay').
		do
			Precursor {EV_MODEL_PARALLELOGRAM} (ax, ay)
			set_rounded_points
		end

feature -- Status report

	position_on_figure (ax, ay: INTEGER): BOOLEAN is
			-- Is (`ax', `ay') on this figure?
		local
			poly: like point_array
			l_point_array: like point_array
			i, nb: INTEGER
		do
			from
				create poly.make (12)
				i := 0
				l_point_array := point_array
				nb := 11
			until
				i > nb
			loop
				poly.put (l_point_array.item (i + 4), i)
				i := i + 1
			end
			Result := point_on_polygon (ax, ay, poly)
		end

feature {EV_MODEL_DRAWER} -- Implementation

	polygon_array: ARRAY [EV_COORDINATE] is
			-- Absolute coordinates of `Current' converted to polygon.
		local
			i: INTEGER
		do
			create Result.make (1,12)
			from
				i := 0
			until
				i > 11
			loop
				Result.put (point_array.item (i + 4), i + 1)
				i := i + 1
			end
		end
		
feature {EV_MODEL_GROUP} -- Transformation
		
	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EV_MODEL_PARALLELOGRAM} (a_transformation)
			set_rounded_points
		end
		
feature {NONE} -- Implementation
			
	set_rounded_points is
			-- Create the points needed to discribe the rounded edges.
			-- Thats not easy, since it should work when rotated, scaled and shared.
			-- First we rearange the points such they are always in the
			-- following order:
			--    pa -------------- pb
			--     |                |
			--    pd -------------- pc
			--
			-- Example calculation for pa and p4:
			--		a      |    b
			--	pa----------------+
			--	  ...      |      |
			--       ...   | g    |
			--     c    ...|      | h
			--           p4...    |
			--              d ... |
			--                    pb
			--
			-- we need a and g we have pa and pb.
			-- we can calculate a+b h and c+d, c is our radius.
			-- we get:
			--         g = (h * c) / (c + d)
			--         a = g * (a + b) / h
			-- p4 is therfore at position (pa.x + a, pa.y + g)
			-- p6 is calculated using the same strategy.
			--
			--    pa ------------ p4
			--    |   
			--    |    p5
			--    |
			--    |
			--    p6
			--
			-- now, p5 is at the midpoint of the line from pa to the
			-- midpoint of the line from p4 to p6:
			--
			-- midpointp4p6: (p4.x / 2 + p6.x / 2, p4.y / 2 + p6.y / 2)
			-- p5: (pa.x / 2 + midpointp4p6.x / 2, pa.y / 2 + midpointp4p6.y)
			-- ---> p5: (pa.x / 2 + p4.x / 4 + p6.x / 4, pa.y / 2 + p4.y / 4 + p6.y / 4)
			-- That should do it!
		local
			pa, pb, pc, pd, p1, p2: EV_COORDINATE
			l_point_array: like point_array
			
		do
			l_point_array := point_array
				
			-- rearange points
			if l_point_array.item (0).x_precise <= l_point_array.item (1).x_precise then
				-- p0 and p3 are left
				if l_point_array.item (0).y_precise <= l_point_array.item (3).y_precise then
					-- p0 is on top of p3
					pa := l_point_array.item (0)
					pb := l_point_array.item (1)
					pc := l_point_array.item (2)
					pd := l_point_array.item (3)
				else
					pa := l_point_array.item (3)
					pb := l_point_array.item (2)
					pc := l_point_array.item (1)
					pd := l_point_array.item (0)
				end
			else
				if l_point_array.item (0).y_precise <= l_point_array.item (3).y_precise then
					-- p0 is on top of p3
					pa := l_point_array.item (1)
					pb := l_point_array.item (0)
					pc := l_point_array.item (3)
					pd := l_point_array.item (2)
				else
					pa := l_point_array.item (2)
					pb := l_point_array.item (3)
					pc := l_point_array.item (0)
					pd := l_point_array.item (1)
				end
			end
			
			-- set rounded points by pa
			p1 := l_point_array.item (4)
			set_rounded_point_on_line (pa, pb, p1)
			p2 := l_point_array.item (6)
			set_rounded_point_on_line (pa, pd, p2)
			
			l_point_array.item (5).set_precise (pa.x_precise / 2 + p1.x_precise / 4 + p2.x_precise / 4,
					 						    pa.y_precise / 2 + p1.y_precise / 4 + p2.y_precise / 4)
					 						    
			-- set rounded points by pd
			p1 := l_point_array.item (7)
			set_rounded_point_on_line (pd, pa, p1)
			p2 := l_point_array.item (9)
			set_rounded_point_on_line (pd, pc, p2)
			
			l_point_array.item (8).set_precise (pd.x_precise / 2 + p1.x_precise / 4 + p2.x_precise / 4,
					 						    pd.y_precise / 2 + p1.y_precise / 4 + p2.y_precise / 4)
			
			-- set rounded points by pc
			p1 := l_point_array.item (10)
			set_rounded_point_on_line (pc, pd, p1)
			p2 := l_point_array.item (12)
			set_rounded_point_on_line (pc, pb, p2)
			
			l_point_array.item (11).set_precise (pc.x_precise / 2 + p1.x_precise / 4 + p2.x_precise / 4,
					 						     pc.y_precise / 2 + p1.y_precise / 4 + p2.y_precise / 4)
			
			-- set rounded points by pb
			p1 := l_point_array.item (13)
			set_rounded_point_on_line (pb, pc, p1)
			p2 := l_point_array.item (15)
			set_rounded_point_on_line (pb, pa, p2)
			
			l_point_array.item (14).set_precise (pb.x_precise / 2 + p1.x_precise / 4 + p2.x_precise / 4,
					 						     pb.y_precise / 2 + p1.y_precise / 4 + p2.y_precise / 4)
		end
		
	set_rounded_point_on_line (pa, pb, p: EV_COORDINATE) is
			-- Set rounded point `p' lieing on the line from `pa' to `pb'.
			-- (See set_rounded_points for more informations).
		local
			a, g, h, cd, ab, r: DOUBLE
		do
			ab := pb.x_precise - pa.x_precise
			h := pb.y_precise - pa.y_precise
			cd := sqrt (ab ^ 2 + h ^ 2)
			if cd / 2 < radius then
				r := cd / 2
			else
				r := radius
			end
			if r > 0 and h /= 0 then	
				g := (h * r) / cd
				a := g * ab / h
			elseif r > 0 then
				g := 0
				if ab < 0 then			
					a := -r	
				else
					a := r
				end
			else
				a := 0
				g := 0
			end
			p.set_precise (pa.x_precise + a, pa.y_precise + g)
			check
				(r ^ 2).rounded = ((p.x_precise - pa.x_precise) ^ 2 + (p.y_precise - pa.y_precise) ^ 2).rounded
			end
		end

invariant
	radius_non_negative: radius >= 0

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




end -- class EV_MODEL_ROUNDED_PARALLELOGRAM

