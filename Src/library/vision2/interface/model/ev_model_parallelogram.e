indexing
	description: "[
	
						Parallelogram is defined by 4 points:
						
							p0-----------p1
							|             |
							|             |
							|    center   |
							|             |
							|             |
							p3-----------p2
							
							p0.x = point_a.x and p0.y = point_a.y
							p2.x = point_b.x and p2.y = point_b.y
							
						
						
						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_PARALLELOGRAM
	
inherit
	EV_MODEL_CLOSED
		redefine
			default_create
		end
		
	EV_MODEL_DOUBLE_POINTED
		undefine
			default_create,
			point_count
		end
	
create
	make_rectangle,
	default_create,
	make_with_points,
	make_with_positions
	
feature {NONE} -- Initialization

	default_create is
			-- Create a EV_FIGURE_PARALELLOGRAM at (0,0) with no dimension.
		do
			Precursor {EV_MODEL_CLOSED}
			create point_array.make (4)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 0)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 1)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 2)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 3)
			is_center_valid := True
		end
		

	make_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Create a EV_FIGURE_PARALELLOGRAM with top left position at (`a_x', `a_y') 
			-- and `width' `a_width' and `height' `a_height'
		require
			a_width_positive: a_width >= 0
			a_height_positive: a_height >= 0
		do
			default_create
			center.set (a_x + a_width // 2, a_y + a_width // 2)
			point_array.item (0).set (a_x, a_y)
			point_array.item (1).set (a_x + a_width, a_y)
			point_array.item (2).set (a_x + a_width, a_y + a_height)
			point_array.item (3).set (a_x, a_y + a_height)
		ensure
			x_is_center: x = a_x + a_width // 2
			y_is_center: y = a_y + a_height // 2
			width_equal_a_widht: width = a_width
			height_equal_a_height: height = a_height
		end
		
feature -- Access
	
	angle: DOUBLE is
			-- Upright position is: p1.y=p2.y>=p4.y
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
					Result := pi_half
				else
					Result := pi_half_times_three
				end
			else
				Result := line_angle (p0.x_precise, p0y, p1.x_precise, p1y)
			end
		end
		
	is_rotatable: BOOLEAN is 
			-- parallelogram is rotatable.
		do
			Result := True
		end
			
	is_scalable: BOOLEAN is
			-- parallelogram is scalable.
		do
			Result := True
		end
			
	is_transformable: BOOLEAN is 
			-- parallelogram is transformable.
		do
			Result := True
		end
		
	width: INTEGER is
			-- The `width' of the parallelogram.
			-- If you scale a parallelogram or a group that contains 
			-- the parallelogram width may be differend from the width you set
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			
			Result := as_integer (distance (p0.x_precise, p0.y_precise, p1.x_precise, p1.y_precise))
		ensure
			width_positive: width >= 0
		end
		
	height: INTEGER is
			-- The `height' of the parallelogram.
		local
			l_point_array: like point_array
			p0, p3: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p3 := l_point_array.item (3)
			Result := as_integer (distance (p0.x_precise, p0.y_precise, p3.x_precise, p3.y_precise))
		ensure
			height_positive: height >= 0
		end
		
	top_left: EV_COORDINATE is
			-- position of the top left corner.
		local
			l_array: like point_array
			p1,p2,p3,p4: like top_left
		do
			l_array := point_array
			p1 := l_array.item (0)
			p4 := l_array.item (3)
			if p1.y_precise < p4.y_precise then
				p2 := l_array.item (1)
				if p1.x_precise < p2.x_precise then
					Result := p1.twin
				else
					Result := p2.twin
				end
			else
				p3 := l_array.item (2)
				if p4.x_precise < p3.x_precise then
					Result := p4.twin
				else
					Result := p3.twin
				end
			end			
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
			Result := point_array.item (2).x
		end
		
	point_b_y: INTEGER is
			-- y position of `point_b'.
		do
			Result := point_array.item (2).y
		end

feature -- Element change

	set_width (a_width: INTEGER) is
			-- Set `width' to `a_width'.
			-- We use the theorem on intersecting lines here.
			--                                 |         |
			--    (0,0)-----------------------------------
			--       ...                       |         |
			--          ...                    |         |
			--             ...                 |         |
			--                ...              |         |
			--                 a ...           | g1      | h2
			--                      ...        |         |
			--                         ...     |         |
			--                            ...  |         |
			--     .............................         |
			--                 g2               ...      |
			--                                  b  ...   |
			--     ......................................|
			--                 h1      
			--
			--  a      is width
			--  a + b  is a_width
			--  g1     is p1.y - p0.y
			--  g2     is p1.x - p0.x
			--
			--  intersection theorem:
			--  h1 = g1 * (a + b) / a or
			--  h2 = g2 * (a + b) / a
		require
			a_width_positive: a_width >= 0 
		local
			a, g1, g2, h, k, v: DOUBLE
			l_point_array: like point_array
			p0, p1, p2: EV_COORDINATE
		do
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
			width_set: distance (point_array.item (0).x_precise, point_array.item (0).y_precise, point_array.item (1).x_precise, point_array.item (1).y_precise).rounded = a_width
		end
	
	set_height (a_height: INTEGER) is
			-- Set `height' to `a_height'.
			-- (See set_width for more informations)
		require
			a_height_positive: a_height >= 0 
		local
			a, g1, g2, h, k, v: DOUBLE
			l_point_array: like point_array
			p0, p3, p2: EV_COORDINATE
		do
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
			height_set: distance (point_array.item (0).x_precise, point_array.item (0).y_precise, point_array.item (3).x_precise, point_array.item (3).y_precise).rounded = a_height
		end

	set_point_a_position (ax, ay: INTEGER) is
			-- Set position of `point_a' to position of (`ax', `ay').
			-- 
			-- The line through (x1, y1) with slope m is given by the point-slope form:
			-- 		y - y1 = m (x - x1)
			-- The slope m of a line from (x1, y1) to (x2, y2) is defined as
			-- 		    y2 - y1
			-- 		m = --------
			--		    x2 - x1
			--
			-- the new position of p1 is at the intersection of the line_1 through
			-- p2 and p1 and the line_2 through (ax, ay) with the slope of the line from
			-- p0 to p1. That is
			--
			-- 		line_1: y - p1.y = m1 * (x - p1.x)
			-- 		line_2: y - ay   = m2 * (x - ax)
			--
			--	where m1 = (p2.y - p1.y) / (p2.x - p1.x) and m2 = (p1.y - p0.y) / (p1.x - p0.x)
			--
			-- everything but x and y is given. by line_1 - line_2 we get
			--		x = (ay - p1.y + m1 * p1.x - m2 * ax) / (m1 - m2)
			--
			-- the new position of p3 is at the intersection of the line_1 through
			-- p2 and p3 and the line_2 through (ax, ay) with the slope of the line frmo
			-- p0 to p3. That is
			--
			--		line_1: y - p3.y = m2 * (x - p3.x)
			--		line_2: y - ay   = m1 * (x - ax)
			--
			-- again we get:
			--		x = (ay - p3.y + m2 * p3.x - m1 * ax) / (m2 - m1)
			--
			-- Hint 1: We have to take care of many special cases, some are very unlikely.
			-- Hint 2: If the width or the hight becomes 0 some informations about the
			--			shape are distroyed.
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
			-- (See set_point_a_position for more informations.)
			-- for p1:
			-- 		line 1: y - p1.y = m1 * (x - p1.x)
			-- 		line 2: y - ay   = m2 * (x - ax)
			--	where m1 = (p0.y - p1.y) / (p0.x - p1.x) and m2 = (p1.y - p2.y) / (p1.x - p2.x)
			--		x = (ay - p1.y + m1 * p1.x - m2 * ax) / (m1 - m2)
			--
			-- for p3:
			--		line 1: y - p3.y = m2 * (x - p3.x)
			-- 		line 2: y - ay   = m1 * (x - ax)
			--
			--		x = (ay - p3.y + m2 * p3.x - m1 * ax) / (m2 - m1)
			--
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

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN is
			-- Is the point on (`a_x', `a_y') on this figure?
			--| Used to generate events.
		local
			l_point_area: like point_array
			p1, p2, p4, p3: EV_COORDINATE
			p1x, p1y: DOUBLE
		do
			l_point_area := point_array
			p1 := l_point_area.item (0)
			p1x := p1.x_precise
			p1y := p1.y_precise
			p2 := l_point_area.item (1)
			p4 := l_point_area.item (3)
			
			if p1y = p2.y_precise and p1x = p4.x_precise then
				p3 := l_point_area.item (2)
				Result := point_on_rectangle (a_x, a_y, p1x, p1y, p3.x_precise, p3.y_precise)
			else
				Result := point_on_polygon (a_x, a_y, point_array)
			end
		end

feature {NONE} -- Implementation

	set_center is
			-- Set the position to the center
		local
			pa: like point_array
			p0, p2: EV_COORDINATE
		do
			pa := point_array
			p0 := pa.item (0)
			p2 := pa.item (2)
			
			center.set_precise ((p0.x_precise + p2.x_precise) / 2, (p0.y_precise + p2.y_precise) / 2)
			is_center_valid := True
		end
		
invariant
	
	width_positive: width >= 0
	height_positive: height >= 0

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




end -- class EV_MODEL_PARALLELOGRAM

