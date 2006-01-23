indexing
	description:
		"Rectangular figures with rounded corners."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, rectangle, rounded, radius"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_ROUNDED_RECTANGLE

inherit
	EV_MODEL_RECTANGLE
		redefine
			set_point_a_position,
			set_point_b_position,
			recursive_transform,
			default_create,
			make_rectangle,
			set_width,
			set_height,
			position_on_figure
		end

create
	default_create,
	make_with_points,
	make_rectangle,
	make_with_positions
	
feature {NONE} -- Initialization

	default_create is
			-- Create with `radius' 20.
		local
			i: INTEGER
		do
			Precursor {EV_MODEL_RECTANGLE}
			radius := 20
			point_array := point_array.resized_area (8)
			from
				i := 2
			until
				i > 7
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
			Precursor {EV_MODEL_RECTANGLE} (a_x, a_y, a_width, a_height)
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
			Precursor {EV_MODEL_RECTANGLE} (a_width)
			set_rounded_points
		end
	
	set_height (a_height: INTEGER) is
			-- Set `height' to `a_height'.
		do
			Precursor {EV_MODEL_RECTANGLE} (a_height)
			set_rounded_points
		end

	set_point_a_position (ax, ay: INTEGER) is
			-- Set position of `point_a' to position (`ax', `ay').
		do
			Precursor {EV_MODEL_RECTANGLE} (ax, ay)
			set_rounded_points
		end
		
	set_point_b_position (ax, ay: INTEGER) is
			-- Set position of `point_b' to position (`ax', `ay').
		do
			Precursor {EV_MODEL_RECTANGLE} (ax, ay)
			set_rounded_points
		end
		
feature -- Events

	position_on_figure (ax, ay: INTEGER): BOOLEAN is
			-- Is (`ax', `ay') on this figure?
		local
			
			l_point_array: like point_array
			p0, p1, p2, p3, p4, p5: EV_COORDINATE
			p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y, p4x, p4y, p5x, p5y: INTEGER
			a_radius: INTEGER
		do	
			l_point_array := point_array
			p0 := l_point_array.item (2)
			p1 := l_point_array.item (3)
			p2 := l_point_array.item (4)
			p3 := l_point_array.item (5)
			
			p2x := p2.x
			p0y := p0.y
			p3x := p3.x - 1
			p1y := p1.y - 1

			Result := point_on_rectangle (ax, ay, p2x, p0y, p3x, p1y)
			if not Result then		
				p5 := l_point_array.item (7)
			
				p0x := p0.x
				p2y := p2.y		
				p1x := p1.x - 1
				p5y := p5.y - 1
				Result := point_on_rectangle (ax, ay, p0x, p2y, p1x, p5y)
				if not Result then
					a_radius := (p2x - p0x)
					Result := point_on_ellipse (ax, ay, p2x, p2y, a_radius, a_radius)
					if not Result then
						p3y := p3.y
						Result := point_on_ellipse (ax, ay, p3x, p3y, a_radius, a_radius)
						if not Result then
							p4 := l_point_array.item (6)
							p4x := p4.x - 1
							p4y := p4.y - 1
							Result := point_on_ellipse (ax, ay, p4x, p4y, a_radius, a_radius)
							if not Result then
								p5x := p5.x
								Result := point_on_ellipse (ax, ay, p5x, p5y, a_radius, a_radius)
							end
						end
					end
				end
			end
		end

feature {EV_MODEL_GROUP} -- Transformation
		
	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EV_MODEL_RECTANGLE} (a_transformation)
			set_rounded_points
		end
		
feature {NONE} -- Implementation

	radius_offset: DOUBLE is 0.2928932188134
			-- 1 - (sqrt (2)) / 2

	set_rounded_points is
			-- Set the points needed to discribe the rounded edges.
		local
			ax, ay, bx, by, v1, v2: DOUBLE
			r: DOUBLE
			pa, pb: EV_COORDINATE
			l_point_array: like point_array
		do
			l_point_array := point_array
			pa := l_point_array.item (0)
			pb := l_point_array.item (1)
	
			v1 := pa.x_precise
			v2 := pb.x_precise
			ax := v1.min (v2)
			bx := v1.max (v2)
			
			v1 := pa.y_precise
			v2 := pb.y_precise
			ay := v1.min (v2)
			by := v1.max (v2)

			r := radius
			if r * 2 > bx - ax then
				r := (bx - ax) / 2
			end
			if r * 2 > by - ay then
				r := (by - ay) / 2
			end
			l_point_array.item (2).set_precise (ax, ay)
			l_point_array.item (3).set_precise (bx, by)
			l_point_array.item (4).set_precise (ax + r, ay + r)
			l_point_array.item (5).set_precise (bx - r, ay + r)
			l_point_array.item (6).set_precise (bx - r, by - r)
			l_point_array.item (7).set_precise (ax + r, by - r)
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




end -- class EV_MODEL_ROUNDED_RECTANGLE

