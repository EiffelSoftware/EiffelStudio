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
			call_pebble_function,
			append
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
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
			visual_widget,
			needs_event_box
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		rename
			list_widget as tree_view
		undefine
			destroy
		redefine
			interface,
			insert_i_th,
			remove_i_th,
			reorder_child,
			add_to_container,
			tree_view,
			append,
			initialize,
			visual_widget
		end

	EV_TREE_ACTION_SEQUENCES_IMP
	
	EV_PND_DEFERRED_ITEM_PARENT

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False
	
	scrollable_area: POINTER
		-- Pointer to the GtkScrolledWindow widget used for scrolling the tree view

	make (an_interface: like interface) is
			-- Create an empty Tree.
		do
			base_make (an_interface)
			scrollable_area := feature {EV_GTK_EXTERNALS}.gtk_scrolled_window_new (NULL, NULL)
			set_c_object (scrollable_area)
			tree_view := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_new
			feature {EV_GTK_EXTERNALS}.gtk_container_add (scrollable_area, tree_view)
		end

	call_selection_action_sequences is
			-- Call the appropriate selection action sequences
		local
			a_selected_item: EV_TREE_NODE
			a_selected_item_imp: EV_TREE_NODE_IMP
			previous_selected_item_imp: EV_TREE_NODE_IMP
		do
			a_selected_item := selected_item
			
			if a_selected_item /= previous_selected_item then
				if previous_selected_item /= Void then
					previous_selected_item_imp ?= previous_selected_item.implementation
					if previous_selected_item_imp.deselect_actions_internal /= Void then
						previous_selected_item_imp.deselect_actions_internal.call (app_implementation.empty_tuple)
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call (app_implementation.empty_tuple)
					end
				end	
				if a_selected_item /= Void then
					a_selected_item_imp ?= a_selected_item.implementation
					if a_selected_item_imp.select_actions_internal /= Void then
						a_selected_item_imp.select_actions_internal.call (app_implementation.empty_tuple)
					end
					if select_actions_internal /= Void then
						select_actions_internal.call (app_implementation.empty_tuple)
					end
				end
			end
			previous_selected_item := a_selected_item
		end
	
	visual_widget: POINTER is
			-- Visible widget on screen.
		do
			Result := tree_view
		end

	initialize is
			-- Connect action sequences to signals.
		local
			a_column, a_cell_renderer: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
			a_selection: POINTER
			a_type_array: ARRAY [INTEGER]
			a_type_array_c: ANY
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_TREE_I}
			
			create a_type_array.make (0, 1)
			a_type_array.put (feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_type_pixbuf, 0)
			a_type_array.put (feature {EV_GTK_DEPENDENT_EXTERNALS}.g_type_string, 1)
			a_type_array_c := a_type_array.to_c
			
			tree_store := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_store_newv (2, $a_type_array_c)
			
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_model (tree_view, tree_store)				
			feature {EV_GTK_EXTERNALS}.gtk_scrolled_window_set_policy (
				scrollable_area,
				feature {EV_GTK_EXTERNALS}.GTK_POLICY_AUTOMATIC_ENUM,
				feature {EV_GTK_EXTERNALS}.GTK_POLICY_AUTOMATIC_ENUM
			)
			
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (tree_view)
			feature {EV_GTK_EXTERNALS}.gtk_tree_view_set_rules_hint (tree_view, True)
			
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_set_headers_visible (tree_view, False)
			
			a_column := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_new
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_resizable (a_column, True)
			
			
			a_cell_renderer := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_pixbuf_new
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_pack_start (a_column, a_cell_renderer, False)
			create a_gtk_c_str.make ("pixbuf")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 0)
			
			a_cell_renderer := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_text_new
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_pack_start (a_column, a_cell_renderer, True)				
			create a_gtk_c_str.make ("text")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_insert_column (tree_view, a_column, 1)
			
			real_signal_connect (tree_view, "row-collapsed", agent (app_implementation.gtk_marshal).tree_row_expansion_change_intermediary (internal_id, False, ?, ?), agent (app_implementation.gtk_marshal).gtk_args_to_tuple)
			real_signal_connect (tree_view, "row-expanded", agent (app_implementation.gtk_marshal).tree_row_expansion_change_intermediary (internal_id, True, ?, ?), agent (app_implementation.gtk_marshal).gtk_args_to_tuple)
			
			a_selection := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			real_signal_connect (a_selection, "changed", agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id), Void)
			
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_selection_set_mode (a_selection, feature {EV_GTK_EXTERNALS}.gtk_selection_browse_enum)
			initialize_pixmaps
			connect_button_press_switch
			
			set_row_height (App_implementation.default_font_height + 10)
				-- We explicitly set the row height to be proportional to the default gtk application font
				
						--real_signal_connect (tree_view, "row-activated", agent print ("Row activated%N"), Void)
		end

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
		do
			create Result
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
			a_x_offset, a_y_offset, a_width, a_height: INTEGER
			a_property: EV_GTK_C_STRING
			a_expander_size, a_horizontal_separator: INTEGER
			a_success: BOOLEAN
			a_tree_path, a_tree_column: POINTER
			a_depth: INTEGER
			avoid_item_events: BOOLEAN
		do
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]
			
			create a_property.make ("expander-size")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_style_get_integer (tree_view, a_property.item, $a_expander_size)
			create a_property.make ("horizontal-separator")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_style_get_integer (tree_view, a_property.item, $a_horizontal_separator)
			
			a_success := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_path_at_pos (tree_view, a_x, a_y, $a_tree_path, $a_tree_column, NULL, NULL)
			if a_success then
				a_depth := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_depth (a_tree_path)
				if a_x <= (a_horizontal_separator + a_expander_size + a_horizontal_separator) * a_depth and then a_x >= (a_horizontal_separator + a_expander_size + a_horizontal_separator) * (a_depth - 1) then
					avoid_item_events := True
						-- We have clicked on the expander node so therefore we don't want to emit an item event
				end
			end
			tree_item_imp := row_from_y_coord (a_y)

			if a_type = feature {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_ENUM then
				if not is_transport_enabled and then pointer_button_press_actions_internal /= Void then
					pointer_button_press_actions_internal.call (t)
				end
				if not avoid_item_events and then tree_item_imp /= Void and then tree_item_imp.pointer_button_press_actions_internal /= Void then
					tree_item_imp.pointer_button_press_actions_internal.call (t)
				end
			elseif a_type = feature {EV_GTK_EXTERNALS}.GDK_2BUTTON_PRESS_ENUM then
				if pointer_double_press_actions_internal /= Void then
					pointer_double_press_actions_internal.call (t)
				end
				if not avoid_item_events and then tree_item_imp /= Void and then tree_item_imp.pointer_double_press_actions_internal /= Void then
					tree_item_imp.pointer_double_press_actions_internal.call (t)
				end
			end
		end

	motion_handler (a_x, a_y: INTEGER; a_a, a_b, a_c: DOUBLE; a_d, a_e: INTEGER) is
			-- Handle motion events on 'Current'
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
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	expand_callback (a_tree_item: POINTER) is
			-- Expand callback passing expanded `a_tree_item' node pointer.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do	
		end

	collapse_callback (a_tree_item: POINTER) is
			-- Collapse callback passing collapsed `a_tree_item' node pointer.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
		end

	select_callback (a_tree_item: POINTER) is
			-- Called when a tree item is selected
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
		end
		
	deselect_callback (a_tree_item: POINTER) is
			-- Called when a tree item is deselected.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
		end

feature -- Status report

	selected_item: EV_TREE_NODE is
			-- Item which is currently selected
		local
			a_selection: POINTER
			a_tree_path_list: POINTER
			a_model: POINTER
			a_tree_path: POINTER
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
			i, a_depth: INTEGER
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			a_selection := feature {EV_GTK_EXTERNALS}.gtk_tree_view_get_selection (tree_view)
			a_tree_path_list := feature {EV_GTK_EXTERNALS}.gtk_tree_selection_get_selected_rows (a_selection, $a_model)
			
			if a_tree_path_list /= NULL then
					a_tree_path := feature {EV_GTK_EXTERNALS}.glist_struct_data (a_tree_path_list)
					a_tree_node_imp := node_from_tree_path (a_tree_path)
					feature {EV_GTK_EXTERNALS}.g_list_free (a_tree_path_list)
					Result := a_tree_node_imp.interface
			end
		end

	node_from_tree_path (a_tree_path: POINTER): EV_TREE_NODE_IMP is
			-- Retrieve node from `a_tree_path'
		local
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
			i, a_depth: INTEGER
			a_tree_node: EV_TREE_NODE
		do
			a_depth := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_depth (a_tree_path)
			a_int_ptr := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_indices (a_tree_path)
			from
				create mp.share_from_pointer (a_int_ptr, App_implementation.integer_bytes * a_depth)
				a_tree_node := i_th (mp.read_integer_32 (0) + 1)
				i := 1
			until
				i = a_depth
			loop
				a_tree_node := a_tree_node.i_th (mp.read_integer_32 (i * App_implementation.integer_bytes) + 1)
				i := i + 1
			end
			Result ?= a_tree_node.implementation
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
				feature {EV_GTK_DEPENDENT_EXTERNALS}.signal_disconnect (visual_widget, button_press_connection_id)
			end
			real_signal_connect (
				visual_widget,
				"button-press-event", 
				agent (App_implementation.gtk_marshal).tree_start_transport_filter_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?), 
				App_implementation.default_translate)
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
			a_cursor: CURSOR
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			from
				a_cursor := child_array.cursor
				child_array.start
				i := 1
			until
				i > child_array.count or else a_enable_flag
			loop
				child_array.go_i_th (i)
				if child_array.item /= Void then
					a_tree_node_imp ?= child_array.item.implementation
					a_enable_flag := a_tree_node_imp.is_transport_enabled_iterator					
				end
				i := i + 1
			end
			child_array.go_to (a_cursor)
			update_pnd_connection (a_enable_flag)
		end
		
	update_pnd_connection (a_enable: BOOLEAN) is
			-- Update the PND connection status for `Current'.
		do
			if not is_transport_enabled then
				if a_enable or pebble /= Void then
					connect_pnd_callback
				end
			elseif not a_enable and pebble = Void then
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
			-- Temporary pebble holder used for PND implementation with nodes.

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
		do
			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor
			App_implementation.on_pick (pebble)

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
						((child_array.index_of (pnd_row_imp.interface, 1) - 1) * row_height)
				end
			end
		end

	post_drop_steps is
			-- Steps to perform once an attempted drop has happened.
		do
			if pnd_row_imp /= Void and not is_destroyed then
				if pnd_row_imp.mode_is_pick_and_drop then
					signal_emit_stop (visual_widget, "button-press-event")
				end
			elseif mode_is_pick_and_drop and not is_destroyed then
					signal_emit_stop (visual_widget, "button-press-event")
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
			-- Returns the row index at relative coordinate `a_y'.
		local
			a_tree_path, a_tree_column: POINTER
			a_success: BOOLEAN
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
			a_depth: INTEGER
			a_tree_node_imp: EV_TREE_NODE_IMP
			i: INTEGER
			current_depth_index: INTEGER
		do
			a_success := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_path_at_pos (tree_view, 1, a_y, $a_tree_path, $a_tree_column, NULL, NULL)
			if a_success then
				a_int_ptr := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_indices (a_tree_path)
				a_depth := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_get_depth (a_tree_path)
				from
					create mp.share_from_pointer (a_int_ptr, app_implementation.integer_bytes * a_depth)
					current_depth_index := mp.read_integer_32 (0) + 1
					a_tree_node_imp ?= child_array.i_th (current_depth_index).implementation
					i := 1
				until
					i = a_depth
				loop
					current_depth_index := mp.read_integer_32 (i * app_implementation.integer_bytes) + 1
					a_tree_node_imp ?= a_tree_node_imp.child_array.i_th (current_depth_index).implementation
					i := i + 1
				end
				Result := a_tree_node_imp
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_tree_path)
			end
		end

feature {NONE} -- Implementation

	ensure_item_visible (an_item: EV_TREE_ITEM) is
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		local
			tree_item_imp: EV_TREE_NODE_IMP
			a_path: POINTER
		do	
			tree_item_imp ?= an_item.implementation
			a_path := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_model_get_path (tree_store, tree_item_imp.list_iter.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_scroll_to_cell (tree_view, a_path, NULL, False, 0, 0)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_path_free (a_path)
		end
			
	previous_selected_item: EV_TREE_NODE
			-- Item that was selected previously.
		
	append (s: SEQUENCE [EV_TREE_ITEM]) is
			-- Add 's' to 'Current'
		do
			Precursor (s)
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
			a_tree_iter: EV_GTK_TREE_ITER_STRUCT
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			
			child_array.go_i_th (i)
			child_array.put_left (v)	

			item_imp.add_item_and_children_to_parent_tree (Current, Void, i)
			
			if v.pixmap /= Void then
				set_row_pixmap (item_imp, v.pixmap)
			end
			
			if item_imp.is_transport_enabled_iterator then
				update_pnd_connection (True)
			end
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_NODE_IMP
		do
			item_imp ?= (child_array @ (a_position)).implementation
				-- Remove from tree if present
			feature {EV_GTK_EXTERNALS}.gtk_tree_store_remove (tree_store, item_imp.list_iter.item)
			item_imp.set_parent_imp (Void)
			child_array.go_i_th (a_position)
			child_array.remove
			update_pnd_status
		end
		
	add_to_container (v: like item; v_imp: EV_ITEM_IMP) is
			-- Add `v' to tree.
		do
			check
				do_not_call: False
			end
		end

	reorder_child (v: like item; v_imp: EV_ITEM_IMP; a_position: INTEGER) is
			-- Move `v' to `a_position' in Current.
		do
			check
				do_not_call: False
			end
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check  do_not_call: False end
		end

feature {EV_TREE_NODE_IMP} -- Implementation

	set_text_on_position (a_tree_node_imp: EV_TREE_NODE_IMP; a_text: STRING) is
			-- Set cell text at (a_column, a_row) to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
			str_value: POINTER
		do
			create a_cs.make (a_text)
			str_value := feature {EV_GTK_DEPENDENT_EXTERNALS}.c_g_value_struct_allocate
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_value_init_string (str_value)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_value_set_string (str_value, a_cs.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_store_set_value (tree_store, a_tree_node_imp.list_iter.item, 1, str_value)
			str_value.memory_free
		end

	set_row_pixmap (a_tree_node_imp: EV_TREE_NODE_IMP; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			pixmap_imp: EV_PIXMAP_IMP
			a_list_item_imp: EV_LIST_ITEM_IMP
			a_pixbuf: POINTER
		do
			pixmap_imp ?= a_pixmap.implementation
			a_pixbuf := pixmap_imp.pixbuf_from_drawable_with_size (pixmaps_width, pixmaps_height)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_store_set_pixbuf (tree_store, a_tree_node_imp.list_iter.item, 0, a_pixbuf)
		end

	tree_store: POINTER
		-- Gtk Model use for storing tree data	

	set_row_height (value: INTEGER) is
			-- Make `value' the new height of all the rows.
		local
			a_column_ptr, a_cell_rend_list, a_cell_rend: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
		do
			a_column_ptr := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, 0)
			a_cell_rend_list := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_get_cell_renderers (a_column_ptr)
			a_cell_rend := feature {EV_GTK_EXTERNALS}.g_list_nth_data (a_cell_rend_list, 0)
			
			create a_gtk_c_str.make ("height")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (a_cell_rend, a_gtk_c_str.item, value)
			feature {EV_GTK_EXTERNALS}.g_list_free (a_cell_rend_list)
		end

	row_height: INTEGER is
			-- Height of rows in `Current'
		local
			a_column_ptr, a_cell_rend_list, a_cell_rend: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
		do
			a_column_ptr := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (tree_view, 0)
			a_cell_rend_list := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_get_cell_renderers (a_column_ptr)
			a_cell_rend := feature {EV_GTK_EXTERNALS}.g_list_nth_data (a_cell_rend_list, 0)
			
			create a_gtk_c_str.make ("height")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_get_integer (a_cell_rend, a_gtk_c_str.item, $Result)
			feature {EV_GTK_EXTERNALS}.g_list_free (a_cell_rend_list)
			
			Result := Result + 2 -- spacing
		end

	tree_view: POINTER
			-- Pointer to the gtktree widget.
			
feature {NONE} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end
			
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

