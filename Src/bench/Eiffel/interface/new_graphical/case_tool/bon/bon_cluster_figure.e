indexing
	description: "Graphical representations of clusters in BON notation."
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLUSTER_FIGURE

inherit
	CLUSTER_FIGURE
		rename
			world as cluster_diagram
		undefine
			snap_to_grid,
			out
		redefine
			position_on_figure,
			arrange_clusters,
			real_pebble
		end

	EV_MOVE_HANDLE
		rename
			initialize as initialize_mover
		undefine
			default_create,
			wipe_out,
			position_on_figure,
			set_origin,
			real_pebble,
			is_equal
		select
			world
		end

create
	make_with_cluster

feature -- Initialization

	initialize is 
			-- Initialize figures.
		do
			initialize_mover
			create broken_name.make (10)

			create body
			body.point_a.set_origin (point)
			body.point_b.set_origin (body.point_a)
			body.set_foreground_color (bon_cluster_line_color)
			body.set_background_color (bon_cluster_fill_color)
			body.enable_dashed_line_style

			create center_point.make_with_origin (body.point_a)

			create resizer_bottom_right
			create resize_area_bottom_right
			resize_area_bottom_right.point_a.set_origin (resizer_bottom_right.point)
			resize_area_bottom_right.point_b.set_origin (resize_area_bottom_right.point_a)
			resize_area_bottom_right.set_pointer_style (Default_pixmaps.Sizenwse_cursor)

			resizer_bottom_right.hide
			resizer_bottom_right.disable_snapping
			resizer_bottom_right.point.set_origin (point)
			resizer_bottom_right.extend (resize_area_bottom_right)
			resizer_bottom_right.move_actions.extend (agent on_resizer_bottom_right_move)
			resizer_bottom_right.move_actions.force_extend (agent update_scrollable_area_size)
			resizer_bottom_right.set_pointer_style (Default_pixmaps.Sizenwse_cursor)
			resizer_bottom_right.start_actions.extend (agent start_capture)
			resizer_bottom_right.end_actions.extend (agent stop_capture)
			resizer_bottom_right.end_actions.extend (agent on_resizer_end)

			create resizer_top_left
			create resize_area_top_left
			resizer_top_left.hide
			resizer_top_left.disable_snapping
			resizer_top_left.point.set_origin (point)
			resizer_top_left.extend (resize_area_top_left)
			resizer_top_left.start_actions.extend (agent on_resizer_start)
			resizer_top_left.move_actions.extend (agent on_resizer_top_left_move)
			resizer_top_left.end_actions.extend (agent on_resizer_end)
			resizer_top_left.set_pointer_style (Default_pixmaps.Sizenwse_cursor)
			resizer_top_left.move_actions.force_extend (agent update_scrollable_area_size)
			resizer_top_left.enable_snapping
			resizer_top_left.start_actions.extend (agent start_capture)
			resizer_top_left.end_actions.extend (agent stop_capture)

			resize_area_top_left.point_a.set_origin (resizer_top_left.point)
			resize_area_top_left.point_b.set_origin (resize_area_top_left.point_a)
			resize_area_top_left.set_pointer_style (Default_pixmaps.Sizenwse_cursor)

			create resizer_top_right
			create resize_area_top_right
			resizer_top_right.hide
			resizer_top_right.disable_snapping
			resizer_top_right.point.set_origin (point)
			resizer_top_right.extend (resize_area_top_right)
			resizer_top_right.start_actions.extend (agent on_resizer_start)
			resizer_top_right.move_actions.extend (agent on_resizer_top_right_move)
			resizer_top_right.end_actions.extend (agent on_resizer_end)
			resizer_top_right.set_pointer_style (Default_pixmaps.Sizenesw_cursor)
			resizer_top_right.move_actions.force_extend (agent update_scrollable_area_size)
			resizer_top_right.enable_snapping
			resizer_top_right.start_actions.extend (agent start_capture)
			resizer_top_right.end_actions.extend (agent stop_capture)
			
			resize_area_top_right.point_a.set_origin (resizer_top_right.point)
			resize_area_top_right.point_b.set_origin (resize_area_top_right.point_a)
			resize_area_top_right.set_pointer_style (Default_pixmaps.Sizenesw_cursor)

			create resizer_bottom_left
			create resize_area_bottom_left
			resizer_bottom_left.hide
			resizer_bottom_left.disable_snapping
			resizer_bottom_left.point.set_origin (point)
			resizer_bottom_left.extend (resize_area_bottom_left)
			resizer_bottom_left.start_actions.extend (agent on_resizer_start)
			resizer_bottom_left.move_actions.extend (agent on_resizer_bottom_left_move)
			resizer_bottom_left.end_actions.extend (agent on_resizer_end)
			resizer_bottom_left.set_pointer_style (Default_pixmaps.Sizenesw_cursor)
			resizer_bottom_left.move_actions.force_extend (agent update_scrollable_area_size)
			resizer_bottom_left.enable_snapping
			resizer_bottom_left.start_actions.extend (agent start_capture)
			resizer_bottom_left.end_actions.extend (agent stop_capture)
			
			resize_area_bottom_left.point_a.set_origin (resizer_bottom_left.point)
			resize_area_bottom_left.point_b.set_origin (resize_area_bottom_left.point_a)
			resize_area_bottom_left.set_pointer_style (Default_pixmaps.Sizenesw_cursor)
						
			create name_mover
			create name_area
			name_area.point_a.set_origin (center_point)
			name_area.point_b.set_origin (name_area.point_a)
			name_area.set_foreground_color (bon_cluster_line_color)
			name_area.set_background_color (bon_cluster_name_area_color)
			name_area.enable_dashed_line_style
			
			create name_moving_area
			name_moving_area.point_a.set_origin (name_area.point_a)
			name_moving_area.point_b.set_origin (name_moving_area.point_a)
			name_moving_area.set_pointer_style (Default_pixmaps.Sizeall_cursor)
			name_moving_area.pointer_double_press_actions.extend (agent on_name_double_click)
		
			name_mover.hide
			name_mover.disable_snapping
			name_mover.point.set_origin (center_point)
			name_mover.extend (name_moving_area)
			name_mover.set_real_position_agent (agent reset_mover_coordinates)
			name_mover.start_actions.extend (agent start_capture)
			name_mover.end_actions.extend (agent stop_capture)

			create name_figures.make

			pointer_button_press_actions.extend (agent button_press)
			move_actions.force_extend (agent update)
			move_actions.force_extend (agent update_scrollable_area_size)
			start_actions.extend (agent save_position)
			start_actions.extend (agent set_pointer_style (Default_pixmaps.Sizeall_cursor))
			start_actions.extend (agent start_capture)
			end_actions.extend (agent stop_capture)
			end_actions.extend (agent set_pointer_style (Default_pixmaps.Standard_cursor))
			end_actions.extend (agent update_cluster_size)
			end_actions.extend (agent extend_history)
			end_actions.extend (agent update_area_bounds)
		end
		
feature -- Access

	width: INTEGER is
			-- Horizontal size.
		do
			Result := right - left
		end

	height: INTEGER is
			-- Vertical size.
		do
			Result := bottom - top
		end

	left: INTEGER is
			-- Absolute left position.
		do
			Result := (body.point_a.x_abs).min (name_area.point_a.x_abs)
		end

	top: INTEGER is
			-- Absolute top position.
		do
			Result := (body.point_a.y_abs).min (name_area.point_a.y_abs)
		end

	right: INTEGER is
			-- Absolute right position.
		do
			Result := (body.point_b.x_abs).max (name_area.point_b.x_abs)
		end

	bottom: INTEGER is
			-- Absolute bottom position.
		do
			Result := (body.point_b.y_abs).max (name_area.point_b.y_abs)
		end

	x_position: INTEGER is
			-- Absolute center x coordinate.
		do
			Result := point.x_abs
		end

	y_position: INTEGER is
			-- Absolute center y coordinate.
		do
			Result := point.y_abs
		end

	real_pebble: ANY is
			-- Calculated `pebble'.
			-- Void if key ctrl pressed.
		do
			if not ctrl_pressed then
				Result := Precursor
			end
		end

feature -- Status report

	name_is_top: BOOLEAN
			-- Is `name_area' on top of `body'?

	name_is_bottom: BOOLEAN
			-- Is `name_area' on bottom of `body'?

	name_is_left: BOOLEAN
			-- Is `name_area' on left side of `body'?

	name_is_right: BOOLEAN
			-- Is `name_area' on right side of `body'?

feature -- Figures

	body: BON_CLUSTER_RECTANGLE_FIGURE
			-- Body of `Current', containing class figures.

	name_area: BON_CLUSTER_RECTANGLE_FIGURE
			-- Figure containing `name'.

	name_mover: EV_MOVE_HANDLE
			-- Handle that allows the user to move the name area.

	name_figures: LINKED_LIST [EV_FIGURE_TEXT]
			-- Figures for `name'.

	resizer_bottom_right: EV_MOVE_HANDLE
			-- Handle that allows the user to resize the body.
			
	resizer_top_left: EV_MOVE_HANDLE
			-- Handle that allows the user to resize the body upwards and/or to the left.

	resizer_top_right: EV_MOVE_HANDLE
			-- Handle that allows the user to resize the body upwards and/or to the right.

	resizer_bottom_left: EV_MOVE_HANDLE
			-- Handle that allows the user to resize the body downwards and/or to the left.

	resize_area_bottom_right: EV_FIGURE_RECTANGLE
			-- Invisible rectangle where mouse cursor changes.
			
	resize_area_top_left: EV_FIGURE_RECTANGLE
			-- Area where top/left resizing starts.	

	resize_area_top_right: EV_FIGURE_RECTANGLE
			-- Area where top/right resizing starts.	

	resize_area_bottom_left: EV_FIGURE_RECTANGLE
			-- Area where bottom/left resizing starts.	

	name_moving_area: EV_FIGURE_RECTANGLE
			-- Invisible rectangle where mouse cursor changes.

	center_point: EV_RELATIVE_POINT
			-- Point at the center of `body', origin of `name_mover'.

feature -- Status setting

	set_size (a_width, a_height: INTEGER) is
			-- Resize `Current' to `a_width', `a_height'.
		local
			name_shift_x, name_shift_y: INTEGER
			new_width, new_height: INTEGER
			half_height, half_width: INTEGER
			name_area_top, name_area_bottom, name_area_left, name_area_right: INTEGER
		do
			name_area_top := name_area.point_a.y
			name_area_bottom := name_area.point_b.y
			name_area_left := name_area.point_a.x
			name_area_right := name_area.point_b.x
			new_width := a_width.max (name_area_right)
			new_height := a_height.max (name_area_bottom)
			body.point_b.set_position (new_width, new_height)
			center_point.set_position (new_width // 2, new_height // 2)

			resizer_bottom_right.point.set_position (body.point_b.x, body.point_b.y)
			resize_area_bottom_right.point_a.set_position (- 20, - 20)
			resize_area_bottom_right.point_b.set_position (20, 20)

			resizer_top_left.point.set_position (0, 0)
			resize_area_top_left.point_b.set_position (20, 20)

			resizer_top_right.point.set_position (body.point_b.x, 0)
			resize_area_top_right.point_a.set_position (- 20, 0)			
			resize_area_top_right.point_b.set_position (20, 20)

			resizer_bottom_left.point.set_position (0, body.point_b.y)
			resize_area_bottom_left.point_a.set_position (0, - 20)			
			resize_area_bottom_left.point_b.set_position (20, 20)

			half_height := body.point_b.y // 2
			half_width := body.point_b.x // 2
			if name_is_top then
				name_mover.point.set_y (- half_height - name_area_bottom)
				name_area.point_a.set_y (- half_height - name_area_bottom)
			elseif name_is_bottom then
				name_mover.point.set_y (half_height)
				name_area.point_a.set_y (half_height)
			elseif name_is_left then
				name_mover.point.set_x (- half_width - name_area_right)
				name_area.point_a.set_x (- half_width - name_area_right)
			elseif name_is_right then
				name_mover.point.set_x (half_width)
				name_area.point_a.set_x (half_width)
			end

			if name_is_top or name_is_bottom then
				name_shift_x := center_point.x + name_area_left + name_area_right - a_width
				if name_shift_x > 0 then
					name_mover.point.set_x ((name_area_left - name_shift_x).max (- half_width))
					name_area.point_a.set_x ((name_area_left - name_shift_x).max (- half_width))
				else
					name_mover.point.set_x (name_area_left.max (- half_width))
					name_area.point_a.set_x (name_area_left.max (- half_width))
				end
			end
			if name_is_right or name_is_left then
				name_shift_y := center_point.y + name_area_top + name_area_bottom - a_height
				if name_shift_y > 0 then
					name_mover.point.set_y ((name_area_top - name_shift_y).max (- half_height))
					name_area.point_a.set_y ((name_area_top - name_shift_y).max (- half_height))
				else
					name_mover.point.set_y (name_area_top.max (- half_height))
					name_area.point_a.set_y (name_area_top.max (- half_height))
				end
			end

				-- Move other clusters to make room for resized `Current'.
			--parent.arrange_clusters
		end
	
	set_active (b: BOOLEAN) is
			-- Highlight `Current' if `b' `True'.
		do
		end

	update_edge_point (p: EV_RELATIVE_POINT; angle: REAL) is
			-- Move `p', which is relative to `Current', to a point on the
			-- edge where the outline intersects a line from the center point
			-- in direction `angle'.
		local
			new_x, new_y: REAL
		do
			p.change_origin (center_point)
			new_x := body_width.max (body_height) * cosine (angle)
			new_y := body_width.max (body_height) * sine (angle)
			if new_x <= body_width // 2 and new_x >= - body_width // 2 then
				if new_y >= 0 then
					p.set_position (new_x.truncated_to_integer, body_height // 2)
				else
					p.set_position (new_x.truncated_to_integer, - body_height // 2)	
				end
			elseif new_y <= body_height // 2 and new_y >= - body_height // 2 then
				if new_x >= 0 then
					p.set_position (body_width // 2, new_y.truncated_to_integer)
				else
					p.set_position (- body_width // 2, new_y.truncated_to_integer)	
				end
			end
		end

	reset_name_position is
			-- Set all `name_is_xxxx' attributes to False.
		do
			name_is_top := False
			name_is_bottom := False
			name_is_left := False
			name_is_right := False
		end
		
	set_minimum_bounds (a_left, a_top, a_right, a_bottom: INTEGER) is
			-- Assign minimum bounds.
		local
			max_left, max_top, name_w, name_h: INTEGER
			w_scale_x, w_scale_y: DOUBLE
		do
			name_w := name_area.point_b.x
			name_h := name_area.point_b.y
			w_scale_x := world.point.scale_x
			w_scale_y := world.point.scale_y
			max_left := a_left - left -- EA: - right + a_right
			max_top := a_top - top --EA: - bottom + a_bottom

			resizer_bottom_right.set_minimum_x (((a_right - left) / w_scale_x).rounded.max (name_w))
			resizer_bottom_right.set_minimum_y (((a_bottom - top) / w_scale_y).rounded.max (name_h))
			resizer_top_left.set_maximum_x (max_left)
			resizer_top_left.set_maximum_y (max_top)
			resizer_top_right.set_minimum_x (((a_right - left) / w_scale_x).rounded.max (name_w))
			resizer_top_right.set_maximum_y (max_top)
			resizer_bottom_left.set_maximum_x (max_left)
			resizer_bottom_left.set_minimum_y (((a_bottom - top) / w_scale_y).rounded.max (name_h))
		end

	set_bounds (a_left, a_top, a_right, a_bottom: INTEGER) is
			-- Assign bounds.
		require else
			is_not_iconified: not iconified
		local
			new_x, new_y, p_x, p_y: INTEGER
			scx, scy: DOUBLE
			tmp, l_point: EV_RELATIVE_POINT
			parent_fig, clf: CLUSTER_FIGURE
			cf: CLASS_FIGURE
		do
			parent_fig ?= parent
			new_x := a_left
			new_y := a_top
			scx := cluster_diagram.scale_x
			scy := cluster_diagram.scale_y

			create tmp.make_with_position (new_x, new_y)
			if parent_fig /= Void then
				tmp.change_origin (parent_fig.point)
			else
				tmp.change_origin (cluster_diagram.point)
			end

			from
				subclusters.start
			until
				subclusters.after
			loop
				clf := subclusters.item
				clf.change_origin (tmp)
				l_point := clf.point
				l_point.set_position (
					(l_point.x / scx).rounded,
					(l_point.y / scy).rounded)
				subclusters.forth
			end

			from
				classes.start
			until
				classes.after
			loop
				cf := classes.item
				cf.change_origin (tmp)
				l_point := cf.point
				l_point.set_position (
					(l_point.x / scx).rounded,
					(l_point.y / scy).rounded)
				classes.forth
			end

--			if parent_fig /= Void then
--				point.set_position (
--					((new_x - parent_fig.left) / scx).rounded,
--					((new_y - parent_fig.top) / scy).rounded)
--			else
--				point.set_position (
--					((new_x - world.point.x) / scx).rounded,
--					((new_y - world.point.y) / scy).rounded)
--			end
			point.set_position (((new_x - body.point_a.x_abs) / scx).rounded + point.x,
			((new_y - body.point_a.y_abs) / scx).rounded + point.y)
			
			p_x := point.x
			p_y := point.y
			
			snap_to_default_grid
			
			p_x := p_x - point.x
			p_y := p_y - point.y
			
			from
				subclusters.start
			until
				subclusters.after
			loop
				clf := subclusters.item
				clf.change_origin (point)
				l_point := clf.point
				l_point.set_position (
					(l_point.x / scx).rounded,
					(l_point.y / scy).rounded)
				clf.snap_to_default_grid
				subclusters.forth
			end

			from
				classes.start
			until
				classes.after
			loop
				cf := classes.item
				cf.change_origin_current_cluster (point)
				l_point := cf.point
				l_point.set_position (
					(l_point.x / scx).rounded,
					(l_point.y / scy).rounded)
				cf.snap_to_default_grid
				classes.forth
			end
			set_size (
				((a_right - a_left) / scx).rounded + p_x,
				((a_bottom - a_top) / scy).rounded + p_y)
			update
		end

	update_minimum_size is
			-- Figures have been added/removed in `Current',
			-- minimum size should change.
		local
			rec: EV_RECTANGLE
			l, t, r, b: INTEGER
			new_left, new_top, new_right, new_bottom: INTEGER
			d: DOUBLE
			resize_needed: BOOLEAN
			clf: CLUSTER_FIGURE
		do
			if world /= Void then
    			rec := bounds
    			if rec.width /= 0 and then rec.height /= 0 then
	    			resize_needed := False
	    			new_left := body_left
	    			new_top := body_top
	    			new_right := body_left + body_width
	    			new_bottom := body_top + body_height
	    			l := rec.x - 1
	    			t := rec.y - 1
	    			r := rec.width + l + 2
	    			b := rec.height + t + 2
	    			if r > new_right  then
	    				d := world.grid_x
	    				d := (r - new_right) / d
	    				new_right := new_right + d.ceiling * world.grid_x
	    				resize_needed := True
	    			end
	    			if b > new_bottom then
	    				d := world.grid_y
	    				d := (b - new_bottom) / d
	    				new_bottom := new_bottom + d.ceiling * world.grid_y
	    				resize_needed := True
	    			end
	    			if l < new_left then
	    				d := world.grid_x
	    				d := (new_left - l) / d
	    				new_left := new_left - d.ceiling * world.grid_x
	    				resize_needed := True
	    			end
	    			if t < new_top then
	    				d := world.grid_y
	    				d := (new_top - t) / d
	    				new_top := new_top - d.ceiling * world.grid_y
	    				resize_needed := True
	    			end
	    			if resize_needed then
	    				set_bounds (new_left, new_top, new_right, new_bottom)	
	    			end
	    			set_minimum_bounds (l, t, r, b)
	    		else
	    			set_minimum_bounds (right - minimum_width - 20, bottom - 20, left + minimum_width + 20, top + 20)
    			end
    			
    			clf ?= parent
    			if clf /= Void then
    				clf.update_minimum_size
    			else
    				if cluster_diagram.context_editor /= Void then
	    				cluster_diagram.context_editor.update_bounds (cluster_diagram)
    				end
    			end
			end
		end

	set_relative_position_and_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Assign bounds.
		do
			point.set_x (a_x)
			point.set_y (a_y)
			if iconified then
				old_width := a_width
				old_height := a_height
			else
				set_size (a_width, a_height)
			end
			update
		end

	iconify is
			-- Iconify `Current'.
		do
			if not iconified then
				old_width := body_width
				old_height := body_height
				body.set_background_color (bon_cluster_iconified_fill_color)
				resizer_bottom_right.disable_sensitive
				resizer_top_left.disable_sensitive
				resizer_top_right.disable_sensitive
				resizer_bottom_left.disable_sensitive
				iconified := True
				from
					subclusters.start
				until
					subclusters.after
				loop
					subclusters.item.mask
					subclusters.forth
				end
				from
					classes.start
				until
					classes.after
				loop
					classes.item.mask
					classes.forth
				end
				
				set_size (0, 0)
			end
		end

	deiconify is
			-- Deiconify `Current'.
		do
			if iconified then
				body.set_background_color (bon_cluster_fill_color)
				resizer_bottom_right.enable_sensitive
				resizer_top_left.enable_sensitive
				resizer_top_right.enable_sensitive
				resizer_bottom_left.enable_sensitive
				iconified := False
				from
					subclusters.start
				until
					subclusters.after
				loop
					subclusters.item.unmask
					subclusters.forth
				end
				from
					classes.start
				until
					classes.after
				loop
					classes.item.unmask
					classes.forth
				end
				set_size (old_width, old_height)
			end
		end

	mask is
			-- `Current' no longer needs to be displayed.
		do
			hide
			disable_sensitive
			from
				subclusters.start
			until
				subclusters.after
			loop
				subclusters.item.mask
				subclusters.forth
			end
			from
				classes.start
			until
				classes.after
			loop
				classes.item.mask
				classes.forth
			end
		end

	unmask is
			-- `Current' needs to be displayed again.
		do
			show
			enable_sensitive
			from
				subclusters.start
			until
				subclusters.after
			loop
				subclusters.item.unmask
				subclusters.forth
			end
			from
				classes.start
			until
				classes.after
			loop
				classes.item.unmask
				classes.forth
			end
		end

feature {BON_DIAGRAM_FACTORY} -- Drawing

	draw is
			-- Do a quick draw on `drawable'.
		local
			fig_txt: EV_FIGURE_TEXT
			name_font: EV_FONT
			d: like drawable
		do
			d := drawable
			d.enable_dashed_line_style
			d.set_foreground_color (bon_cluster_line_color)
			d.set_line_width (1)
			d.draw_polyline (offset_coordinates (body.polygon_array), True)
		
			d.draw_polyline (offset_coordinates (name_area.polygon_array), True)
			d.disable_dashed_line_style			

			d.set_foreground_color (bon_cluster_name_color)
			from
				name_figures.start
			until
				name_figures.after
			loop
				fig_txt := name_figures.item
				create name_font.make_with_values (
					fig_txt.font.family,
					fig_txt.font.weight,
					fig_txt.font.shape,
					fig_txt.font.height)
				name_font.set_height ((name_font.height * cluster_diagram.point.scale_y).rounded)
				d.set_font (name_font)
				d.draw_text_top_left (
					fig_txt.point.x_abs - drawable_position.x,
					fig_txt.point.y_abs - drawable_position.y,
					fig_txt.text
				)
				name_figures.forth
			end

		end

feature {LINKABLE_FIGURE_GROUP} -- XML

	xml_element (a_parent: XML_ELEMENT): XML_ELEMENT is
			-- XML representation.
		do
			create Result.make (a_parent, "CLUSTER_FIGURE")
			Result.attributes.add_attribute (create {XML_ATTRIBUTE}.make ("NAME", cluster_i.cluster_name))
			Result.put_last (xml_node (Result, "ICONIFIED", iconified.out))
			Result.put_last (xml_node (Result, "X_POS", point.x.out))
			Result.put_last (xml_node (Result, "Y_POS", point.y.out))
			if iconified then
				Result.put_last (xml_node (Result, "WIDTH", old_width.out))
				Result.put_last (xml_node (Result, "HEIGHT", old_height.out))
			else
				Result.put_last (xml_node (Result, "WIDTH", body_width.out))
				Result.put_last (xml_node (Result, "HEIGHT", body_height.out))
			end
		end

	set_with_xml_element (an_element: XML_ELEMENT) is
			-- Set attributes from XML element.
		require else
			an_element_is_cluster_figure: an_element.name.is_equal ("CLUSTER_FIGURE")
			an_element_has_name_attribute: an_element.attributes.has ("NAME")
			an_element_name_is_cluster_name:
				an_element.attributes.item ("NAME").value.is_equal (cluster_i.cluster_name)
		local
			x_pos, y_pos, w, h: INTEGER
			was_iconified: BOOLEAN
		do
			reset_valid_tags 
			was_iconified := xml_boolean (an_element, "ICONIFIED")
			if was_iconified then
				iconify
			else
				deiconify
			end
			x_pos := xml_integer (an_element, "X_POS")
			y_pos := xml_integer (an_element, "Y_POS")
			w := xml_integer (an_element, "WIDTH")
			h := xml_integer (an_element, "HEIGHT")
			set_relative_position_and_size (x_pos, y_pos, w, h)
		end

feature {NONE} -- Implementation

	arrange_clusters is
			-- Items of `subclusters' need to be moved.
		do
			layout.arrange_clusters (Current)
			parent.arrange_clusters
		end

	position_strictly_on_figure (x, y: INTEGER): BOOLEAN is
   			-- Is the point on (`x', `y') on this figure?
			-- (excluding its subclusters).
		do
			Result := body.position_on_figure (x, y)
			from
				subclusters.start
			until
				subclusters.after or not Result
			loop
				if subclusters.item.position_on_figure (x, y) then
					Result := False
				end
				subclusters.forth
			end
		end

	position_on_figure (x, y: INTEGER): BOOLEAN is
   			-- Is the point on (`x', `y') on this figure?
		do
			Result := body.position_on_figure (x, y)
		end

	saved_x: INTEGER
			-- Backup of `Current' X-coordinate.

	saved_y: INTEGER
			-- Backup of `Current' Y-coordinate.

feature {NONE} -- Implementation

	old_top: INTEGER
			-- Backup of `top' for resizing.

	old_left: INTEGER
			-- Backup of `left' for resizing.

	old_bottom: INTEGER
			-- Backup of `bottom' for resizing.

	old_right: INTEGER
			-- Backup of `right' for resizing.

	old_width: INTEGER
			-- Backup of `width' for iconifying.

	old_height: INTEGER
 			-- Backup of `height' for iconifying.

	body_width: INTEGER is
			-- width of `body'.
		do
			Result := body.point_b.x
		end
		
	body_height: INTEGER is
			-- height of `body'.
		do
			Result := body.point_b.y
		end

	body_top: INTEGER is
			-- top of `body'.
		do
			Result := body.point_a.y_abs
		end

	body_left: INTEGER is
			-- left of `body'.
		do
			Result := body.point_a.x_abs
		end


	Max_backup: INTEGER is 7
			-- Break at underscores, but do not search further than this index.

	build_figure is 
			-- Build graphical representation from recently updated structure.
		do
			extend (body)
			extend (name_area)
			add_name_figure (name)
			layout_figures
	
			iconified := False

			name_mover.point.set_position (- body.point_b.x // 2, - body.point_b.y // 2 - name_area.point_b.y)
			name_moving_area.point_b.set_position (name_area.point_b.x, name_area.point_b.y)
			name_area.point_a.set_position (- body.point_b.x // 2, - body.point_b.x // 2 - name_area.point_b.y)

			resizer_bottom_right.set_minimum_x (name_area.point_b.x)
			resizer_bottom_right.set_minimum_y (name_area.point_b.y)
			resizer_bottom_right.point.set_position (body.point_b.x, body.point_b.y)
			
			resizer_top_left.set_maximum_x (0)
			resizer_top_left.set_maximum_y (0)
			resizer_top_left.point.set_position (0, 0)		

			resizer_top_right.set_minimum_x (name_area.point_b.x)
			resizer_top_right.set_maximum_y (0)
			resizer_top_right.point.set_position (body.point_b.x, 0)		

			resizer_bottom_left.set_maximum_x (0)
			resizer_bottom_left.set_minimum_y (name_area.point_b.y)
			resizer_bottom_left.point.set_position (0, body.point_b.y)		
		end

	layout_figures is 
			-- Set all figures to a nice position relative to `point'.
		local
			name_y : INTEGER
			max_token_length: INTEGER
			nf: EV_FIGURE_TEXT
		do
			name_y := 1
			from
				name_figures.start
			until
				name_figures.after
			loop
				nf := name_figures.item
				if nf.width > max_token_length then
					max_token_length := nf.width
				end
				nf.point.set_position (nf.width // 4, name_y)
				name_y := name_y + nf.height
				name_figures.forth
			end
			name_mover.point.set_position (- body.point_b.x // 2, - body.point_b.y // 2 - (name_y + 2))
			name_area.point_a.set_position (- body.point_b.x // 2, - body.point_b.y // 2 - (name_y + 2))
			name_area.point_b.set_position (max_token_length * 3 // 2, name_y + 2) 
			reset_name_position
			name_is_top := True
		end

	add_name_figure (n: STRING) is
			-- Add first characters as name figure, then call recursively.
		local
			name_figure: EV_FIGURE_TEXT
			s, rest: STRING
			i: INTEGER
		do
			if n.count > max_cluster_name_length then
				i := n.last_index_of ('_', max_cluster_name_length)
				if i < Max_backup then
					i := max_cluster_name_length
				end
				s := n.substring (1, i)
				rest := n.substring (i + 1, n.count)
			else
				s := clone (n)
			end

			create name_figure
			name_figure.set_foreground_color (bon_cluster_name_color)
			name_figure.set_text (s)
			name_figure.point.set_origin (name_area.point_a)
			name_figures.extend (name_figure)
			extend (name_figure)

			broken_name.append (s)
			if rest /= Void then
				broken_name.extend ('%N')
				add_name_figure (rest)
			end
		end

feature {CLUSTER_DIAGRAM} -- Events

	on_origin_moved (x_delta, y_delta: INTEGER) is
			-- Diagram origin has moved.
		do
			old_top := old_top + y_delta
			old_left := old_left + x_delta
			old_right := right
			old_bottom := bottom
		end

feature {CLUSTER_FIGURE} -- Events

	move_to_front is
			-- Make `Current' appear in front of its peers.
		local
			w: CLUSTER_DIAGRAM
			g: EV_FIGURE_GROUP
		do
			if subclusters.is_empty then
				w := cluster_diagram
				if w /= Void then
					g := w.cluster_layer
					g.prune_all (Current)
					g.extend (Current)
					w.full_redraw_performed
				end
			end
		end

	save_position is
			-- Make a backup of current coordinates.
		do
			saved_x := point.x
			saved_y := point.y
		end 

	extend_history is
			-- Register beginning move in the history.
		local
			new_cluster_figure: CLUSTER_FIGURE
--			saved_x_abs, saved_y_abs: INTEGER
		do
			new_cluster_figure := cluster_diagram.smallest_cluster_containing_point (x_position, y_position)
			if new_cluster_figure = cluster_figure then
					-- Current has been moved inside its parent if it has one
				cluster_diagram.context_editor.history.do_named_undoable (
					"Move cluster",
					[<<point~set_position (point.x, point.y),
						~update_and_project>>],
					[<<point~set_position (saved_x, saved_y),
						~update_and_project>>])
			else
					point.set_position (saved_x, saved_y)
					update_and_project
			end
--			if new_cluster_figure = Void and cluster_figure /= Void then
--					-- Current has a parent but has been moved out of any cluster
--					-- It should be put back in its parent.
--				cluster_diagram.context_editor.history.do_named_undoable (
--					Interface_names.t_Diagram_move_class_cmd,
--					[<<	point~set_position (
--							((point.x_abs - cluster_diagram.point.x) / cluster_diagram.scale_x).rounded,
--							((point.y_abs - cluster_diagram.point.y) / cluster_diagram.scale_y).rounded),
--						cluster_diagram~on_move_cluster_end (Current, new_cluster_figure),
--						~update_and_project>>],
--					[<<cluster_diagram~on_move_cluster_end (Current, cluster_figure),
--						point~set_position (saved_x, saved_y),
--						~update_and_project>>])
--			elseif cluster_figure = Void and new_cluster_figure /= Void then
--					-- Current does not have a parent but has been moved into another cluster
--
--				cluster_diagram.context_editor.history.do_named_undoable (
--					Interface_names.t_Diagram_move_class_cmd,
--					[<<cluster_diagram~on_move_cluster_end (Current, new_cluster_figure),
--						point~set_position (
--							((point.x_abs - new_cluster_figure.point.x_abs) /
--								new_cluster_figure.point.scale_x_abs).rounded,
--							((point.y_abs - new_cluster_figure.point.y_abs) /
--								new_cluster_figure.point.scale_y_abs).rounded),
--						~update_and_project>>],
--					[<<cluster_diagram~on_move_cluster_end (Current, cluster_figure),
--						point~set_position (saved_x, saved_y),
--						~update_and_project>>])
--			elseif new_cluster_figure /= cluster_figure then
--					-- Current has a parent and has been moved in another cluster
--				saved_x_abs := (saved_x * cluster_figure.point.scale_x_abs).rounded + cluster_figure.point.x_abs
--				saved_y_abs := (saved_y * cluster_figure.point.scale_y_abs).rounded + cluster_figure.point.y_abs
--				cluster_diagram.context_editor.history.do_named_undoable (
--				Interface_names.t_Diagram_move_class_cmd,
--					[<<cluster_diagram~on_move_cluster_end (Current, new_cluster_figure),
--						point~set_position (
--							((point.x_abs - new_cluster_figure.point.x_abs) /
--								new_cluster_figure.point.scale_x_abs).rounded,
--							((point.y_abs - new_cluster_figure.point.y_abs) /
--								new_cluster_figure.point.scale_y_abs).rounded),
--						~update_and_project>>],
--					[<<cluster_diagram~on_move_cluster_end (Current, cluster_figure),
--						point~set_position (saved_x, saved_y),
--						~update_and_project>>])	
--			else
--					-- Current has been moved inside its parent if it has one
--				cluster_diagram.context_editor.history.do_named_undoable (
--					"Move cluster",
--					[<<point~set_position (point.x, point.y),
--						~update_and_project>>],
--					[<<point~set_position (saved_x, saved_y),
--						~update_and_project>>])	
--			end
		end

feature {NONE} -- Events

	button_press (x, y, b: INTEGER; xt, yt, p: DOUBLE; sx, sy: INTEGER) is
			-- User pressed pointer button on `Current'.
		local
			pebble_as_stone: STONE
		do
			if b = 3 and then ctrl_pressed then
				pebble_as_stone ?= pebble
				if pebble_as_stone /= Void and then pebble_as_stone.is_valid then
					(create {EB_CONTROL_PICK_HANDLER}).launch_stone (pebble_as_stone)
				end
			end
		end

	on_resizer_bottom_right_move (x, y: INTEGER) is
			-- Resizer moved relatively to `x', `y'.
		do
			set_size (x, y)
			update
		end

	on_resizer_start is
			-- User started resizing.
		do
			old_top := body_top
			old_left := body_left
			old_right := body_left + body_width
			old_bottom := body_top + body_height
		end
		
	on_resizer_top_left_move (x, y: INTEGER) is
			-- Resizer moved relatively to `x', `y'.
		do
			set_bounds (
				old_left + (x * point.origin.scale_x_abs).rounded,
				old_top + (y * point.origin.scale_y_abs).rounded,
				old_right,
				old_bottom)
		end

	on_resizer_end is
			-- User ended resizing.
		do
			update_minimum_size
			update_cluster_size
			update_area_bounds
		end

	on_resizer_top_right_move (x, y: INTEGER) is
			-- Resizer moved relatively to `x', `y'.
		do
			set_bounds (
				old_left,
				old_top + (y * point.origin.scale_y_abs).rounded,
				old_left + (x * point.origin.scale_x_abs).rounded,
				old_bottom)
		end

	on_resizer_bottom_left_move (x, y: INTEGER) is
			-- Resizer moved relatively to `x', `y'.
		do
			set_bounds (
				old_left + (x * point.origin.scale_x_abs).rounded,
				old_top,
				old_right,
				old_top + (y * point.origin.scale_y_abs).rounded)
		end

	on_name_double_click (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Switch between iconified/deiconified representation.
		do
			if iconified then
				deiconify
			else
				iconify
			end
		end

	update_cluster_size is
			-- Minimum size of `parent' needs to be updated
			-- according to `Current' last move.
		do
			if cluster_figure /= Void then
				if cluster_figure.position_on_figure (left, top) or else
					cluster_figure.position_on_figure (right, bottom) or else
					cluster_figure.position_on_figure (right, top) or else
					cluster_figure.position_on_figure (left, bottom) then
						cluster_figure.update_minimum_size
				end
			end
		end

	update_area_bounds is
			-- Bounds of drawable area may need to be updated because of
			-- `Current' last move.
		do
			cluster_diagram.context_editor.update_bounds (cluster_diagram)
		end

	update_scrollable_area_size is
			-- Minimum size of the scrollable area needs to be updated
			-- according to `Current' last move.
		do
			cluster_diagram.context_editor.on_figure_moved
		end

	reset_mover_coordinates (x, y: INTEGER): TUPLE [INTEGER, INTEGER] is
			-- Restore the right coordinates of `name_mover',
			-- and move `name_area'.
		local
			adjust_x, adjust_y: REAL
			name_area_width, name_area_height: INTEGER
		do
			name_area_width := name_area.point_b.x
			name_area_height := name_area.point_b.y
			adjust_x := x / body_width
			adjust_y := y / body_height
			if adjust_y.abs > adjust_x.abs then
				if adjust_y >= 0 then
					Result := [x.min (body_width // 2 - name_area_width).max (- body_width // 2), body_height // 2]
					name_area.point_a.set_position (x.min (body_width // 2 - name_area_width).max (- body_width // 2), body_height // 2)
					reset_name_position
					name_is_bottom := True
				else
					Result := [x.min (body_width // 2 - name_area_width).max (- body_width // 2), - body_height // 2 - name_area_height]
					name_area.point_a.set_position (x.min (body_width // 2 - name_area_width).max (- body_width // 2), - body_height // 2 - name_area_height)
					reset_name_position
					name_is_top := True
				end
			else
				if adjust_x >= 0 then
					Result := [body_width // 2, y.max (- body_height // 2).min (body_height // 2)]
					name_area.point_a.set_position (body_width // 2, y.max (- body_height // 2).min ( body_height // 2 - name_area_height))
					reset_name_position
					name_is_right := True
				else
					Result := [- body_width // 2 - name_area_width, y.max (- body_height // 2).min (body_height // 2)]
					name_area.point_a.set_position (- body_width // 2 - name_area_width, y.max (- body_height // 2).min ( body_height // 2 - name_area_height))
					reset_name_position
					name_is_left := True
				end
			end
		end

feature {NONE} -- Implementation

	minimum_width: INTEGER is
			-- 
		do
			if name_figures /= Void then
				from
					name_figures.start
				until
					name_figures.after
				loop
					Result := (name_figures.item.width).max (Result)
					name_figures.forth
				end
			end
		end


end -- class BON_CLUSTER_FIGURE
