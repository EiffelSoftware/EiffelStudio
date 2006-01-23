indexing
	description: "[
	
						An EV_FIGURE_ELLIPTIC is defined by pa and pb
						and not rotatable. If you need a rotatable elliptic
						use a EV_FIGURE_ROTATED_ELLIPTIC but if not elliptic
						is a lot faster.
						
							pa-----------
							|			 |
							| 			 |
							|   center   |
							|			 |
							|			 |
							 ----------- pb		
							 
						radius1 is half horizontal distance between pa and pb.
						radius2 is half vertical distance between pa and pb.
						
						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_ELLIPTIC
	
inherit
	EV_MODEL_ATOMIC
		export
			{ANY} Pi
		undefine
			point_count
		redefine
			default_create,
			bounding_box
		end

	EV_MODEL_DOUBLE_POINTED
		undefine
			default_create
		end
	
feature {NONE} -- Initialization
	
	default_create is
			-- Create a EV_FIGURE_ELLIPTIC at (0,0) with no dimension.
		do
			Precursor {EV_MODEL_ATOMIC}
			create point_array.make (2)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 0)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 1)
			is_center_valid := True
		end
		
feature -- Access
	
	angle: DOUBLE is 0.0
			-- Since not rotatable.
			
	is_scalable: BOOLEAN is
			-- Elliptic is scalable.
		do
			Result := True
		end
		

	is_rotatable: BOOLEAN is 
			-- Elliptic is not rotatable.
			-- (Use a rotatable_elliptic)
		do
			Result := False
		end
			
	is_transformable: BOOLEAN is 
			-- Elliptic is not transformable.
		do
			Result := False
		end
		
	radius1: INTEGER is
			-- The horizontal radius.
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			
			Result := as_integer ((p0.x_precise - p1.x_precise) / 2).abs
		end
		
	radius2: INTEGER is
			-- The vertical radius.
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			Result := as_integer ((p0.y_precise - p1.y_precise) / 2).abs
		end
		
	point_a_x: INTEGER is
			-- x position of `point_b'.
		do
			Result := point_array.item (0).x
		end
		
	point_a_y: INTEGER is
			-- y position of `point_b'.
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

	set_radius1 (radius: INTEGER) is
			-- Set `radius1' to `radius'.
		require
			radius_positive: radius >= 0
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
			cx: DOUBLE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			cx := (p0.x_precise + p1.x_precise) / 2
			p0.set_x_precise (cx - radius)
			p1.set_x_precise (cx + radius)
			invalidate
			center_invalidate
		ensure
			set: radius1 = radius
		end
		
	set_radius2 (radius: INTEGER) is
			-- Set `radius2' to `radius'
		require
			radius_positive: radius >= 0
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
			cy: DOUBLE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			cy := (p0.y_precise + p1.y_precise) / 2
			p0.set_y_precise (cy - radius)
			p1.set_y_precise (cy + radius)
			invalidate
			center_invalidate
		ensure
			set: radius2 = radius
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

	bounding_box: EV_RECTANGLE is
			-- Smallest orthegonal rectangle `Current' fits in.
		local
			min_x, min_y, max_x, max_y, lw2, v1, v2: DOUBLE
			lx, ly, w, h: INTEGER
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
				
				lw2 := line_width / 2
				
				lx := as_integer (min_x - lw2)
				ly := as_integer (min_y - lw2)
				w := as_integer ((max_x - min_x) + lw2) + 1
				h := as_integer ((max_y - min_y) + lw2) + 1
				create Result.make (lx, ly, w, h)
				internal_bounding_box := Result.twin
			end	
		end
		
feature {NONE} -- Implementation

	set_center is
			-- Set position of the center.
		local
			l_point_array: like point_array
			pa, pb: EV_COORDINATE
		do
			l_point_array := point_array
			pa := l_point_array.item (0)
			pb := l_point_array.item (1)
			center.set_precise ((pa.x_precise + pb.x_precise) / 2, (pa.y_precise + pb.y_precise) / 2)
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




end -- class EV_MODEL_ELLIPTIC

