indexing
	description:
		"EiffelVision Tree, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I
		redefine
			interface,
			initialize,
			wipe_out,
			call_pebble_function,
			append
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			destroy,
			initialize,
			button_press_switch,
			create_pointer_motion_actions,
			set_to_drag_and_drop,
			able_to_transport,
			ready_for_pnd_menu,
			enable_transport,
			disable_transport,
			start_transport_filter,
			pre_pick_steps,
			post_drop_steps,
			call_pebble_function,
			pointer_over_widget,
			visual_widget
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		redefine
			interface,
			remove_i_th,
			reorder_child,
			i_th,
			add_to_container,
			list_widget,
			count,
			wipe_out,
			append,
			initialize,
			visual_widget
		end

	EV_TREE_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty Tree.
		do
			base_make (an_interface)
			set_c_object (C.gtk_scrolled_window_new (NULL, NULL))
			C.gtk_scrolled_window_set_policy (
				c_object, 
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)
			C.gtk_scrolled_window_set_placement (c_object, C.gtk_corner_top_left_enum)

			list_widget := C.gtk_ctree_new (1, 0)
			
			C.gtk_ctree_set_line_style (list_widget, C.GTK_CTREE_LINES_DOTTED_ENUM)
			C.gtk_clist_set_selection_mode (list_widget, C.GTK_SELECTION_BROWSE_ENUM)
			C.gtk_ctree_set_expander_style (list_widget, C.GTK_CTREE_EXPANDER_SQUARE_ENUM)
			C.gtk_clist_set_shadow_type (list_widget, C.GTK_SHADOW_NONE_ENUM)
			C.gtk_ctree_set_show_stub (list_widget, True)
			C.gtk_ctree_set_indent (list_widget, 17)
			C.gtk_widget_show (list_widget)
			--C.gtk_container_add (c_object, list_widget)
			C.gtk_scrolled_window_add_with_viewport (c_object, list_widget)
			
			create ev_children.make (0)
				-- Make initial hash table with room for 100 child pointers, may be increased later.
		
			create tree_node_ptr_table.make (100)
			create timer.make_with_interval (0)
			timer.actions.extend (agent on_time_out)
		end
	
	tree_width: INTEGER
	
	timer: EV_TIMEOUT
	
	on_time_out is
			-- 
		local
			a_wid: INTEGER
		do
			a_wid := C.gtk_clist_columns_autosize (list_widget) + 16
			if tree_width /= a_wid then
				C.gtk_widget_set_usize (list_widget, a_wid, -1)
				tree_width := a_wid
			end
			timer.set_interval (0)
		end
	
	visual_widget: POINTER is
			-- 
		do
			Result := list_widget
		end

	initialize is
			-- Connect action sequences to signals.
		do
			{EV_ITEM_LIST_IMP} Precursor
			{EV_PRIMITIVE_IMP} Precursor
			{EV_TREE_I} Precursor
			
			--| Event position 1 in intermediary
			real_signal_connect (
				list_widget,
				"tree-select-row",
				agent gtk_marshal.on_tree_event_intermediary (c_object, 1, ?),
				agent gtk_marshal.gtk_value_pointer_to_tuple
			)
			
			real_signal_connect (
				list_widget,
				"tree-unselect-row",
				agent gtk_marshal.on_tree_event_intermediary (c_object, 2, ?),
				agent gtk_marshal.gtk_value_pointer_to_tuple
			)

			real_signal_connect (
				list_widget,
				"tree-expand",
				agent gtk_marshal.on_tree_event_intermediary (c_object, 3, ?),
				agent gtk_marshal.gtk_value_pointer_to_tuple
			)

			real_signal_connect (
				list_widget,
				"tree-collapse",
				agent gtk_marshal.on_tree_event_intermediary (c_object, 4, ?),
				agent gtk_marshal.gtk_value_pointer_to_tuple
			)
			connect_button_press_switch
				-- Needed so items are always hooked up, even though widget may not need to be.
		end

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

	gtk_value_pointer_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [POINTER] is
			-- Tuple containing integer value from first of `args'.
		do
			gtk_marshal.pointer_tuple.put (gtk_marshal.gtk_value_pointer (args), 1)
			Result := gtk_marshal.pointer_tuple
			--	Result := [gtk_marshal.gtk_value_pointer (args)]
		end

	button_press_switch (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
			tree_item_imp: EV_TREE_NODE_IMP

		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]

			tree_item_imp := row_from_y_coord (a_y)
	
			if a_type = C.GDK_BUTTON_PRESS_ENUM then
				if not is_transport_enabled and then pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
				if 
					tree_item_imp /= Void and then
					tree_item_imp.pointer_button_press_actions_internal /= Void then
						tree_item_imp.pointer_button_press_actions_internal.call (t)
				end

			elseif a_type = C.GDK_2BUTTON_PRESS_ENUM then
				if pointer_double_press_actions_internal /= Void then
					pointer_double_press_actions_internal.call (t)
				end
				if 
					tree_item_imp /= Void and then
					tree_item_imp.pointer_double_press_actions_internal /= Void then
						tree_item_imp.pointer_double_press_actions_internal.call (t)
				end
			end
        	end

	motion_handler (a_x, a_y: INTEGER; a_a, a_b, a_c: DOUBLE; a_d, a_e: INTEGER) is
		local
			t: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
			a_row_imp: EV_TREE_NODE_IMP
		do
			t := [a_x, a_y, a_a, a_b, a_c, a_d, a_e]
			if pointer_motion_actions_internal /= Void then
				pointer_motion_actions_internal.call (t)
			end

			a_row_imp := row_from_y_coord (a_y)
			if a_row_imp /= Void then
				if a_row_imp.pointer_motion_actions_internal /= Void then
					a_row_imp.pointer_motion_actions_internal.call (t)
				end
			end
		end
		
feature {EV_APPLICATION_IMP} -- Implementation

	pointer_over_widget (a_gdkwin: POINTER; a_x, a_y: INTEGER): BOOLEAN is
			-- Is mouse pointer hovering above list.
		local
			gdkwin_parent, gdkwin_parent_parent: POINTER
			clist_parent: POINTER
			pnd_row: EV_TREE_NODE_IMP
		do
			if is_displayed then
				gdkwin_parent := C.gdk_window_get_parent (a_gdkwin)
				if gdkwin_parent /= NULL then
					gdkwin_parent_parent := C.gdk_window_get_parent (gdkwin_parent)
				end
				clist_parent := C.gdk_window_get_parent (
					C.gtk_clist_struct_clist_window (list_widget)
				)
				Result := gdkwin_parent = clist_parent or
					gdkwin_parent_parent = clist_parent

				if clist_parent = gdkwin_parent then
					pnd_row := row_from_y_coord (a_y)
					if pnd_row /= Void and then pnd_row.drop_actions_internal /= Void then
						Result := False
					end
				end
			end
		end

feature {EV_TREE_NODE_IMP} -- Implementation

	tree_node_ptr_table: HASH_TABLE [EV_TREE_NODE_IMP, POINTER]
			-- Hash table linking tree node pointers to eiffel implementation objects.

feature {NONE} -- Implementation
	
	cached_width: INTEGER

	dummy_tree_node: POINTER
		-- Added to prevent seg fault on wipeout by adding temporarily
		
feature {EV_GTK_CALLBACK_MARSHAL} -- Implementation

	expand_callback (a_tree_item: POINTER) is
			-- Expand callback passing expanded `a_tree_item' node pointer.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			--C.gtk_clist_freeze (list_widget)
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void then
				a_tree_node_imp.expand_callback
			end
			if timer.interval = 0 then
				timer.set_interval (500)
			end
			
			--C.gtk_clist_thaw (list_widget)
		end

	collapse_callback (a_tree_item: POINTER) is
			-- Collapse callback passing collapsed `a_tree_item' node pointer.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			C.gtk_clist_freeze (list_widget)
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void then
				a_tree_node_imp.collapse_callback
			end
			C.gtk_clist_thaw (list_widget)
			if timer.interval = 0 then
				timer.set_interval (500)
			end
		end
		
	selected_node: EV_TREE_NODE_IMP

	select_callback (a_tree_item: POINTER) is
			-- Called when a tree item is selected
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do		
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void and then a_tree_node_imp /= selected_node then
				if select_actions_internal /= Void then
					select_actions_internal.call (empty_tuple)
				end
				if a_tree_node_imp.select_actions_internal /= Void then
					a_tree_node_imp.select_actions_internal.call (empty_tuple)
				end
			end
			selected_node := a_tree_node_imp
		end
		
	deselect_callback (a_tree_item: POINTER) is
			-- Called when a tree item is deselected.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void and selected_node /= Void then
				if deselect_actions_internal /= Void then
					deselect_actions_internal.call (empty_tuple)
				end
				if a_tree_node_imp.deselect_actions_internal /= Void then
					a_tree_node_imp.deselect_actions_internal.call (empty_tuple)
				end
			end
		end

feature -- Status report

	selected_item: EV_TREE_NODE is
			-- Item which is currently selected.
		local
			temp_item_ptr: POINTER
		do	
			temp_item_ptr := C.gtk_clist_struct_selection (list_widget)			
			if temp_item_ptr /= NULL then
				temp_item_ptr := C.g_list_nth_data (temp_item_ptr, 0)
				-- This is incase of unwanted items due to wipeout hack.
				Result := tree_node_ptr_table.item (temp_item_ptr).interface
			end
		end

	selected: BOOLEAN is
			-- Is one item selected?
		do
			Result := selected_item /= Void
		end

feature -- Implementation

	set_to_drag_and_drop: BOOLEAN is
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_drag_and_drop
			else
				Result := mode_is_drag_and_drop
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is list or row able to transport PND data using `a_button'.
		do
			if pnd_row_imp /= Void then
				Result := (pnd_row_imp.mode_is_drag_and_drop and a_button = 1) or
				(pnd_row_imp.mode_is_pick_and_drop and a_button = 3)
			else
				Result := (mode_is_drag_and_drop and a_button = 1) or
				(mode_is_pick_and_drop and a_button = 3)
			end
		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN is
			-- Is list or row able to display PND menu using `a_button'
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_target_menu and then a_button = 3
			else
				Result := mode_is_target_menu and then a_button = 3
			end
		end

	enable_transport is
		do
			connect_pnd_callback
		end

	connect_pnd_callback is
		do

			check
				button_release_not_connected: button_release_connection_id = 0
			end
			if button_press_connection_id > 0 then
				signal_disconnect (button_press_connection_id)
			end
			signal_connect ("button-press-event", agent start_transport_filter, default_translate)
			button_press_connection_id := last_signal_connection_id
			is_transport_enabled := True
		end

	disable_transport is
		do
			Precursor
			update_pnd_status
		end

	update_pnd_status is
			-- Update PND status of list and its children.
		local
			a_enable_flag: BOOLEAN
			i: INTEGER
		do
			from
				ev_children.start
				i := 1
			until
				i > ev_children.count or else a_enable_flag
			loop
				ev_children.go_i_th (i)
				a_enable_flag := ev_children.item.is_transport_enabled_iterator
				i := i + 1
			end

			if not is_transport_enabled then
				if a_enable_flag or pebble /= Void then
					connect_pnd_callback
				end
			elseif not a_enable_flag and pebble = Void then
				disable_transport_signals
				is_transport_enabled := False
			end
		end

	start_transport_filter (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Initialize a pick and drop transport.
		do
			pnd_row_imp := row_from_y_coord (a_y)

			if pnd_row_imp /= Void and then not pnd_row_imp.able_to_transport (a_button) then
				pnd_row_imp := Void
			end
			
			if pnd_row_imp /= Void or else pebble /= Void then
				Precursor (
				a_type,
				a_x, a_y, a_button,
				a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y)
			end			
		end

	pnd_row_imp: EV_TREE_NODE_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: ANY

	temp_pebble_function: FUNCTION [ANY, TUPLE [], ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: EV_CURSOR

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Set `pebble' using `pebble_function' if present.
		do
			temp_pebble := pebble
			temp_pebble_function := pebble_function
			if pnd_row_imp /= Void then
				pebble := pnd_row_imp.pebble
				pebble_function := pnd_row_imp.pebble_function
			end

			if pebble_function /= Void then
				pebble_function.call ([a_x, a_y]);
				pebble := pebble_function.last_result
			end		
		end
	
	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Steps to perform before transport initiated.
		local
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			create env
			app_imp ?= env.application.implementation
			check
				app_imp_not_void: app_imp /= Void
			end

			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor
			app_imp.on_pick (pebble)

			if pnd_row_imp /= Void then
				if pnd_row_imp.pick_actions_internal /= Void then
					pnd_row_imp.pick_actions_internal.call ([a_x, a_y])
				end
				accept_cursor := pnd_row_imp.accept_cursor
				deny_cursor := pnd_row_imp.deny_cursor
			else
				if pick_actions_internal /= Void then
					pick_actions_internal.call ([a_x, a_y])
				end
			end

			pointer_x := a_screen_x
			pointer_y := a_screen_y

			if pnd_row_imp = Void then
				if (pick_x = 0 and then pick_y = 0) then
					x_origin := a_screen_x
					y_origin := a_screen_y
				else
					if pick_x > width then
						pick_x := width
					end
					if pick_y > height then
						pick_y := height
					end
					x_origin := pick_x + (a_screen_x - a_x)
					y_origin := pick_y + (a_screen_y - a_y)
				end
			else
				if (pnd_row_imp.pick_x = 0 and then pnd_row_imp.pick_y = 0) then
					x_origin := a_screen_x
					y_origin := a_screen_y
				else
					if pick_x > width then
						pick_x := width
					end
					if pick_y > row_height then
						pick_y := row_height
					end
					x_origin := pnd_row_imp.pick_x + (a_screen_x - a_x)
					y_origin := 
						pnd_row_imp.pick_y +
						(a_screen_y - a_y) + 
						((ev_children.index_of (pnd_row_imp, 1) - 1) * row_height)
				end
			end
		end

	post_drop_steps is
			-- Steps to perform once an attempted drop has happened.
		do
			if pnd_row_imp /= Void then
				if pnd_row_imp.mode_is_pick_and_drop then
					signal_emit_stop (c_object, "button-press-event")
				end
			elseif mode_is_pick_and_drop then
					signal_emit_stop (c_object, "button-press-event")
			end

			app_implementation.on_drop (pebble)
			x_origin := 0
			y_origin := 0
			last_pointed_target := Void	

			if pebble_function /= Void then
				if pnd_row_imp /= Void then
					pnd_row_imp.set_pebble_void
				else
					temp_pebble := Void
				end
			end

			accept_cursor := temp_accept_cursor
			deny_cursor := temp_deny_cursor
			pebble := temp_pebble
			pebble_function := temp_pebble_function

			temp_pebble := Void
			temp_pebble_function := Void
			temp_accept_cursor := Void
			temp_deny_cursor := Void

			pnd_row_imp := Void
		end
		
feature {EV_TREE_NODE_IMP}
		
	row_from_y_coord (a_y: INTEGER): EV_TREE_NODE_IMP is
		local
			temp_row_ptr: POINTER
		do
			temp_row_ptr := C.gtk_ctree_node_nth (list_widget, a_y // (row_height + 1))
			if temp_row_ptr /= NULL then
				Result := tree_node_ptr_table.item (temp_row_ptr)
			end
		end

feature {NONE} -- Implementation

	ensure_item_visible (an_item: EV_TREE_ITEM) is
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		local
			tree_item_imp: EV_TREE_ITEM_IMP
			node_ptr: POINTER
			item_imp: EV_TREE_NODE_IMP
		do
			C.gtk_clist_freeze (list_widget)
			tree_item_imp ?= an_item.implementation
			node_ptr := tree_item_imp.tree_node_ptr
			if not C.gtk_ctree_is_viewable (list_widget, node_ptr) then
				expand_to_node (node_ptr)
			end

			item_imp ?= an_item.implementation

				-- Show the node `an_item'
			C.gtk_ctree_node_moveto (list_widget, item_imp.tree_node_ptr, 0, 0.0, 1.0)
			C.gtk_clist_thaw (list_widget)
		end

	expand_to_node (a_node: POINTER) is
			-- 
		require
			a_node /= NULL
		local
			row, parent_node: POINTER
		do
			C.gtk_clist_freeze (list_widget)
			if not C.gtk_ctree_is_viewable (list_widget, a_node) then
				row := C.glist_struct_data (a_node)
				parent_node := C.gtk_ctree_row_struct_parent (row)
				if parent_node /= NULL then
					expand_to_node (parent_node)
					C.gtk_ctree_expand (list_widget, parent_node)
				end
			end
			C.gtk_clist_thaw (list_widget)
		end

	spacing: INTEGER is 3
			-- Spacing between pixmap and text.
			
	previous_selected_item: EV_TREE_NODE
			-- Item that was selected previously.

	count: INTEGER is
			-- Number of children
		do
			Result := ev_children.count
		end

	i_th (i: INTEGER): EV_TREE_NODE is
			-- `i'_th child of Current.
		do
			Result := (ev_children @ i).interface
		end
		
	append (s: SEQUENCE [EV_TREE_ITEM]) is
			-- 
		do
			C.gtk_clist_freeze (list_widget)
			Precursor (s)
			C.gtk_clist_thaw (list_widget)
		end

	add_to_container (v: like item) is
			-- Add `v' to tree.
		local
			item_imp: EV_TREE_NODE_IMP
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			item_imp.set_item_and_children (NULL)
			item_imp.check_branch_pixmaps
			ev_children.force (item_imp)
			update_pnd_status
		end

	wipe_out is
			-- Remove all items.
		local
			item_imp: EV_TREE_NODE_IMP
		do
				-- Remove all items (GTK part)
			C.gtk_clist_clear (list_widget)
			from
				ev_children.start
			until
				ev_children.after
			loop
				item_imp := ev_children.item
				item_imp.set_item_and_children (NULL)
				item_imp.set_parent_imp (Void)
				ev_children.forth
			end

				-- Remove all items (Eiffel part)
--			ev_children.wipe_out
--			child_array.wipe_out
			create ev_children.make (0)
			create child_array.make (5)
			tree_node_ptr_table.clear_all
			
			index := 0

			update_pnd_status
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_NODE_IMP
		do
			item_imp := (ev_children @ (a_position))

				-- Remove from tree
			C.gtk_ctree_remove_node (list_widget, item_imp.tree_node_ptr)
			item_imp.set_item_and_children (NULL)
			item_imp.set_parent_imp (Void)

				-- remove the row from the `ev_children'
			ev_children.go_i_th (a_position)
			ev_children.remove
			
			child_array.go_i_th (a_position)
			child_array.remove

			update_pnd_status
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position' in Current.
		local
			item_imp: EV_TREE_NODE_IMP
		do
			item_imp ?= v.implementation
			C.gtk_clist_row_move (list_widget, item_imp.index - 1, a_position - 1)
			ev_children.prune_all (item_imp)
			ev_children.go_i_th (a_position)
			ev_children.put_left (item_imp)	
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check  do_not_call: False end
		end

feature {EV_TREE_NODE_IMP} -- Implementation

	row_height: INTEGER is
			-- 
		do
			Result := C.gtk_clist_struct_row_height (list_widget)
		end

	insert_ctree_node (a_item_imp: EV_TREE_NODE_IMP; par_node, a_sibling: POINTER): POINTER is
		local
			text_ptr: POINTER
			a_gs: GEL_STRING
		do
			create a_gs.make (a_item_imp.text)
			text_ptr := a_gs.item
			Result := C.gtk_ctree_insert_node (
				list_widget,
				par_node,
				a_sibling,
				$text_ptr,
				spacing,
				NULL,
				NULL,
				NULL,
				NULL,
				False,
				False
			)
		end

	ev_children: ARRAYED_LIST [EV_TREE_NODE_IMP]
			-- Container for all root tree items.

	list_widget: POINTER
			-- Pointer to the gtktree widget.
			
feature {EV_ANY_I} -- Implementation

	interface: EV_TREE

end -- class EV_TREE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

