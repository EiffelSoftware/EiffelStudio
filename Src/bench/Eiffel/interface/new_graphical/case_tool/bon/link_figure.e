indexing
	description: "Breakable lines."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LINK_FIGURE

inherit
	DIAGRAM_COMPONENT
		redefine
			set_origin,
			real_pebble,
			position_on_figure,
			bounding_box
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize figures.
		local
			line: BON_LINE
			csf: CLIENT_SUPPLIER_FIGURE
			m: LINK_MIDPOINT
		do
			create vertices.make
			vertices.extend (start_point)
			vertices.extend (end_point)
			create lines.make
			line := create_line
			create m
			m.set (Current, line, Void)
			m.set_point (start_point)
			line.point_a.set_origin (start_point)
			line.point_b.set_origin (end_point)
			lines.extend (line)
			line.enable_end_arrow
			csf ?= Current
			if csf /= Void and then csf.is_aggregate then
				line.enable_cut_figure
			end
			create midpoints.make
		end

feature -- Access

	source: LINKABLE_FIGURE
			-- Figure where link starts.

	target: LINKABLE_FIGURE
			-- Figure where link ends.

	start_point: EV_RELATIVE_POINT is
			-- Where the link starts.
		deferred
		end

	end_point: EV_RELATIVE_POINT is
			-- Where the link ends.
		deferred
		end

	lines: LINKED_LIST [BON_LINE]
			-- Link between `client' and `supplier'.
			-- Side structure to the effective group the lines
			-- will be in but we need a guaranteed sequential
			-- order in the lines in order. Groups may be implemented
			-- as just sets of figures, without order.

	vertices: LINKED_LIST [EV_RELATIVE_POINT]
			-- Start, end and midpoints.
			-- [`start_point', ..., `end_point']

	midpoints: LINKED_LIST [LINK_MIDPOINT]
			-- All midpoints created by user.

	real_pebble: ANY is
			-- Calculated `pebble'.
			-- Void if key ctrl pressed.
		do
			if not ctrl_pressed_before then
				Result := Precursor
			end
			ctrl_pressed_before := False
		end

feature -- Status report

	is_reflexive: BOOLEAN is
			-- Is `source' equal to `target'?
		deferred
		end

	ctrl_pressed_before: BOOLEAN
			-- Was key Ctrl pressed when first asking for `pebble'?
	
feature -- Status setting

	insert_midpoint (i, x, y: INTEGER; before_drag: BOOLEAN) is
			-- Insert point on `x', `y' in `i'-th line.
		require
			i_within_bounds: i >= 1 and then i <= lines.count
		local
			new_line, clicked_line: BON_LINE
			new_line_point_a_origin: EV_RELATIVE_POINT
			mover: EV_MOVE_HANDLE
			midpoint: LINK_MIDPOINT
			ihf: INHERITANCE_FIGURE
			csf: CLIENT_SUPPLIER_FIGURE
		do
			ihf ?= Current
			csf ?= Current
		
				-- Go to clicked line.
			lines.go_i_th (i)
			clicked_line := lines.item

				-- And add a new line before.
			new_line := create_line
			lines.put_left (new_line)

				-- Initialize move handle for new midpoint.
			create mover
			mover.disable_always_shown

				-- Go to position in `vertices' where start point
				-- of clicked line is.
			vertices.go_i_th (i)
			
				-- This point will be the start point of new line.
			new_line_point_a_origin := vertices.item

				-- Add point controlled by `mover' in `vertices'.
			vertices.put_right (mover.point)

			mover.point.set_position (x, y)
			mover.point.set_origin (world.point)
			new_line.point_a.set_origin (new_line_point_a_origin)

				-- Notify lines about point controlled by `mover'.
			new_line.set_point_b (mover.point)
			clicked_line.set_point_a (mover.point)

				-- Initialize new LINK_MIDPOINT.
			create midpoint
			midpoint.set (Current, new_line, mover)
			midpoint.set_point (mover.point)
			mover.extend (midpoint)
			mover.move_actions.extend (~on_move)
			mover.move_actions.force_extend (~update_scrollable_area_size)
			mover.start_actions.extend (agent start_capture)
			mover.end_actions.extend (agent stop_capture)
			
				-- Add `mover' to corresponding layer in `world'.
			if ihf /= Void then
				world.inheritance_mover_layer.extend (mover)
			elseif csf /= Void and not is_reflexive then
				world.client_supplier_mover_layer.extend (mover)
			end
				
				-- Add `midpoint' to its right place in `midpoints'.
			midpoints.start
			if not midpoints.is_empty then
				midpoints.go_i_th (i - 1)
				midpoints.put_right (midpoint)
			else
				midpoints.extend (midpoint)
			end

			extend (new_line)

			mover.end_actions.extend_kamikaze (~update_origin)
			if not before_drag and source /= target then
				mover.start_actions.extend (midpoint~save_midpoint_position)
				mover.end_actions.extend (midpoint~extend_history)
			end
			
			source.world.full_redraw_performed
		end

	put_midpoint (mp: LINK_MIDPOINT; i: INTEGER) is
			-- Insert `mp' in `i'-th line.
			-- Should only be called after a call to remove_midpoint (mp).
		require
			i_within_bounds: i >= 1 and then i <= lines.count
		local
			new_line, clicked_line: BON_LINE
			new_line_point_a_origin, cur_origin: EV_RELATIVE_POINT
			ihf: INHERITANCE_FIGURE
			csf: CLIENT_SUPPLIER_FIGURE
		do
			ihf ?= Current
			csf ?= Current
		
				-- Go to clicked line.
			lines.go_i_th (i)
			clicked_line := lines.item

				-- And add a new line before.
			new_line := create_line
			lines.put_left (new_line)

				-- Go to position in `vertices' where start point
				-- of clicked line is.
			vertices.go_i_th (i)
			
				-- This point will be the start point of new line.
			new_line_point_a_origin := vertices.item

				-- Add point controlled by `mover' in `vertices'.
			vertices.put_right (mp.mover.point)

			mp.mover.point.set_position (mp.saved_x, mp.saved_y)
			mp.mover.point.set_origin (world.point)
			new_line.point_a.set_origin (new_line_point_a_origin)
			mp.set (Current, new_line, mp.mover)

				-- Notify lines about point controlled by `mover'.
			new_line.set_point_b (mp.mover.point)
			clicked_line.set_point_a (mp.mover.point)

				-- Add `mover' to corresponding layer in `world'.
			if ihf /= Void then
				world.inheritance_mover_layer.extend (mp.mover)
			elseif csf /= Void and not is_reflexive then
				world.client_supplier_mover_layer.extend (mp.mover)
			end
				
				-- Add `mp' to its right place in `midpoints'.
			midpoints.start
			if not midpoints.is_empty then
				midpoints.go_i_th (i - 1)
				midpoints.put_right (mp)
			else
				midpoints.extend (mp)
			end

			extend (new_line)

			mp.mover.end_actions.extend_kamikaze (~update_origin)
			cur_origin := actual_origin
			if cur_origin /= Void then
				mp.set_origin (actual_origin)
			end
			
			source.world.full_redraw_performed
		end

	put_handle_left is
			-- Move the link to the left half of `source' bubble,
			-- using one right angle.
		local
			figure_right, figure_left: LINKABLE_FIGURE
		do
			if source.x_position /= target.x_position and 
				source.y_position /= target.y_position then
				if source.x_position < target.x_position then
					figure_left := source
					figure_right := target
				else
					figure_right := source
					figure_left := target
				end
				reset
				insert_midpoint (
					1,
					((figure_left.x_position - source.world.point.x) / source.world.scale_x).rounded,
					((figure_right.y_position - source.world.point.y) / source.world.scale_y).rounded,
					False)
				update
				update_origin
			else
				reset
			end
		end

	put_handle_right is
			-- Move the link to the right half of `source' bubble,
			-- using one right angle.
		local
			figure_right, figure_left: LINKABLE_FIGURE
		do
			if source.x_position /= target.x_position and 
				source.y_position /= target.y_position then
				if source.x_position < target.x_position then
					figure_left := source
					figure_right := target
				else
					figure_right := source
					figure_left := target
				end
				reset
				insert_midpoint (
					1,
					((figure_right.x_position - source.world.point.x) / source.world.scale_x).rounded,
					((figure_left.y_position - source.world.point.y) / source.world.scale_y).rounded,
					False)
				update
				update_origin
			else
				reset
			end
		end

	put_two_handles_left is
			-- Add two midpoints to the left of `target' bubble, using right angles.
		local
			source_x, source_y, target_x, target_y, min_x, min_y, dist_x, dist_y: INTEGER
		do
			if source.x_position /= target.x_position and 
				source.y_position /= target.y_position then
				source_x := ((source.x_position - source.world.point.x) / source.world.scale_x).rounded
				source_y := ((source.y_position - source.world.point.y) / source.world.scale_y).rounded
				target_x := ((target.x_position - source.world.point.x) / source.world.scale_x).rounded
				target_y := ((target.y_position - source.world.point.y) / source.world.scale_x).rounded
				min_x := source_x.min (target_x)
				min_y := source_y.min (target_y) 
				dist_x := (source_x - target_x).abs
				dist_y := (source_y - target_y).abs
	
				reset
				if source_x = min_x and source_y = min_y then
					insert_midpoint (1, min_x + dist_x, min_y + dist_y // 2, False)
					insert_midpoint (1, min_x, min_y + dist_y // 2, False)
				elseif target_x = min_x and target_y = min_y then
					insert_midpoint (1, min_x + dist_x // 2, min_y, False)
					insert_midpoint (1, min_x + dist_x // 2, min_y + dist_y, False)
				elseif target_x = min_x then
					insert_midpoint (1, min_x + dist_x // 2, min_y + dist_y, False)
					insert_midpoint (1, min_x + dist_x // 2, min_y, False)
				elseif source_x = min_x then
					insert_midpoint (1, min_x + dist_x, min_y + dist_y // 2, False)
					insert_midpoint (1, min_x, min_y + dist_y // 2, False)
				end
				update
				update_origin
			else
				reset
			end
		end

	put_two_handles_right is
			-- Add two midpoints to the right of `target' bubble, using right angles.
		local
			source_x, source_y, target_x, target_y, min_x, min_y, dist_x, dist_y: INTEGER
		do
			if source.x_position /= target.x_position and 
				source.y_position /= target.y_position then
				source_x := ((source.x_position - source.world.point.x) / source.world.scale_x).rounded
				source_y := ((source.y_position - source.world.point.y) / source.world.scale_y).rounded
				target_x := ((target.x_position - source.world.point.x) / source.world.scale_x).rounded
				target_y := ((target.y_position - source.world.point.y) / source.world.scale_x).rounded
				min_x := source_x.min (target_x)
				min_y := source_y.min (target_y)
				dist_x := (source_x - target_x).abs
				dist_y := (source_y - target_y).abs
	
				reset
				if source_x = min_x and source_y = min_y then
					insert_midpoint (1, min_x + dist_x // 2, min_y + dist_y, False)
					insert_midpoint (1, min_x + dist_x // 2, min_y, False)
				elseif target_x = min_x and target_y = min_y then
					insert_midpoint (1, min_x, min_y + dist_y // 2, False)
					insert_midpoint (1, min_x + dist_x, min_y + dist_y // 2, False)
				elseif target_x = min_x then
					insert_midpoint (1, min_x, min_y + dist_y // 2, False)
					insert_midpoint (1, min_x + dist_x, min_y + dist_y // 2, False)
				elseif source_x = min_x then
					insert_midpoint (1, min_x + dist_x // 2, min_y, False)
					insert_midpoint (1, min_x + dist_x // 2, min_y + dist_y, False)
				end
				update
				update_origin
			else
				reset
			end
		end

	reset is
			-- Remove midpoints.
		local
			bcf: BON_CLIENT_SUPPLIER_FIGURE
		do
			from
				midpoints.start
			until
				midpoints.after
			loop
				world.inheritance_mover_layer.prune_all (midpoints.item.mover)
				world.client_supplier_mover_layer.prune_all (midpoints.item.mover)
				midpoints.forth
			end
			remove_midpoints
			from 
				lines.start
			until
				lines.after
			loop
				prune_all (lines.item)
				lines.forth
			end
			initialize
			extend (lines.first)
			bcf ?= Current
			if bcf /= Void and then bcf.is_reflexive then
				set_reflexive
			end
			update
		end

	set_origin (o: EV_RELATIVE_POINT) is
			-- Set origin of midpoints to `o', but
			-- do not move figure.
		do
			point.set_origin (o)
			from
				midpoints.start
			until
				midpoints.after
			loop
				midpoints.item.set_origin (o)
				midpoints.forth
			end
		end

	actual_origin: EV_RELATIVE_POINT is
			-- Origin of the cluster `Current' belongs to.
			-- Void if none.
		do
			if source = target then
				Result := source.point
			elseif target.cluster_figure /= Void and then
				source.cluster_figure /= Void then
					if target.cluster_figure.is_subcluster_of (source.cluster_figure) then
						Result := source.cluster_figure.point
					elseif source.cluster_figure.is_subcluster_of (target.cluster_figure) then
						Result := target.cluster_figure.point
					end
			end
		end

	update_origin is
			-- Set `origin' to the correct cluster.
		local
			o: EV_RELATIVE_POINT
		do
			o := actual_origin
			if o /= Void then
				change_origin (o)
			end
		end

feature {CONTEXT_DIAGRAM} -- Status setting

	set_right_angle is
			-- Make `Current' use right angles.
		local
			d: CONTEXT_DIAGRAM
			current_points: LINKED_LIST [LINK_MIDPOINT]
		do
			d ?= source.world
			create current_points.make
			from
				midpoints.start
			until
				midpoints.after
			loop
				current_points.put_front (midpoints.item)
				midpoints.forth
			end
			unset_do_stack.put (current_points)
	
			apply_right_angles
			
			create current_points.make
			from
				midpoints.start
			until
				midpoints.after
			loop
				current_points.put_front (midpoints.item)
				midpoints.forth
			end
			reset_do_stack.put (current_points)			
		end
		
	unset_right_angle is
			-- Undo `set_right_angle'.
		local
			retrieved_points: LINKED_LIST [LINK_MIDPOINT]
		do
			check
				stacks_not_empty: source /= target implies (not unset_do_stack.is_empty)
			end
			if source /= target then
				reset
				retrieved_points := unset_do_stack.item
				if not retrieved_points.is_empty then
					retrieve_midpoints (retrieved_points)
				end
				unset_do_stack.remove
				unset_undo_stack.put (retrieved_points)
				
				if not reset_undo_stack.is_empty then
					retrieved_points := reset_undo_stack.item
					reset_do_stack.put (retrieved_points)
					reset_undo_stack.remove
				end
			end
		end
		
	reset_right_angle is
			-- Redo `set_right_angle'.
		local
			retrieved_points: LINKED_LIST [LINK_MIDPOINT]
		do
			check
				stacks_not_empty: source /= target implies (not reset_do_stack.is_empty)
			end
			if source /= target then
				reset
				retrieved_points := reset_do_stack.item
				if not retrieved_points.is_empty then
					retrieve_midpoints (retrieved_points)
				end
				reset_do_stack.remove
				reset_undo_stack.put (retrieved_points)
				
				retrieved_points := unset_undo_stack.item
				unset_do_stack.put (retrieved_points)
				unset_undo_stack.remove
			end
		end

feature {CLASS_TEXT_MODIFIER} -- Status setting

	set_reflexive is
			-- `Current' is reflexive. Draw it in an understandable way.
		do
			insert_midpoint (1,
				source.x_position - source.world.point.x - source.width // 2 - 15,
				source.y_position - source.world.point.y - source.height // 2,
				False)
			insert_midpoint (1,
				source.x_position - source.world.point.x - source.width // 2 - 15,
				source.y_position - source.world.point.y + source.height // 2,
				False)
			update
			update_origin
		end

feature {EB_DELETE_FIGURE_COMMAND} -- Status report

	index_of_midpoint (p: LINK_MIDPOINT): INTEGER is
			-- Index of line `p' was inserted in.
		local
			rp: EV_RELATIVE_POINT
		do
			rp := p.mover.point
			vertices.compare_objects
			vertices.start
			vertices.search (rp)
			vertices.compare_references
			Result := vertices.index
		end
			
feature -- Element change

	change_origin (new_origin: EV_RELATIVE_POINT) is
			-- Set the point this figure is relative to.
			-- Do not change absolute coordinates.
		local
			p: LINK_MIDPOINT
		do
			point.change_origin (new_origin)
			from
				midpoints.start
			until
				midpoints.after
			loop
				p := midpoints.item
				p.change_origin (new_origin)
				if source /= target then
					p.point.set_position (
						default_snapped_x ((p.point.x / source.world.scale_x).rounded),
						default_snapped_y ((p.point.y / source.world.scale_y).rounded))
				else
					p.point.set_position (
						(p.point.x / source.world.scale_x).rounded,
						(p.point.y / source.world.scale_y).rounded)
				end
				midpoints.forth
			end
		end

feature {LINK_MIDPOINT} -- Removal

	remove_midpoint (m: LINK_MIDPOINT) is
			-- Remove `m' from `Current'.
		local
			l: BON_LINE
			removed, m_end_point: BOOLEAN
			l_occurrence: INTEGER
		do
			m.set_saved_coordinates (m.point.x, m.point.y)
			
				-- Remove move handle linked to `actual_midpoint'
				-- from figure world.
			world.inheritance_mover_layer.prune_all (m.mover)
			world.client_supplier_mover_layer.prune_all (m.mover)

			m_end_point := (m.point = end_point)

				-- Set `vertices' cursor one position before point
				-- associated with `actual_midpoint'.
			from
				vertices.finish
				if m_end_point then
					vertices.back
				end
			until
				vertices.before or else 
					(vertices.item /= Void and then
						vertices.item = m.mover.point)
			loop
				vertices.back
			end
			vertices.back

				-- Set `lines' cursor one position after line
				-- associated with `m'.
			lines.start
			l_occurrence := lines.occurrences (m.line)
			lines.go_i_th (lines.index_of (m.line, l_occurrence))
			if not lines.islast then
				lines.forth
			end

				-- Assign correct origin to the line which used to have
				-- `m' as start point.
			if vertices.isfirst then
				lines.item.point_a.set_origin (vertices.first)
			else
				lines.item.set_point_a (vertices.item)
			end

				-- Remove line which used to have `m' as
				-- end point.
			from
				lines.finish
				if m_end_point then
					lines.back
				end
				removed := False
			until	
				removed or else lines.before
			loop
				if lines.item = m.line then
					lines.remove
					removed := True
				else
					lines.back
				end
			end

				-- Remove this line in `Current' as a figure group.
			from
				finish
				if m_end_point then
					back
				end
				removed := False
			until	
				removed or else before
			loop
				l ?= item
				if  l /= Void and then l = m.line then
					remove
					removed := True
				else
					back
				end
			end

				-- Remove point associated with `m'.			
			from
				vertices.finish
				if m_end_point then
					vertices.back
				end
				removed := False
			until
				removed or else vertices.before
			loop
				if vertices.item /= Void and then
					vertices.item = m.mover.point then
						vertices.remove
						removed := True
				else
					vertices.back
				end
			end

				-- Remove `m' itself'.
			midpoints.prune_all (m)
		end

	remove_midpoint_with_number (n: INTEGER) is
			-- Remove `n'-th midpoint.
		require
			n_non_negative: n >= 0
		do
			remove_midpoint (midpoints.i_th (n))
			update
			source.world.context_editor.projector.project
		end

feature -- Implementation

	position_on_figure (x, y: INTEGER): BOOLEAN is
   			-- Is the point on (`x', `y') on this figure?
		do
			from
				lines.start
			until
				Result or else lines.after
			loop
				Result := lines.item.position_on_figure (x, y)
				lines.forth
			end
		end

feature {CONTEXT_DIAGRAM} -- XML

	xml_element (a_parent: XML_ELEMENT): XML_ELEMENT is
			-- XML representation.
		deferred
		end

	set_with_xml_element (an_element: XML_ELEMENT) is
			-- Set attributes from XML element.
		require else
			an_element_has_src_attribute: an_element.attributes.has ("SRC")
			an_element_has_trg_attribute: an_element.attributes.has ("TRG")
		deferred
		end

feature {EB_LINK_TOOL_COMMAND, EB_DELETE_DIAGRAM_ITEM_COMMAND} -- Implementation

	retrieve_lines (retrieved_vertices: LINKED_LIST [EV_RELATIVE_POINT]) is
			-- Add lines corresponding to the points in `retrieved_vertices'.
		local
			mp: EV_RELATIVE_POINT
			i: INTEGER
			new_midpoint: LINK_MIDPOINT
			new_mover: EV_MOVE_HANDLE
		do
			from
				retrieved_vertices.start
				i := 1
			until	
				retrieved_vertices.after
			loop
				mp := retrieved_vertices.item
				insert_midpoint (1, mp.x, mp.y, False)
				new_midpoint := midpoints.i_th (i)
				new_mover := new_midpoint.mover
				new_mover.move_actions.extend (~on_move)
				new_mover.move_actions.force_extend (~update_scrollable_area_size)
				new_mover.start_actions.extend (agent start_capture)
				new_mover.end_actions.extend (agent stop_capture)
				
				i := i + 1
				retrieved_vertices.forth
			end
			update
			update_origin
		end
		
	retrieve_midpoints (retrieved_midpoints: LINKED_LIST [LINK_MIDPOINT]) is
			-- Add lines corresponding to the points in `retrieved_midpoints'.
		local
			mp: LINK_MIDPOINT
		do
			from
				retrieved_midpoints.start
			until	
				retrieved_midpoints.after
			loop
				mp := retrieved_midpoints.item
				put_midpoint (mp, 1)
				retrieved_midpoints.forth
			end
			update
			update_origin
		end
				
feature {LINK_MIDPOINT} -- Implementation

	project is
			-- Call diagram projector.
		do
			source.world.context_editor.projector.project
		end
		
feature {NONE} -- Implementation

	reset_do_stack, reset_undo_stack, unset_do_stack, unset_undo_stack: LINKED_STACK [LINKED_LIST [LINK_MIDPOINT]]
			-- Stacks used by `unset_right_angles' and `reset_right_angles' to store midpoints.

	on_click (x, y, b: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER; line: EV_FIGURE_LINE) is
			-- User pressed pointer button on `line'.
		local
			bl: BON_LINE
			pebble_as_stone: LINK_STONE
		do
			ctrl_pressed_before := False
			if b = 1 then
				if not is_reflexive then
					bl ?= line
					if bl /= Void then
						lines.start	
						lines.search (bl)
						if not lines.exhausted then
							insert_midpoint (
								lines.index,
								(x / point.origin.scale_x_abs).rounded,
								(y / point.origin.scale_y_abs).rounded,
								True)
							start_drag (midpoint_by_line (lines.i_th (lines.index - 1)), lines.index)
						end
					end
				end
			elseif b = 3 and then ctrl_pressed then
					-- Ctrl + Right-click, do not start PND.
				pebble_as_stone ?= pebble
				if pebble_as_stone /= Void then
					source.world.context_editor.create_link_tool (pebble_as_stone)
				end
				ctrl_pressed_before := True
			end
		end

	on_move (x, y: INTEGER) is
			-- Some resizer moved.
		do
			invalidate
			update
		end

	update_scrollable_area_size is
			-- Minimum size of the scrollable area needs to be updated
			-- according to `Current' last move.
		do
			source.world.context_editor.on_figure_moved
		end	

	create_line: BON_LINE is
			-- Create new line segment with default values.
		do
			create Result
			Result.pointer_button_press_actions.extend (~on_click (?, ?, ?, ?, ?, ?, ?, ?, Result))
		end

	start_drag (mp: LINK_MIDPOINT; i: INTEGER) is
			-- Start dragging `mp'.
		require
			mp_not_void: mp /= Void
		do
			mp.mover.enable_capture
			mp.mover.end_actions.extend_kamikaze (~end_drag (mp, i))
			update
		end
	
	end_drag (p: LINK_MIDPOINT; i: INTEGER) is
			-- The first move of `i'-th point, which is `p', just ended.
			-- If `i'-th point is not `p', re-create `p'.
		do
			p.mover.start_actions.extend (p~save_midpoint_position)
			p.mover.end_actions.extend (p~extend_history)
			source.world.context_editor.history.register_named_undoable (
				Interface_names.t_Diagram_insert_midpoint_cmd,
				[<<~put_midpoint (p, i - 1), ~update, ~project>>],
				[<<~remove_midpoint (p), ~update, ~project>>])
		end

	remove_midpoints is
			-- Remove all midpoint movers from world.
		do
			from
				midpoints.start
			until
				midpoints.is_empty
			loop
				remove_midpoint (midpoints.first)
			end
		end

	midpoint_by_line (a_line: BON_LINE): LINK_MIDPOINT is
			-- Midpoint which line is `a_line'.
		require
			a_line_not_void: a_line /= Void

		do
			from
				midpoints.start
			until
				midpoints.after or Result /= Void
			loop
				if midpoints.item.line = a_line then
					Result := midpoints.item
				end
				midpoints.forth
			end
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		do
			if not is_empty then
				Result := first.bounding_box
				Result.set_width (Result.width.max (25))
				start
				if not after then
					from
						forth
					until
						after
					loop
						if item /= Void then
							Result.merge (item.bounding_box)
							forth
						end
					end
				end
			else
				create Result.make (points.first.x_abs, points.first.y_abs, 1, 1)
			end
		end

	apply_right_angles is
			-- Make Current use right angles.
		deferred
		end

end -- class LINK_FIGURE






