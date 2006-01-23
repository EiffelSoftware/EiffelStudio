indexing
	description: "[

					A polyline connecting source and target. The user can
					add new points by clicking on the line and can move
					points on the line around.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_POLYLINE_LINK_FIGURE

inherit
	EG_LINK_FIGURE
		redefine
			default_create,
			initialize,
			xml_element,
			xml_node_name,
			set_with_xml_element,
			recycle
		end

create {EG_POLYLINE_LINK_FIGURE}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create a EG_POLYLINE_LINK_FIGURE without dimension.
		do
			Precursor {EG_LINK_FIGURE}
			create edge_move_handlers.make (0)
			create line
			line.extend_point (create {EV_COORDINATE})
			line.extend_point (create {EV_COORDINATE})
			extend (line)

			disable_moving
			disable_rotating
			disable_scaling

			reflexive_radius := 50
		end

	initialize is
			-- Initialize.
		do
			Precursor {EG_LINK_FIGURE}
			if model.is_reflexive then
				line.set_point_count (4)
			else
				line.pointer_button_press_actions.extend (agent pointer_button_pressed_on_a_line)
				line.set_pointer_style (new_edge_cursor)
			end
			if model.is_directed then
				line.enable_end_arrow
			end
		end

feature -- Access

	start_point_x: INTEGER is
			--
		do
			Result := line.point_array.item (0).x
		end

	start_point_y: INTEGER is
			--
		do
			Result := line.point_array.item (0).y
		end

	end_point_x: INTEGER is
			--
		do
			Result := line.point_array.item (line.point_array.count - 1).x
		end

	end_point_y: INTEGER is
			--
		do
			Result := line.point_array.item (line.point_array.count - 1).y
		end

	i_th_point_x (i: INTEGER): INTEGER is
			-- x position of `i'-th point.
		do
			Result := line.i_th_point_x (i) --point_array.item (i).x
		end

	i_th_point_y (i: INTEGER): INTEGER is
			-- y position of `i'-th point.
		do
			Result := line.i_th_point_y (i) --point_array.item (i).y
		end

	line_width: INTEGER is
			--
		do
			Result := line.line_width
		end

	edges_count: INTEGER is
			--
		do
			Result := edge_move_handlers.count
		end

	foreground_color: EV_COLOR is
			--
		do
			Result := line.foreground_color
		end

	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		local
			edge_xml_element, edges: XM_ELEMENT
			l_points: like point_array
			i, nb: INTEGER
			l_item: EV_COORDINATE
			l_x_pos_string: STRING
			l_y_pos_string: STRING
			l_xml_routines: like xml_routines
			l_xml_namespace: like xml_namespace
			l_foreground_color: like foreground_color
		do
			l_foreground_color := foreground_color
			l_x_pos_string := x_pos_string
			l_y_pos_string := y_pos_string
			l_xml_routines := xml_routines
			l_xml_namespace := xml_namespace
			Result := Precursor {EG_LINK_FIGURE} (node)
			create edges.make (Result, once "EDGES", xml_namespace)
			from
				l_points := line.point_array
				i := 1
				nb := l_points.count - 1
			until
				i >= nb
			loop
				l_item := l_points.item (i)
				create edge_xml_element.make (edges, edge_string, l_xml_namespace)
				edge_xml_element.put_last (l_xml_routines.xml_node (edge_xml_element, l_x_pos_string, l_item.x.out))
				edge_xml_element.put_last (l_xml_routines.xml_node (edge_xml_element, l_y_pos_string, l_item.y.out))
				edges.put_last (edge_xml_element)
				i := i + 1
			end
			Result.put_last (edges)
			Result.put_last (l_xml_routines.xml_node (Result, line_width_string, line_width.out))
			Result.put_last (l_xml_routines.xml_node (Result, line_color_string,
				l_foreground_color.red_8_bit.out + ";" +
				l_foreground_color.green_8_bit.out + ";" +
				l_foreground_color.blue_8_bit.out))
		end

	edge_string: STRING is "EDGE"
	x_pos_string: STRING is "X_POS"
	y_pos_string: STRING is "Y_POS"
	line_width_string: STRING is "LINE_WIDTH"
	line_color_string: STRING is "LINE_COLOR"

	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			edges, l_item: XM_ELEMENT
			l_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			ax, ay: INTEGER
			l_x_pos_string, l_y_pos_string: STRING
			l_xml_routines: like xml_routines
			l_edges_count: INTEGER
		do
			Precursor {EG_LINK_FIGURE} (node)
			l_x_pos_string := x_pos_string
			l_y_pos_string := y_pos_string
			l_xml_routines := xml_routines

			reset
			edges ?= node.item_for_iteration
			node.forth
			l_cursor := edges.new_cursor
			l_cursor.start
			line.point_array.item (0).set (source.port_x, source.port_y)

			if is_reflexive then
				if not l_cursor.after then
					l_item ?= l_cursor.item
					l_item.start
					ax := l_xml_routines.xml_integer (l_item, l_x_pos_string)
					ay := l_xml_routines.xml_integer (l_item, l_y_pos_string)
					line.point_array.item (1).set (ax, ay)

					l_cursor.forth
					l_item ?= l_cursor.item
					l_item.start
					ax := l_xml_routines.xml_integer (l_item, l_x_pos_string)
					ay := l_xml_routines.xml_integer (l_item, l_y_pos_string)
					line.point_array.item (2).set (ax, ay)
				end
			else
				from
				until
					l_cursor.after
				loop
					l_item ?= l_cursor.item
					l_item.start
					l_edges_count := edges_count
					add_point_between (l_edges_count + 1, l_edges_count + 2)
					ax := l_xml_routines.xml_integer (l_item, l_x_pos_string)
					ay := l_xml_routines.xml_integer (l_item, l_y_pos_string)
					set_i_th_point_position (l_edges_count + 1, ax, ay)
					l_cursor.forth
				end
			end

			line.point_array.item (line.point_array.count - 1).set (target.port_x, target.port_y)

			set_line_width (l_xml_routines.xml_integer (node, once "LINE_WIDTH"))
			set_foreground_color (l_xml_routines.xml_color (node, once "LINE_COLOR"))
		end

	xml_node_name: STRING is
			-- Name of the node returned by `xml_element'.
		do
			Result := "EG_POLYLINE_LINK_FIGURE"
		end

feature -- Status report

	is_start_arrow: BOOLEAN is
			--
		do
			Result := line.is_start_arrow
		end

	is_end_arrow: BOOLEAN is
			--
		do
			Result := line.is_end_arrow
		end

feature -- Status settings

	enable_end_arrow is
			-- Set `is_end_arrow' `True'.
		do
			line.enable_end_arrow
			request_update
		end

	enable_start_arrow is
			-- Set `is_start_arrow' `True'.
		do
			line.enable_start_arrow
			request_update
		end

feature -- Element change

	recycle is
			-- Free `Current's recources.
		do
			Precursor {EG_LINK_FIGURE}
			line.pointer_button_press_actions.prune_all (agent pointer_button_pressed_on_a_line)
		end

	set_line_width (a_line_width: like line_width) is
			-- Set `line_width' to `a_line_width'.
		require
			a_line_width_positive: a_line_width > 0
		do
			line.set_line_width (a_line_width)
			request_update
		ensure
			set: line_width = a_line_width
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Set `foreground_color' to `a_color'.
		require
			a_color_not_void: a_color /= Void
		do
			line.set_foreground_color (a_color)
			request_update
		ensure
			set: foreground_color = a_color
		end

	set_i_th_point_position (i: INTEGER; ax, ay: INTEGER) is
			-- Set position of `i'-th point to (`ax', `ay').
		require
			valid_index: i > 1 and i < edges_count + 2
		do
			line.set_i_th_point_position (i, ax, ay)
			edge_move_handlers.i_th (i - 1).set_point_position (ax, ay)
			request_update
		ensure
			set: i_th_point_x (i) = ax and i_th_point_y (i) = ay
		end

	add_point_between (i, j: INTEGER) is
			-- Add a point between `i'-th and `j'-th point.
		require
			j_equals_i_plus_one: j = i + 1
			in_range: i >= 1 and j <= edges_count + 2
		local
			l_point_array: like point_array
			n: INTEGER
			mh: EG_EDGE
			new_x, new_y: INTEGER
			new_point: EV_COORDINATE
		do
			line.set_point_count (line.point_count + 1)
			l_point_array := line.point_array
			from
				n := l_point_array.count - 1
			until
				n < j
			loop
				l_point_array.put (l_point_array.item (n - 1), n)
				n := n - 1
			end
			check
				j_th_equals_j_plus_one_th: l_point_array.item (j) = l_point_array.item (j - 1)
			end

			new_x := as_integer (line.i_th_point_x (i) / 2 + line.i_th_point_x (j) / 2)
			new_y := as_integer (line.i_th_point_y (i) / 2 + line.i_th_point_y (j) / 2)

			create new_point.make (new_x, new_y)
			l_point_array.put (new_point , j - 1)

			create mh.make (Current)
			mh.set_point_position (new_x, new_y)
			mh.set_corresponding_point (new_point)
			if edge_move_handlers.count = 0 then
				edge_move_handlers.extend (mh)
			elseif i = 1 then
				edge_move_handlers.put_front (mh)
			else
				edge_move_handlers.go_i_th (i - 1)
				edge_move_handlers.put_right (mh)
			end
			mh.move_actions.extend (agent edge_moved (new_point, ?, ?, ?, ?, ?, ?, ?))
			mh.start_actions.extend (agent edge_start (mh))
			mh.end_actions.extend (agent edge_end (mh))
			extend (mh)
			invalidate
			request_update
		ensure
			one_added: old line.point_count + 1 = line.point_count
			j_now_j_plus_one: old (line).i_th_point_x (j) = line.i_th_point_x (j + 1) and old (line).i_th_point_y (j) = line.i_th_point_y (j + 1)			j_th_edge_move_handler_at_j_th_x_position: edge_move_handlers.i_th (i).point_x = i_th_point_x (i + 1)
			j_th_edge_move_handler_at_j_th_y_position: edge_move_handlers.i_th (i).point_y = i_th_point_y (i + 1)
		end

	remove_i_th_point (i: INTEGER) is
			-- Remove `i'-th point.
		require
			valid_index: i > 1 and i < edges_count + 2
		local
			l_point_array: like point_array
			n, m, nb: INTEGER
			l_item: EG_EDGE
		do
			l_point_array := line.point_array
			from
				n := 0
				m := 0
				nb := l_point_array.count
			until
				n >= nb
			loop
				if n /= i - 1 then
					l_point_array.put (l_point_array.item (n), m)
					m := m + 1
				end
				n := n + 1
			end
			line.set_point_count (line.point_count - 1)
			-- remove the handle
			edge_move_handlers.go_i_th (i - 1)
			l_item := edge_move_handlers.item
			edge_move_handlers.remove
			prune_all (l_item)
			request_update
		ensure
			one_point_less: old (line).point_count = line.point_count + 1
			one_edge_move_hadler_less: old (edge_move_handlers).count = edge_move_handlers.count + 1
		end

	reset is
			-- Remove all edges.
		local
			last_point: EV_COORDINATE
		do
			if not is_reflexive then
				from
					edge_move_handlers.start
				until
					edge_move_handlers.after
				loop
					start
					search (edge_move_handlers.item)
					if not exhausted then
						remove
					end
					edge_move_handlers.forth
				end
				edge_move_handlers.wipe_out
				last_point := line.point_array.item (line.point_array.count - 1)
				line.set_point_count (1)
				line.extend_point (last_point)
				line.point_array.put (last_point, line.point_array.count - 1)
				request_update
			end
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update is
			-- Some properties may have changed.
		local
			nx, ny: INTEGER
		do
			if source /= Void and then target /= Void then
				if not model.is_reflexive then
					if edge_move_handlers.count = 0 then
						set_end_and_start_point_to_edge
					else
						set_start_point_to_edge
						set_end_point_to_edge
					end
				else
					nx := source.port_x
					ny := source.port_y
					if nx /= line.i_th_point_x (1) or else ny /= line.i_th_point_y (1) then
						line.set_i_th_point_position (1, nx, ny)
						line.set_i_th_point_position (line.point_count, nx, ny)
						line.set_i_th_point_position (2, nx + 150, ny - 50)
						line.set_i_th_point_position (3, nx + 150, ny + 50)
						set_start_point_to_edge
						set_end_point_to_edge
						line.set_i_th_point_position (2, line.i_th_point_x (1) + reflexive_radius, line.i_th_point_y (1) - as_integer (reflexive_radius / 3))
						line.set_i_th_point_position (3, line.i_th_point_x (4) + reflexive_radius, line.i_th_point_y (4) + as_integer (reflexive_radius / 3))
					end
				end
				invalidate
				center_invalidate
			end
			is_update_required := False
		end

	reflexive_radius: INTEGER
			-- Radius of reflexive link.

feature {NONE} -- Implementation

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		do
			if is_selected /= an_is_selected then
				is_selected := an_is_selected
				if is_selected then
					line.set_line_width (line.line_width * 2)
				else
					line.set_line_width (line.line_width // 2)
				end
			end
		end

	edge_move_handlers: ARRAYED_LIST [EG_EDGE]
			-- Move handlers for the edges of the polyline.
			-- start_point and end_point have no move_handlers.

	edge_moved (a_point: EV_COORDINATE; ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- `a_point' was moved for `ax', `ay'.
		do
			a_point.set_precise (a_point.x_precise + ax, a_point.y_precise + ay)
			request_update
		end

	edge_start (an_edge: EG_EDGE) is
			-- User starts to move `an_edge'.
		require
			an_edge_not_void: an_edge /= Void
		do
		end

	edge_end (an_edge: EG_EDGE) is
			-- User ends to move `an_edge'.
		require
			an_edge_not_void: an_edge /= Void
		do
		end

	set_start_point_to_edge is
			-- Set the start point such that it is element of the edge of the source figure.
		local
			an_angle: DOUBLE
			l_pa: like point_array
			p1: EV_COORDINATE
		do
			l_pa := line.point_array
			p1 := l_pa.item (1)

			an_angle := line_angle (source.port_x, source.port_y, p1.x_precise, p1.y_precise)
			source.update_edge_point (l_pa.item (0), an_angle)
		end

	set_end_point_to_edge is
			-- Set the end point such that it is element of the edge of the target figure.
		local
			an_angle: DOUBLE
			l_count: INTEGER
			l_pa: like point_array
			p: EV_COORDINATE
		do
			l_pa := line.point_array
			l_count := l_pa.count
			p := l_pa.item (l_count - 2)
			an_angle := line_angle (target.port_x, target.port_y, p.x_precise, p.y_precise)
			target.update_edge_point (l_pa.item (l_count - 1), an_angle)
		end

	set_end_and_start_point_to_edge is
			-- Set end and start point on the edge of source and target.
		require
			no_edges: edges_count = 0
		local
			an_angle: DOUBLE
			l_point_array: like point_array
		do
			l_point_array := line.point_array
			an_angle := line_angle (source.port_x, source.port_y, target.port_x, target.port_y)
			source.update_edge_point (l_point_array.item (0), an_angle)
			an_angle := pi + an_angle
			target.update_edge_point (l_point_array.item (1), an_angle)
		end

	pointer_button_pressed_on_a_line (ax, ay, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- User pressed on `line'.
		local
			i, nb: INTEGER
			l_point_array: like point_array
			point_found: BOOLEAN
			lw: INTEGER
			p, q: EV_COORDINATE
			new_handler: EG_EDGE
		do
			if button = 1 and then not is_on_edge (ax, ay) and then source /= target then
				from
					l_point_array := line.point_array
					point_found := False
					i := 0
					nb := l_point_array.count - 2
					lw := line_width.max (6)
				until
					point_found or else i > nb
				loop
					p := l_point_array.item (i)
					q := l_point_array.item (i + 1)
					point_found := point_on_segment (ax, ay, p.x_precise, p.y_precise, q.x_precise, q.y_precise, lw)
					i := i + 1
				end
				if point_found then
					add_point_between (i, i + 1)
					new_handler := edge_move_handlers.i_th (i)
					set_i_th_point_position (i + 1, ax, ay)
					new_handler.show
					new_handler.on_start_resizing (ax, ay, button, x_tilt, y_tilt, pressure, screen_x, screen_y)
					check
						new_handle_at_ax_ay: edge_move_handlers.i_th (i).point_x = ax and edge_move_handlers.i_th (i).point_y = ay
					end
				end
			end
		end

	new_edge_cursor: EV_CURSOR is
			-- Cursor displayed when pointer over a line (white dot).
		local
			pix_map: EV_PIXMAP
		once
			create pix_map.make_with_size (10, 10)
			pix_map.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 1, 1))
			pix_map.fill_ellipse (0, 0, pix_map.width, pix_map.height)
			pix_map.set_foreground_color (create {EV_COLOR}.make_with_rgb (0, 0, 0))
			pix_map.draw_ellipse (0, 0, pix_map.width, pix_map.height)
			create Result.make_with_pixmap (pix_map, pix_map.width // 2, pix_map.height // 2)
		end

	is_on_edge (ax, ay: INTEGER): BOOLEAN is
			-- is position `ax', `ay' on an edge?
		local
			l_edge_move_handlers: like edge_move_handlers
		do
			Result := False
			from
				l_edge_move_handlers := edge_move_handlers
				l_edge_move_handlers.start
			until
				Result or l_edge_move_handlers.after
			loop
				Result := l_edge_move_handlers.item.first.position_on_figure (ax, ay)
				l_edge_move_handlers.forth
			end
		end

	on_is_directed_change is
			-- `model'.`is_directed' changed.
		do
			if model.is_directed then
				line.enable_end_arrow
			else
				line.disable_end_arrow
			end
			request_update
		end

	line: EV_MODEL_POLYLINE
			-- The polyline visualizing the link.
--			
--	reflexive_distance: INTEGER
--			-- Distance from the border of the linkable figure if `is_reflexive'.

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

invariant
	edge_move_handlers_exists: edge_move_handlers /= Void
	line_not_void: line /= Void

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




end -- class EG_POLYLINE_LINK_FIGURE

