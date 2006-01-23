indexing
	description: "[         
						rotated elliptic is defined by 4 points:
						
							p0-----------p1
							|             |
							|             |
							|    center   |
							|             |
							|             |
							p3-----------p2
							
							p0.x = point_a.x and p0.y = point_a.y
							p2.x = point_b.x and p2.y = point_b.y
							
						radius1 is half of the distance between p0 and p1
						radius2 is half of the distance between p0 and p3
						center is in the middle of the line from p0 to p2
							  
									
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_ROTATED_ELLIPTIC
	
inherit
	EV_MODEL_ATOMIC
		export
			{ANY} Pi
		undefine
			point_count
		redefine
			default_create
		end

	EV_MODEL_DOUBLE_POINTED
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create with no dimension.
		do
			Precursor {EV_MODEL_ATOMIC}
			create point_array.make (4)
			point_array.put (create {EV_COORDINATE}.make (0,0), 0)
			point_array.put (create {EV_COORDINATE}.make (0,0), 1)
			point_array.put (create {EV_COORDINATE}.make (0,0), 2)
			point_array.put (create {EV_COORDINATE}.make (0,0), 3)
		end
		
feature -- Access
	
	angle: DOUBLE is 
			-- Rotation angle of `Current'.
		local
			pa: like point_array
			p0, p1, p3: EV_COORDINATE
			p0y, p1y: DOUBLE
		do
			pa := point_array
			p0 := pa.item (0)
			p1 := pa.item (1)
			p3 := pa.item (3)
			p0y := p0.y_precise
			p1y := p1.y_precise
			if p0y = p1y then
				if p0.x_precise <= p1.x_precise then
					Result := 0.0
				else
					Result := pi
				end
			elseif p0y = p3.y_precise then
				if p0.x_precise >= p3.x_precise then
					Result := pi / 2
				else
					Result := 3 * pi / 2
				end
			else
				Result := line_angle (p0.x_precise, p0y, p1.x_precise, p1y)
			end
		end
			
	radius1: INTEGER is
			-- Major radius.
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			
			Result := as_integer (distance (p0.x_precise, p0.y_precise, p1.x_precise, p1.y_precise) / 2)
		end

	radius2: INTEGER is
			-- Minor radius.
		local
			l_point_array: like point_array
			p0, p3: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p3 := l_point_array.item (3)
			
			Result := as_integer (distance (p0.x_precise, p0.y_precise, p3.x_precise, p3.y_precise) / 2)
		end
		
	point_a_x: INTEGER is
			-- x position of `point_a'.
		do
			Result := point_array.item (0).x
		end
		
	point_a_y: INTEGER is
			-- y position of `point_a'
		do
			Result := point_array.item (0).y
		end
		
	point_b_x: INTEGER is
			-- x position of `pint_b'.
		do
			Result := point_array.item (2).x
		end
		
	point_b_y: INTEGER is
			-- y position of `point_b'.
		do
			Result := point_array.item (2).y
		end
			
feature -- Status Report

	is_rotatable: BOOLEAN is True
			-- Is rotatable? (Yes)
			
	is_scalable: BOOLEAN is False
			-- Is scalable? (Yes)
			
	is_transformable: BOOLEAN is False
			-- Is transformable? (No)
			
feature -- Element change

	set_radius1 (radius: INTEGER) is
			-- Set `radius1' to `radius'.
			-- (See EV_FIGURE_PARALLELOGRAM for information about implementation)
		require
			radius_positive: radius >= 0
		local
			a, g1, g2, h, k, v: DOUBLE
			l_point_array: like point_array
			p0, p1, p2: EV_COORDINATE
			a_width: INTEGER
		do
			a_width := 2 * radius
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)
			
			a := distance (p0.x_precise, p0.y_precise, p1.x_precise, p1.y_precise)
			
			if a = 0.0 then
				-- width was 0
				p1.set_x_precise (p0.x_precise + a_width)
				p2.set_x_precise (l_point_array.item (3).x_precise + a_width)
			else
				g1 := p1.y_precise - p0.y_precise
				g2 := p1.x_precise - p0.x_precise
				
				h := g1 * a_width / a
				
				v := h - g1
				
				p1.set_y_precise (p0.y_precise + h)
				
				h := g2 * a_width / a
				
				k := h - g2
				
				p1.set_x_precise (p0.x_precise + h)
				
				p2.set_precise (p2.x_precise + k, p2.y_precise + v)
			end
			invalidate
			center_invalidate
		ensure
			set: (distance (point_array.item (0).x_precise, point_array.item (0).y_precise, point_array.item (1).x_precise, point_array.item (1).y_precise) / 2).rounded = radius
		end
		
	set_radius2 (radius: INTEGER) is
			-- Set `radius2' to `radius'
		require
			radius_positive: radius >= 0
		local
			a, g1, g2, h, k, v: DOUBLE
			l_point_array: like point_array
			p0, p3, p2: EV_COORDINATE
			a_height: INTEGER
		do
			a_height := 2 * radius
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p3 := l_point_array.item (3)
			p2 := l_point_array.item (2)
			
			a := distance (p0.x_precise, p0.y_precise, p3.x_precise, p3.y_precise)
			
			if a = 0.0 then
				-- height was 0
				p3.set_y_precise (p0.y_precise + a_height)
				p2.set_y_precise (l_point_array.item (2).y_precise + a_height)
			else
				g1 := p3.y_precise - p0.y_precise
				g2 := p3.x_precise - p0.x_precise
				
				h := g1 * a_height / a
				
				v := h - g1
				
				p3.set_y_precise (p0.y_precise + h)
				
				h := g2 * a_height / a
				
				k := h - g2
				
				p3.set_x_precise (p0.x_precise + h)
				
				p2.set_precise (p2.x_precise + k, p2.y_precise + v)
			end
			invalidate
			center_invalidate
		ensure
			set: (distance (point_array.item (0).x_precise, point_array.item (0).y_precise, point_array.item (3).x_precise, point_array.item (3).y_precise) / 2).rounded = radius
		end
		
	set_point_a_position (ax, ay: INTEGER) is
			-- Set position of `point_a' to (`ax', `ay').
			-- (See EV_FIGURE_PARALLELOGRAM) for more informations.)
		local
			l_point_array: like point_array
			p0, p1, p2, p3: EV_COORDINATE
			m1, m2, new_x, new_y: DOUBLE
			m1_inv, m2_inv: BOOLEAN
			p0_p1_dist, p0_p3_dist: DOUBLE
		do

			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)
			p3 := l_point_array.item (3)
			
			p0_p1_dist := p0.x_precise - p1.x_precise
			
			if p0_p1_dist < 0.1 and p0_p1_dist > -0.1 then
				-- m1 is infinite (more or less)
				m1_inv := True
			else
				m1 := (p0.y_precise - p1.y_precise) / (p0_p1_dist) 	
			end

			p0_p3_dist := p0.x_precise - p3.x_precise
			
			if p0_p3_dist < 0.1 and  p0_p3_dist > -0.1 then
				-- m2 is infinite (more or less)
				m2_inv := True
			else
				m2 := (p0.y_precise - p3.y_precise) / (p0_p3_dist)
			end
			
			if m1_inv and m2_inv then
				-- no dimension
				p1.set_y_precise (ay)
				p3.set_x_precise (ax)
			elseif m1_inv then
				
				-- calc p1 position
				new_x := ax
				new_y := m2 * (new_x - p1.x_precise) + p1.y_precise
				p1.set_precise (new_x, new_y)

				-- calc p3 position
				new_x := p3.x_precise
				new_y := m2 * (new_x - ax) + ay
				p3.set_precise (new_x, new_y)
			elseif m2_inv then
				
				-- calc p1 position
				new_x := p1.x_precise
				new_y := m1 * (new_x - ax) + ay
				p1.set_precise (new_x, new_y)
				
				-- calc p3 position
				new_x := ax
				new_y := m1 * (new_x - p3.x_precise) + p3.y_precise
				p3.set_precise (new_x, new_y)
				
			elseif m1 = m2 then
				-- its a (rotated) line
				-- its completely destroyed now
				p1.set_precise (p0.x_precise, p0.y_precise)
				p3.set_precise (p0.x_precise, p0.y_precise)
				
			else
				-- calc p3 position
				-- intersection of line through p2 with m1 and line through (ax, ay) with m2
				new_x := (ay - p2.y_precise + m1 * p2.x_precise - m2 * ax) / (m1 - m2)
				new_y := m2 * (new_x - ax) + ay
				p3.set_precise (new_x, new_y)
			
				-- calc p1 position
				-- intersection of line through p2 with m2 and line through (ax, ay) with m1
				new_x := (ay - p2.y_precise + m2 * p2.x_precise - m1 * ax) / (m2 - m1)
				new_y := m1 * (new_x - ax) + ay
				p1.set_precise (new_x, new_y)
			end

			p0.set_precise (ax, ay)

			invalidate
			center_invalidate
		end
		
	set_point_b_position (ax, ay: INTEGER) is
			-- Set position of `point_b' to position of (`ax', `ay').
			-- (See EV_FIGURE_PARALLELOGRAM for more informations)
		local
			l_point_array: like point_array
			p0, p1, p2, p3: EV_COORDINATE
			m1, m2, new_x, new_y: DOUBLE
			m1_inv, m2_inv: BOOLEAN
			p0_p1_dist, p0_p3_dist: DOUBLE
		do

			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)
			p3 := l_point_array.item (3)
			
			p0_p1_dist := p0.x_precise - p1.x_precise
			
			if p0_p1_dist < 0.1 and p0_p1_dist > -0.1 then
				-- m1 is infinite
				m1_inv := True
			else
				m1 := (p0.y_precise - p1.y_precise) / (p0_p1_dist) 	
			end

			p0_p3_dist := p0.x_precise - p3.x_precise
			
			if p0_p3_dist < 0.1 and  p0_p3_dist > -0.1 then
				-- m2 is infinite
				m2_inv := True
			else
				m2 := (p0.y_precise - p3.y_precise) / (p0_p3_dist)
			end
			
			if m1_inv and m2_inv then
				-- no dimension
				p1.set_x_precise (ax)
				p3.set_y_precise (ay)
			elseif m1_inv then
				
				-- calc p1 position
				new_x := p1.x_precise
				new_y := m2 * (new_x - ax) + ay
				p1.set_precise (new_x, new_y)

				-- calc p3 position
				new_x := ax
				new_y := m2 * (new_x - p3.x_precise) + p3.y_precise
				p3.set_precise (new_x, new_y)
			elseif m2_inv then
				
				-- calc p1 position
				new_x := ax
				new_y := m1 * (new_x - p1.x_precise) + p1.y_precise
				p1.set_precise (new_x, new_y)
				
				-- calc p3 position
				new_x := p3.x_precise
				new_y := m1 * (new_x - ax) + ay
				p3.set_precise (new_x, new_y)
				
			elseif m1 = m2 then
				-- its a (rotated) line
				-- its completely destroyed now
				p1.set_precise (p0.x_precise, p0.y_precise)
				p3.set_precise (p0.x_precise, p0.y_precise)
				
			else
				-- calc p1 position
				-- intersection of line through p0 with m1 and line through (ax, ay) with m2
				new_x := (ay - p0.y_precise + m1 * p0.x_precise - m2 * ax) / (m1 - m2)
				new_y := m2 * (new_x - ax) + ay
				p1.set_precise (new_x, new_y)
			
				-- calc p3 position
				-- intersection of line through p0 with m2 and line through (ax, ay) with m1
				new_x := (ay - p0.y_precise + m2 * p0.x_precise - m1 * ax) / (m2 - m1)
				new_y := m1 * (new_x - ax) + ay
				p3.set_precise (new_x, new_y)
			end

			p2.set_precise (ax, ay)

			invalidate
			center_invalidate
		end

feature {NONE} -- Implementation

	set_center is
			-- Set the position of the center
		local
			p0, p2: EV_COORDINATE
			l_point_array: like point_array
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p2 := l_point_array.item (2)

			center.set_precise ((p0.x_precise + p2.x_precise) / 2, (p0.y_precise + p2.y_precise) / 2)
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




end -- class EV_MODEL_ROTATED_ELLIPTIC

