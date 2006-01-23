indexing
	description: "[
						The `label_group' is attached to the polyline defined
						through the `polyline_points' from 0 to count - 1.
						The `label_group' can be moved allong the polyline.
						
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_POLYLINE_LABEL

inherit		
	EV_MODEL_DOUBLE_MATH
		redefine
			default_create
		end
		
	EG_XML_STORABLE
		undefine
			default_create
		end
	
feature {NONE} -- Initialization

	default_create is
			-- Create a EG_POLYLINE_LABEL.
		do	
			create label_move_handle
			create label_group
			label_move_handle.extend (label_group)
			label_move_handle.move_actions.extend (agent on_label_move)
			label_move_handle.scale_x_actions.extend (agent on_scale)
			label_move_handle.scale_y_actions.extend (agent on_scale)
			
			set_label_line_start_and_end
			position_on_line := -10.0
			
		end
		
feature -- Status report

	is_left: BOOLEAN
		-- Is `label_group' left from line?
		-- The line "flows" from `source' to `target'. Left is therfore
		-- on the left side of the line if you look to the direction
		-- of the flow.
		
feature -- Access

	label_group: EV_MODEL_GROUP
			-- The label group moved allong the line.
			-- Fill it with your labels.
		
	line_width: INTEGER is
			-- The with of the polyline.
		deferred
		end
		
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		do
			Result := node
			Result.put_last (xml_routines.xml_node (Result, once "LABEL_POSITION", (position_on_line * 100).rounded.out))
			Result.put_last (xml_routines.xml_node (Result, once "LABEL_START_NB", point_number (label_line_start_point).out))
			Result.put_last (xml_routines.xml_node (Result, once "LABEL_END_NB", point_number (label_line_end_point).out))
			Result.put_last (xml_routines.xml_node (Result, once "IS_LEFT", boolean_representation (is_left)))
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			p, q: EV_COORDINATE
		do
			position_on_line := xml_routines.xml_integer (node, once "LABEL_POSITION") / 100
			p := polyline_points.item (xml_routines.xml_integer (node, once "LABEL_START_NB"))
			q := polyline_points.item (xml_routines.xml_integer (node, once "LABEL_END_NB"))
			label_line_start_point := p
			label_line_end_point := q
			is_left := xml_routines.xml_boolean (node, once "IS_LEFT")
		end	
		
feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			label_move_handle.move_actions.prune_all (agent on_label_move)
			label_move_handle.scale_x_actions.prune_all (agent on_scale)
			label_move_handle.scale_y_actions.prune_all (agent on_scale)
		end

	set_left (a_left: BOOLEAN) is
			-- Set `is_left' to `a_left'.
		do
			if a_left /= is_left then
				is_left := a_left
				set_label_position_on_line (label_line_start_point, label_line_end_point)
			end
		ensure
			set: is_left = a_left
		end
		
feature {NONE} -- Implementation

	label_move_handle: EV_MODEL_MOVE_HANDLE
			-- The move handle used to move the `label_group'.
			
	label_line_start_point, label_line_end_point: EV_COORDINATE
			-- The point of `label_move_handler' is situated on the segment
			-- from `label_line_start_point' to `label_line_end_point'.
			
	position_on_line: DOUBLE
			-- Position of `label_move_handle' between `label_line_start_point'
			-- and `label_line_end_point'. 0.0 is closest to `label_line_start_point'
			-- 1.0 is closest to `label_line_end_point'.

	set_label_line_start_and_end is
			-- Set `label_line_start_point' and `label_line_end_point' such that the line
			-- (`label_line_start_point',`label_line_end_point') is closest to `label_move_handle'.
		local
			l_polyline_points: like polyline_points
			cur_dist, min_dist: DOUBLE
			i, nb: INTEGER
			p, q, nearest_start, nearest_end: EV_COORDINATE
			lx, ly: INTEGER
		do
			-- find the nearest line.
			l_polyline_points := polyline_points
			from
				lx := label_move_handle.point_x
				ly := label_move_handle.point_y
				
				p := l_polyline_points.item (0)
				q := l_polyline_points.item (1)
				
				min_dist := distance_from_segment (lx, ly, p.x_precise, p.y_precise, q.x_precise, q.y_precise)
				nearest_start := p
				nearest_end := q
				p := q
				i := 2
				nb := l_polyline_points.count - 1
			until
				i > nb
			loop
				q := l_polyline_points.item (i)
				cur_dist := distance_from_segment (lx, ly, p.x_precise, p.y_precise, q.x_precise, q.y_precise)
				if  cur_dist < min_dist then
					min_dist := cur_dist
					nearest_start := p
					nearest_end := q
				end
				p := q
				i := i + 1
			end
			
			label_line_start_point := nearest_start
			label_line_end_point := nearest_end
			position_on_line := -1.0
		end
		
	set_label_position_on_line (nearest_start, nearest_end: EV_COORDINATE) is
			-- Set the `label_move_handle' position such that its point is
			-- on the segment from `nearest_start' to `nearest_end'.
		local
			new_x, new_y: INTEGER
			lx, ly: INTEGER
			d_x, d_y: DOUBLE
			m1, m2: DOUBLE
			x1, y1, x2, y2, nx, ny: DOUBLE
			
			a, b, c, d, g, h: DOUBLE
		do
			lx := label_move_handle.point_x
			ly := label_move_handle.point_y
			
			x1 := nearest_start.x_precise
			y1 := nearest_start.y_precise
			x2 := nearest_end.x_precise
			y2 := nearest_end.y_precise
			
			if position_on_line < 0.0 then
				-- nearest line is from nearest_start to nearest_end
				-- project to this line
				d_x := x2 - x1
				d_y := y2 - y1
				if d_x = 0 then
					nx := x1
					ny := ly
				elseif d_y = 0 then
					nx := lx
					ny := y1
				else
					m1 := d_y / d_x
					m2 := - (1 / m1)
					nx := (ly - y1 + m1 * x1 - m2 * lx) / (m1 - m2)
					ny := m1 * nx - m1 * x1 + y1
				end
				check
					-- For speed reasons I do not call project_to_line and has_projection.
					same_as_project: nx = project_to_line (lx, ly, nearest_start.x_precise, nearest_start.y_precise, nearest_end.x_precise, nearest_end.y_precise).double_item (1)
											and
									 ny = project_to_line (lx, ly, nearest_start.x_precise, nearest_start.y_precise, nearest_end.x_precise, nearest_end.y_precise).double_item (2)
				end
				if between (nx, x1, x2) and between (ny, y1, y2) then
					check
						has_projection: has_projection (lx, ly, nearest_start.x_precise, nearest_start.y_precise, nearest_end.x_precise, nearest_end.y_precise)
					end
					new_x := as_integer (nx)
					new_y := as_integer (ny)
				else
					-- go to nearest point
					if distance (lx, ly, x1, y1) < distance (lx, ly, x2, y2) then
						new_x := as_integer (x1)
						new_y := as_integer (y1)
					else
						new_x := as_integer (x2)
						new_y := as_integer (y2)
					end				
				end
				b := distance (x1, y1, x2, y2)
				if b = 0.0 then
					position_on_line := 0.0
				else
					position_on_line := distance (x1, y1, new_x, new_y) / b
				end
			else
				b := distance (x1, y1, x2, y2)
				if b = 0.0 or else position_on_line <= 0.0 then
					new_x := as_integer (x1)
					new_y := as_integer (y1)
				elseif position_on_line >= 1.0 then
					new_x := as_integer (x2)
					new_y := as_integer (y2)
				else
					a := b * position_on_line
					h := x2 - x1
					g := a * h / b
					d := y2 - y1
					c := a * d / b
					new_x := as_integer (x1 + g)
					new_y := as_integer (y1 + c)
				end
			end
			
			-- the label_move_handles point goes to new_x new_y
			label_move_handle.set_point_position (new_x, new_y)
			-- set the label_group to the correct side of the line			
			set_label_group_position_on_line (new_x, new_y, nearest_start, nearest_end)
		end

	set_label_group_position_on_line (new_x, new_y: DOUBLE; p, q: EV_COORDINATE) is
			-- Set `label_group' position to left or right of line from `p' to `q' depending on `is_left'.
			-- such that `label_group' does not intersect with the line.
		require
			p_not_void: p /= Void
			q_not_void: q /= Void
		local
			bbox: EV_RECTANGLE
			shift_x, shift_y: INTEGER
			w, h: INTEGER
			theta: DOUBLE
			pival: DOUBLE
		do
			theta := line_angle (p.x_precise, p.y_precise, q.x_precise, q.y_precise)
			bbox := label_group.bounding_box
			w := bbox.width + line_width
			h := bbox.height
			if is_left then
				theta := modulo (theta + pi, pi_times_two)
			end
			if theta >= 0 and theta <= pi / 4 then
				-- octant 1
				shift_x := w
			elseif theta > pi / 4 and theta <= pi_half then
				-- octant 2
				shift_x := w
				pival := (7/16) * pi
				if theta >= pival then
					shift_y := transition (0, h, (theta - pival) * (16/pi))
				end
			elseif theta > pi_half and theta <= 3*pi/4 then
				-- octant 3
				shift_x := w
				shift_y := h
			elseif theta > 3*pi/4 and theta <= pi then
				-- octant 4
				pival := (15/16) * pi
				if theta > pival then
					shift_x := transition (w, 0, (theta - pival) * (16/pi))
				else
					shift_x := w
				end
				shift_y := h - as_integer ((w - shift_x) * (p.y_precise - label_move_handle.point_y) / (p.x_precise - label_move_handle.point_x))
			elseif theta > pi and theta <= 5/4 * pi then
				-- octant 5
				shift_y := h
			elseif theta > 5/4 * pi and theta <= pi_half_times_three then
				-- octant 6
				pival := (23/16) * pi
				if theta >= pival then
					shift_y := transition (h, 0, (theta - pival) * (16/pi))
				else
					shift_y := h
				end
			elseif theta > pi_half_times_three and theta <= (7/4) * pi then
				-- octant 7
			else
				-- octant 8
				pival := (31/16) * pi
				if theta >= pival then
					shift_x := transition (0, w, (theta - pival) * (16/pi))
					shift_y := as_integer (shift_x * (p.y_precise - label_move_handle.point_y) / (p.x_precise - label_move_handle.point_x))
				end
			end
			label_group.set_point_position (label_move_handle.point_x - shift_x, label_move_handle.point_y - shift_y)
		end
		
	transition (start_value, end_value: INTEGER; progress: DOUBLE): INTEGER is
			-- Value between `start_value' and `end_value'.
		do
			Result := start_value + as_integer ((end_value - start_value) * progress)
		end

	project_to_line (ax, ay, x1, y1, x2, y2: DOUBLE): TUPLE [DOUBLE, DOUBLE] is
			-- Project point `ax' `ay' to the line [(`x1', `y1'), (`x2', `y2')].
		local
			d_x, d_y: DOUBLE
			m1, m2: DOUBLE
			nx, ny: DOUBLE
		do
			d_x := x2 - x1
			d_y := y2 - y1
			if d_x = 0 then
				Result := [x1, ay]
			elseif d_y = 0 then
				Result := [ax, y1]
			else
				m1 := d_y / d_x
				m2 := - (1 / m1)
				nx := (ay - y1 + m1 * x1 - m2 * ax) / (m1 - m2)
				ny := m1 * nx - m1 * x1 + y1
				Result := [nx, ny]
			end
		end
		
	has_projection (ax, ay, x1, y1, x2, y2: DOUBLE): BOOLEAN is
			-- Does a line perpendicular to line [(`x1', `y1), (`x2', `y2')] exist
			-- that goes through point (`ax', `ay') and intersects with the segment [(`x1', `y1), (`x2', `y2')]?
		local
			t: TUPLE [DOUBLE, DOUBLE]
			nx, ny: DOUBLE
		do
			t := project_to_line (ax, ay, x1, y1, x2, y2)
			nx := t.double_item (1)
			ny := t.double_item (2)
			Result := between (nx, x1, x2) and between (ny, y1, y2)
		end
		
	distance_from_segment (ax, ay, x1, y1, x2, y2: DOUBLE): DOUBLE is
			-- Calculate distance between (`x', `y') and (`x1', `y1')-(`x2', `y2').
			-- The line is NOT considered to be infinite.
		local
			t: TUPLE [DOUBLE, DOUBLE]
			nx, ny: DOUBLE
		do
			t := project_to_line (ax, ay, x1, y1, x2, y2)
			nx := t.double_item (1)
			ny := t.double_item (2)
			if between (nx, x1, x2) and between (ny, y1, y2) then
				Result := distance (nx, ny, ax, ay)
			else
				Result := distance (ax, ay, x1, y1).min (distance (ax, ay, x2, y2))
			end
		end
		
	on_label_move (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- `label_move_handler' was moved for `ax' `ay'.
		do
			is_left := left_from_segment (screen_x, screen_y, label_line_start_point.x_precise, label_line_start_point.y_precise, label_line_end_point.x_precise, label_line_end_point.y_precise)
			set_label_line_start_and_end
			set_label_position_on_line (label_line_start_point, label_line_end_point)
		end
		
	left_from_segment (ax, ay, x1, y1, x2, y2: DOUBLE): BOOLEAN is
			-- Is (`ax', `ay') on the left side of segment from (`x1', `y1') to (`x2', `y2')?
			-- (See `is_left' for a definition of left).
		local
			d_x, d_y: DOUBLE
			eq: DOUBLE
		do
			d_x := x2 - x1
			if d_x = 0 then
				if y1 < y2 then
					Result := ax >= x1
				else
					Result := ax < x1
				end
			else
				d_y := y2 - y1
				if d_y = 0 then
					if x1 > x2 then
						Result := ay > y1
					else
						Result := ay <= y1
					end
				else
					eq := y1 + (ax - x1) * d_y / d_x
					if x1 < x2 and y1 > y2 then
						Result := ay <= eq
					elseif x1 < x2 and y1 < y2 then
						Result := ay <= eq
					elseif x1 > x2 and y1 < y2 then
						Result := ay >= eq
					else
						Result := ay >= eq
					end
				end
			end
		end

	update is
			-- A point in `polyline_points' has changed its position.
		do
			set_label_position_on_line (label_line_start_point, label_line_end_point)
		end
		
	on_scale (scale: DOUBLE) is
			-- `label_move_handle' was scaled by user.
		do
			set_label_position_on_line (label_line_start_point, label_line_end_point)
		end
		
	point_with_position (ax, ay: INTEGER): EV_COORDINATE is
			-- Point at position `ax' `ay' or Void if none.
		local
			l_points: like polyline_points
			i, nb: INTEGER
			l_item: EV_COORDINATE
		do
			from
				l_points := polyline_points
				i := 0
				nb := l_points.count
			until
				i >= nb or else Result /= Void
			loop
				l_item ?= l_points.item (i)
				if l_item.x = ax and then l_item.y = ay then
					Result := l_item
				end
				i := i + 1
			end
		end
		
	point_number (a_point: EV_COORDINATE): INTEGER is
			-- Position in `polyline_points' of `a_point'.
		require
			a_point_not_void: a_point /= Void
		local
			l_points: like polyline_points
			i, nb: INTEGER
			l_item: EV_COORDINATE
		do
			from
				l_points := polyline_points
				i := 0
				nb := l_points.count
			until
				i >= nb or else Result /= 0
			loop
				l_item := l_points.item (i)
				if l_item = a_point then
					Result := i
				end
				i := i + 1
			end
		end
			
feature {EV_MODEL, EV_MODEL_DRAWER} -- Access

	polyline_points: SPECIAL [EV_COORDINATE] is
			-- All points of the Figure.
		deferred
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




end -- class EG_POLYLINE_LABEL

