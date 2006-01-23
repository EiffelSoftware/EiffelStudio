indexing
	description: "[
	
						An EV_FIGURE_RECTANGLE is defined by pa and pb
						and not rotatable. If you need a rotatable rectangle
						use a EV_FIGURE_PARALLELOGRAM but if not rectangle
						is faster.
						
							pa-----------
							|			 |
							| 			 |
							|   center   |
							|			 |
							|			 |
							 ----------- pb			
						
						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_RECTANGLE
	
inherit
	EV_MODEL_CLOSED
		redefine
			default_create,
			bounding_box
		end
		
	EV_MODEL_DOUBLE_POINTED
		undefine
			default_create,
			point_count
		end
	
create
	make_rectangle,
	make_with_points,
	default_create,
	make_with_positions
	
feature {NONE} -- Initialization
	
	default_create is
			-- Create a EV_FIGURE_RECTANGLE at (0,0) with no dimension.
		do
			Precursor {EV_MODEL_CLOSED}
			create point_array.make (2)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 0)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 1)
			is_center_valid := True
		end

	make_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Create a EV_FIGURE_RECTANLGE with top left position at (`a_x', `a_y') 
			-- and `width' `a_width' and `height' `a_height'
		do
			default_create
			center.set (a_x + a_width // 2, a_y + a_width // 2)
			set_point_a_position (a_x, a_y)
			set_point_b_position (a_x + a_width, a_y + a_height)
		end
		
feature -- Access
	
	angle: DOUBLE is 0.0
			-- Since not rotatable.

	is_rotatable: BOOLEAN is False
			-- Rectangle is not rotatable.
		
	is_scalable: BOOLEAN is True
			-- Rectangle is scalable.

	is_transformable: BOOLEAN is False
			-- Rectangle is not transformable.
		
	width: INTEGER is
			-- The horizontal distance between `point_a' and `point_b'
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			
			Result := as_integer (p0.x_precise - p1.x_precise).abs
		end
		
	height: INTEGER is
			-- The vertical distance between `point_a' and `point_b'.
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			Result := as_integer (p0.y_precise - p1.y_precise).abs
		end
		
	top_left: EV_COORDINATE is
			-- position of the top left corner.
		local
			l_array: like point_array
			p0, p1: like top_left
			top, left: INTEGER
		do
			l_array := point_array
			p0 := l_array.item (0)
			p1 := l_array.item (1)
			-- Top-left coordinates of rectangle.
			left := p0.x.min (p1.x)
			top := p0.y.min (p1.y)
			create Result.set (left, top)	
		end
		
	point_a_x: INTEGER is
			-- x position of `point_a'.
		do
			Result := point_array.item (0).x
		end
		
	point_a_y: INTEGER is
			-- y position of `point_a'.
		do
			Result := point_array.item (0).y
		end
		
	point_b_x: INTEGER is
			-- x position of `point_b'.
		do
			Result := point_array.item (1).x
		end
		
	point_b_y: INTEGER is
			-- y position of `point_b'.
		do
			Result := point_array.item (1).y
		end

feature -- Element change

	set_width (a_width: INTEGER) is
			-- Set `width' to `a_width'.
		require
			a_width_positive: a_width >= 0 
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			
			if p1.x_precise < p0.x_precise then
				p0.set_x_precise (p1.x_precise + a_width)
			else
				p1.set_x_precise (p0.x_precise + a_width)
			end
			invalidate
			center_invalidate
		ensure
			width_set: width = a_width
		end
	
	set_height (a_height: INTEGER) is
			-- Set `height' to `a_height'.
		require
			a_height_positive: a_height >= 0 
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			
			if p0.y_precise < p1.y_precise then
				p1.set_y_precise (p0.y_precise + a_height)
			else
				p0.set_y_precise (p1.y_precise + a_height)
			end
			
			invalidate
			center_invalidate
		ensure
			height_set: height = a_height
		end

	set_point_a_position (ax, ay: INTEGER) is
			-- Set position of `point_a' to position of (`ax', `ay').
		do
			point_array.item (0).set_precise (ax, ay)
		
			invalidate
			center_invalidate
		end
		
	set_point_b_position (ax, ay: INTEGER) is
			-- Set position of `point_b' to position of (`ax', `ay').
		do
			point_array.item (1).set_precise (ax, ay)
			
			invalidate
			center_invalidate
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN is
			-- Is the point on (`a_x', `a_y') on this figure?
			--| Used to generate events.
		local
			l_point_area: like point_array
			p1, p0: EV_COORDINATE
		do
			l_point_area := point_array
			p0 := l_point_area.item (0)
			p1 := l_point_area.item (1)
			Result := point_on_rectangle (a_x, a_y, p0.x_precise, p0.y_precise, p1.x_precise, p1.y_precise)
		end
		
	bounding_box: EV_RECTANGLE is
			-- Is (`ax', `ay') on this figure?
		local
			min_x, min_y, max_x, max_y, lw2, v1, v2: DOUBLE
			lx, ly, w, h, lw: INTEGER
			l_point_array: like point_array
			pa, pb: EV_COORDINATE
		do
			if internal_bounding_box /= Void then
				Result := internal_bounding_box.twin
			else
				l_point_array := point_array
				pa := l_point_array.item (0)
				pb := l_point_array.item (1)
				
				v1 := pa.x_precise
				v2 := pb.x_precise
				min_x := v1.min (v2)
				max_x := v1.max (v2)
				
				v1 := pa.y_precise
				v2 := pb.y_precise
				min_y := v1.min (v2)
				max_y := v1.max (v2)
				
				check
					max_x >= min_x
					max_y >= min_y
				end
				
				lw := line_width
				lw2 := lw / 2
				
				lx := as_integer (min_x - lw2)
				ly := as_integer (min_y - lw2)
				w := as_integer ((max_x - min_x) + lw) + 2
				h := as_integer ((max_y - min_y) + lw) + 2
				create Result.make (lx, ly, w, h)
				internal_bounding_box := Result.twin
			end	
		end
		
feature {NONE} -- Implementation

	set_center is
			-- Set position of the center.
		local
			pa: like point_array
			p0, p1: EV_COORDINATE
		do
			pa := point_array
			p0 := pa.item (0)
			p1 := pa.item (1)
			
			center.set_precise ((p0.x_precise + p1.x_precise) / 2, (p0.y_precise + p1.y_precise) / 2)
			is_center_valid := True
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




end -- class EV_MODEL_RECTANGLE

