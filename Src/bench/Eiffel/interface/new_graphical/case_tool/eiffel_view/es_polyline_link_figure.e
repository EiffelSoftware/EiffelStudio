indexing
	description: "Common functionalities for all links in EIFFEL_WORLD."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LINK_FIGURE

inherit
	EG_POLYLINE_LINK_FIGURE
		redefine
			edge_start,
			edge_end,
			world,
			pointer_button_pressed_on_a_line,
			request_update
		end
	
	EB_CONSTANTS
		undefine
			default_create
		end

feature -- Access

	world: EIFFEL_WORLD is
			-- The world `Current' is part of.
		do
			Result ?= Precursor {EG_POLYLINE_LINK_FIGURE}
		end
		
	edges: LIST [EG_EDGE] is
			-- Edges of `Current'.
		do
			Result := edge_move_handlers.twin
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	request_update is
			-- Request an update.
		local
			l_cluster: EG_CLUSTER_FIGURE
		do
			Precursor {EG_POLYLINE_LINK_FIGURE}
			l_cluster ?= group
			if l_cluster /= Void then
				l_cluster.request_update
			end
		end

	put_handle_left is
			-- Move the link to the left half of `source' bubble,
			-- using one right angle.
		local
			figure_right, figure_left: EG_LINKABLE_FIGURE
		do
			if not is_reflexive then
				if 
					source.port_x /= target.port_x and 
					source.port_y /= target.port_y 
				then
					if source.port_x < target.port_y then
						figure_left := source
						figure_right := target
					else
						figure_right := source
						figure_left := target
					end
					reset
					add_point_between (1, 2)
					set_i_th_point_position (2, figure_left.port_x, figure_right.port_y)
				else
					reset
				end
				request_update
			end
		end

	put_handle_right is
			-- Move the link to the right half of `source' bubble,
			-- using one right angle.
		local
			figure_right, figure_left: EG_LINKABLE_FIGURE
		do
			if not is_reflexive then
				if 
					source.port_x /= target.port_x and 
					source.port_y /= target.port_y 
				then
					if source.port_x < target.port_x then
						figure_left := source
						figure_right := target
					else
						figure_right := source
						figure_left := target
					end
					reset
					add_point_between (1, 2)
					set_i_th_point_position (2, figure_right.port_x, figure_left.port_y)
				else
					reset
				end
				request_update
			end
		end

	put_two_handles_left is
			-- Add two midpoints to the left of `target' bubble, using right angles.
		local
			source_x, source_y, target_x, target_y, min_x, min_y, dist_x, dist_y: INTEGER
		do
			if not is_reflexive then
				if source.port_x /= target.port_x and 
					source.port_y /= target.port_y then
						
					source_x := source.port_x
					source_y := source.port_y
					target_x := target.port_x
					target_y := target.port_y
					
					min_x := source_x.min (target_x)
					min_y := source_y.min (target_y) 
					dist_x := (source_x - target_x).abs
					dist_y := (source_y - target_y).abs
		
					reset
					add_point_between (1, 2)
					add_point_between (1, 2)
					if source_x = min_x and source_y = min_y then
						set_i_th_point_position (3, min_x + dist_x, min_y + dist_y // 2)
						set_i_th_point_position (2, min_x, min_y + dist_y // 2)
					elseif target_x = min_x and target_y = min_y then
						set_i_th_point_position (3, min_x + dist_x // 2, min_y)
						set_i_th_point_position (2, min_x + dist_x // 2, min_y + dist_y)
					elseif target_x = min_x then
						set_i_th_point_position (3, min_x + dist_x // 2, min_y + dist_y)
						set_i_th_point_position (2, min_x + dist_x // 2, min_y)
					elseif source_x = min_x then
						set_i_th_point_position (3, min_x + dist_x, min_y + dist_y // 2)
						set_i_th_point_position (2, min_x, min_y + dist_y // 2)
					end
				else
					reset
				end
				request_update
			end
		end

	put_two_handles_right is
			-- Add two midpoints to the right of `target' bubble, using right angles.
		local
			source_x, source_y, target_x, target_y, min_x, min_y, dist_x, dist_y: INTEGER
		do
			if not is_reflexive then
				if source.port_x /= target.port_x and 
					source.port_y /= target.port_y then
						
					source_x := source.port_x
					source_y := source.port_y
					target_x := target.port_x
					target_y := target.port_y
					
					min_x := source_x.min (target_x)
					min_y := source_y.min (target_y)
					dist_x := (source_x - target_x).abs
					dist_y := (source_y - target_y).abs
		
					reset
					add_point_between (1, 2)
					add_point_between (1, 2)
					if source_x = min_x and source_y = min_y then
						set_i_th_point_position (3, min_x + dist_x // 2, min_y + dist_y)
						set_i_th_point_position (2, min_x + dist_x // 2, min_y)
					elseif target_x = min_x and target_y = min_y then
						set_i_th_point_position (3, min_x, min_y + dist_y // 2)
						set_i_th_point_position (2, min_x + dist_x, min_y + dist_y // 2)
					elseif target_x = min_x then
						set_i_th_point_position (3, min_x, min_y + dist_y // 2)
						set_i_th_point_position (2, min_x + dist_x, min_y + dist_y // 2)
					elseif source_x = min_x then
						set_i_th_point_position (3, min_x + dist_x // 2, min_y)
						set_i_th_point_position (2, min_x + dist_x // 2, min_y + dist_y)
					end
				else
					reset
				end
				request_update
			end
		end
		
	retrieve_edges (retrieved_edges: LIST [EG_EDGE]) is
			-- Add lines corresponding to the points in `retrieved_edges'.
		require
			retrieved_edges_not_void: retrieved_edges /= Void
			no_edges: edges_count = 0
		local
			last_point: EV_COORDINATE
			l_edge: EG_EDGE
		do
			if not is_reflexive then
				last_point := line.point_array.item (line.point_array.count - 1)
				line.set_point_count (1)
				from
					retrieved_edges.start
				until
					retrieved_edges.after
				loop
					l_edge := retrieved_edges.item
					line.extend_point (l_edge.corresponding_point)
						
					line.point_array.put (l_edge.corresponding_point, line.point_array.count - 1)
						-- a little hack since extend_point twins the corresponding_point.
						
					edge_move_handlers.extend (l_edge)
					extend (l_edge)
					retrieved_edges.forth
				end
				line.extend_point (last_point)
				line.point_array.put (last_point, line.point_array.count - 1)
				request_update
			end
		end
		
	apply_right_angles is
			-- Make `Current' use right angles.
		local
			source_x, source_y, target_x, target_y: INTEGER
			source_top, source_bottom, target_top, target_bottom: INTEGER
			dist, min_dist, x1, x2: INTEGER
			sbbox, tbbox: EV_RECTANGLE
		do
			if not is_reflexive then
				source_x := source.port_x
				source_y := source.port_y
				target_x := target.port_x
				target_y := target.port_y
				if source_x = target_x or
					source_y = target_y then
						reset
				else
					sbbox := source.bounding_box
					source_top := sbbox.top
					source_bottom := sbbox.bottom
					tbbox := target.bounding_box
					target_top := tbbox.top
					target_bottom := tbbox.bottom
					min_dist := line.arrow_size * 3
					if edges_count /= 2 then
						reset
						add_point_between (1, 2)
						add_point_between (1, 2)
					end
					if 
						(source_y < target_y and then target_top - source_bottom < min_dist) or else
						(source_y > target_y and then source_top - target_bottom < min_dist)
					then
						-- horizontal
						if source_x > target_x then
							x1 := sbbox.left
							x2 := tbbox.right
							dist := x1 - x2
							if dist < min_dist then
								reset
							else
								dist := dist // 2
								set_i_th_point_position (3, x2 + dist, target_y)
								set_i_th_point_position (2, x2 + dist, source_y)
							end
						else
							x1 := sbbox.right
							x2 := tbbox.left
							dist := x2 - x1
							if dist < min_dist then
								reset
							else
								dist := dist // 2
								set_i_th_point_position (3, x2 - dist, target_y)
								set_i_th_point_position (2, x2 - dist, source_y)
							end
						end
					else
						-- vertical
						if source_y > target_y then
							x1 := source_top
							dist := line.arrow_size * 2 - line.line_width
						else
							x1 := source_bottom
							dist := -line.arrow_size * 2 + line.line_width
						end
						
						set_i_th_point_position (3, target_x, x1 - dist)
						set_i_th_point_position (2, source_x, x1 - dist)
					end
				end
			end
		end
		
feature {NONE} -- Implementation

	edge_start (an_edge: EG_EDGE) is
			-- User starts to move `an_edge'.
		do
			saved_x := an_edge.point_x
			saved_y := an_edge.point_y
		end
		
	saved_x, saved_y: INTEGER
			-- Position of edge at move start.
		
	edge_end (an_edge: EG_EDGE) is
			-- User ends to move `an_edge'.
		local
			i: INTEGER
		do
			if is_history_update_needed then
				if not is_edge_added then
					i := edge_move_handlers.index_of (an_edge, 1) + 1
					world.context_editor.history.register_named_undoable (
						interface_names.t_Diagram_move_midpoint_cmd,
						agent set_i_th_point_position (i, an_edge.point_x, an_edge.point_y),
						agent set_i_th_point_position (i, saved_x, saved_y))
				else
					is_edge_added := False
					world.context_editor.history.register_named_undoable (
						interface_names.t_diagram_insert_midpoint_cmd,
						[<<agent add_point_between (point_added_i, point_added_j),
						   agent set_i_th_point_position (point_added_i + 1, an_edge.point_x, an_edge.point_y)>>],
						agent remove_i_th_point (point_added_i + 1))
				end
				is_history_update_needed := False
			end
		end
	
	point_added_i, point_added_j: INTEGER
			-- Position wher a point was inserted if `is_edge_added'.

	is_edge_added: BOOLEAN
			-- Was an edge added.
			
	is_history_update_needed: BOOLEAN
	
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
			if button = 1 and not ev_application.ctrl_pressed then
				is_history_update_needed := True
				if not is_on_edge (ax, ay) and then source /= target then
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
						point_added_i := i
						point_added_j := i + 1
						is_edge_added := True
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
			elseif button = 3 and then ev_application.ctrl_pressed then
					-- Ctrl + Right-click, does not start PND.
				world.context_editor.create_link_tool (create {LINK_STONE}.make (Current))
			end
		end

end -- class EIFFEL_LINK_FIGURE
