note
	description:
		"EiffelVision Tree, gtk implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I
		redefine
			interface,
			make,
			call_pebble_function,
			append,
			reset_pebble_function
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			make,
			call_button_event_actions,
			set_to_drag_and_drop,
			able_to_transport,
			ready_for_pnd_menu,
			disable_transport,
			on_mouse_button_event,
			pre_pick_steps,
			post_drop_steps,
			call_pebble_function,
			visual_widget,
			needs_event_box,
			on_pointer_motion,
			pebble_source,
			reset_pebble_function
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		redefine
			interface,
			append,
			make
		end

	EV_PND_DEFERRED_ITEM_PARENT
		redefine
			call_selection_action_sequences
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	old_make (an_interface: attached like interface)
			-- Create an empty Tree.
		do
			assign_interface (an_interface)
		end

	call_selection_action_sequences
			-- Call the appropriate selection action sequences
		local
			a_selected_item: detachable EV_TREE_NODE
			a_selected_item_imp: detachable EV_TREE_NODE_IMP
			previous_selected_item_imp: detachable EV_TREE_NODE_IMP
		do
			a_selected_item := selected_item

			if a_selected_item /= previous_selected_item then
				if attached previous_selected_item as l_previous_selected_item then
					previous_selected_item_imp ?= l_previous_selected_item.implementation
					check previous_selected_item_imp /= Void then end
					if previous_selected_item_imp.deselect_actions_internal /= Void then
						previous_selected_item_imp.deselect_actions.call (Void)
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call (Void)
					end
				end
				if a_selected_item /= Void then
					a_selected_item_imp ?= a_selected_item.implementation
					check a_selected_item_imp /= Void then end
					if a_selected_item_imp.select_actions_internal /= Void then
						a_selected_item_imp.select_actions.call (Void)
					end
					if select_actions_internal /= Void then
						select_actions_internal.call (Void)
					end
				end
			end
			previous_selected_item := a_selected_item
		end

	visual_widget: POINTER
			-- Visible widget on screen.
		do
			Result := tree_view
		end

	initialize_model
			-- Initialize data model
		do
			tree_store := new_tree_store
		end

	make
			-- Connect action sequences to signals.
		local
			a_column, a_cell_renderer: POINTER
			a_gtk_c_str: EV_GTK_C_STRING
			a_selection: POINTER

		do
			scrollable_area := {GTK}.gtk_scrolled_window_new (default_pointer, default_pointer)
			{GTK2}.gtk_scrolled_window_set_shadow_type (scrollable_area, {GTK}.gtk_shadow_in_enum)
			set_c_object (scrollable_area)
			tree_view := {GTK2}.gtk_tree_view_new
			{GTK}.gtk_container_add (scrollable_area, tree_view)
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_TREE_I}

			initialize_model

			{GTK2}.gtk_tree_view_set_model (tree_view, tree_store)
			{GTK}.gtk_scrolled_window_set_policy (
				scrollable_area,
				{GTK}.GTK_POLICY_AUTOMATIC_ENUM,
				{GTK}.GTK_POLICY_AUTOMATIC_ENUM
			)

			{GTK}.gtk_widget_show (tree_view)

			{GTK2}.gtk_tree_view_set_headers_visible (tree_view, False)

			a_column := {GTK2}.gtk_tree_view_column_new
			{GTK2}.gtk_tree_view_column_set_resizable (a_column, True)

			a_cell_renderer := {GTK2}.gtk_cell_renderer_text_new
			{GTK2}.gtk_tree_view_column_pack_end (a_column, a_cell_renderer, True)
			a_gtk_c_str := "text"
			{GTK2}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 1)

			a_cell_renderer := {GTK2}.gtk_cell_renderer_pixbuf_new
			{GTK2}.gtk_tree_view_column_pack_end (a_column, a_cell_renderer, False)
			a_gtk_c_str := "pixbuf"
			{GTK2}.gtk_tree_view_column_add_attribute (a_column, a_cell_renderer, a_gtk_c_str.item, 0)


			{GTK2}.gtk_tree_view_insert_column (tree_view, a_column, 1)

			real_signal_connect (tree_view, {EV_GTK_EVENT_STRINGS}.row_collapsed_event_name, agent (app_implementation.gtk_marshal).tree_row_expansion_change_intermediary (internal_id, False, ?, ?))
			real_signal_connect (tree_view, {EV_GTK_EVENT_STRINGS}.row_expanded_event_name, agent (app_implementation.gtk_marshal).tree_row_expansion_change_intermediary (internal_id, True, ?, ?))

			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			real_signal_connect (a_selection, {EV_GTK_EVENT_STRINGS}.changed_event_name, agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id))

			{GTK2}.gtk_tree_selection_set_mode (a_selection, {GTK}.gtk_selection_browse_enum)

			{GTK2}.gtk_tree_view_set_enable_search (tree_view, False)

			initialize_pixmaps
		end

	call_button_event_actions (
			a_type: INTEGER;
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
			tree_item_imp: detachable EV_TREE_NODE_IMP
			a_property: EV_GTK_C_STRING
			a_expander_size, a_horizontal_separator: INTEGER
			a_success: BOOLEAN
			a_tree_path, a_tree_column: POINTER
			a_depth: INTEGER
			avoid_item_events: BOOLEAN
			a_gdkwin, a_gtkwid: POINTER
			l_x, l_y: INTEGER
		do
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			a_gdkwin := {GDK_HELPERS}.window_at ($l_x, $l_y)
			if a_gdkwin /= default_pointer then
				{GTK}.gdk_window_get_user_data (a_gdkwin, $a_gtkwid)
				if a_gtkwid /= tree_view then
						-- We are not clicking on the item area.
					avoid_item_events := True
				else
						-- We are clicking on the item area, check that it is not on the expander
					a_property := once "expander-size"
					{GTK2}.gtk_widget_style_get_integer (tree_view, a_property.item, $a_expander_size)
					a_property := once "horizontal-separator"
					{GTK2}.gtk_widget_style_get_integer (tree_view, a_property.item, $a_horizontal_separator)

					a_success := {GTK2}.gtk_tree_view_get_path_at_pos (tree_view, a_x, a_y, $a_tree_path, $a_tree_column, default_pointer, default_pointer)
					if a_success then
						a_depth := {GTK2}.gtk_tree_path_get_depth (a_tree_path)
						if a_x <= (a_horizontal_separator + a_expander_size + a_horizontal_separator) * a_depth and then a_x >= (a_horizontal_separator + a_expander_size + a_horizontal_separator) * (a_depth - 1) then
							avoid_item_events := True
								-- We have clicked on the expander node so therefore we don't want to emit an item event
						end
						{GTK2}.gtk_tree_path_free (a_tree_path)
					end
				end
			end
			if not avoid_item_events then
				tree_item_imp := item_from_coords (a_x, a_y)
				if tree_item_imp /= Void then
					t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y]
					if
						a_type = {GTK}.GDK_BUTTON_PRESS_ENUM and then
						tree_item_imp.pointer_button_press_actions_internal /= Void
					then
						tree_item_imp.pointer_button_press_actions.call (t)
					elseif
						a_type = {GTK}.GDK_2BUTTON_PRESS_ENUM and then
						tree_item_imp.pointer_double_press_actions_internal /= Void
					then
						tree_item_imp.pointer_double_press_actions.call (t)
					end
				end
			end
		end

	on_pointer_motion (a_motion_tuple: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER])
		local
			a_row_imp: detachable EV_TREE_NODE_IMP
		do
			Precursor (a_motion_tuple)
			if not app_implementation.is_in_transport and then a_motion_tuple.integer_item (2) > 0 and a_motion_tuple.integer_item (1) <= width then
				a_row_imp := item_from_coords (a_motion_tuple.integer_item (1), a_motion_tuple.integer_item (2))
				if a_row_imp /= Void then
					if a_row_imp.pointer_motion_actions_internal /= Void then
						a_row_imp.pointer_motion_actions.call (a_motion_tuple)
					end
				end
			end
		end

feature -- Status report

	selected_item: detachable EV_TREE_NODE
			-- Item which is currently selected
		local
			a_selection: POINTER
			a_tree_path_list: POINTER
			a_model: POINTER
			a_tree_path: POINTER
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			a_selection := {GTK2}.gtk_tree_view_get_selection (tree_view)
			a_tree_path_list := {GTK2}.gtk_tree_selection_get_selected_rows (a_selection, $a_model)

			if not a_tree_path_list.is_default_pointer then
					a_tree_path := {GTK}.glist_struct_data (a_tree_path_list)
					a_tree_node_imp := node_from_tree_path (a_tree_path)
					{GTK2}.gtk_tree_path_list_free_contents (a_tree_path_list)
					{GTK}.g_list_free (a_tree_path_list)
					Result := a_tree_node_imp.interface
			end
		end

	node_from_tree_path (a_tree_path: POINTER): EV_TREE_NODE_IMP
			-- Retrieve node from `a_tree_path'
		local
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
			i, a_depth: INTEGER
			a_tree_node: detachable EV_TREE_NODE
			l_result: detachable EV_TREE_NODE_IMP
		do
			a_depth := {GTK2}.gtk_tree_path_get_depth (a_tree_path)
			a_int_ptr := {GTK2}.gtk_tree_path_get_indices (a_tree_path)
			from
				create mp.share_from_pointer (a_int_ptr, {PLATFORM}.integer_32_bytes * a_depth)
				a_tree_node := i_th (mp.read_integer_32 (0) + 1)
				check a_tree_node /= Void then end
				i := 1
			until
				i = a_depth
			loop
				a_tree_node := a_tree_node.i_th (mp.read_integer_32 (i * {PLATFORM}.integer_32_bytes) + 1)
				check a_tree_node /= Void then end
				i := i + 1
			end
			l_result ?= a_tree_node.implementation
			check l_result /= Void then end
			Result := l_result
		end

	selected: BOOLEAN
			-- Is one item selected?
		do
			Result := selected_item /= Void
		end

feature -- Implementation

	pebble_source: EV_PICK_AND_DROPABLE
			-- Source of `pebble', used for widgets with deferred PND implementation
			-- such as EV_TREE and EV_MULTI_COLUMN_LIST.
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.attached_interface
			else
				Result := Precursor
			end
		end

	ensure_item_visible (an_item: EV_TREE_NODE)
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		local
			tree_item_imp: detachable EV_TREE_NODE_IMP
			a_path: POINTER
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			tree_item_imp ?= an_item.implementation
			check tree_item_imp /= Void then end
			l_list_iter := tree_item_imp.list_iter
			check l_list_iter /= Void then end
			a_path := {GTK2}.gtk_tree_model_get_path (tree_store, l_list_iter.item)
			{GTK2}.gtk_tree_view_scroll_to_cell (tree_view, a_path, default_pointer, False, 0, 0)
			{GTK2}.gtk_tree_path_free (a_path)
		end

	set_to_drag_and_drop: BOOLEAN
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.mode_is_drag_and_drop
			else
				Result := mode_is_drag_and_drop
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is list or row able to transport PND data using `a_button'.
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.able_to_transport (a_button)
			else
				Result := Precursor (a_button)
			end
		end

	ready_for_pnd_menu (a_button: INTEGER; a_press: BOOLEAN): BOOLEAN
			-- Is list or row able to display PND menu using `a_button'
		do
			if attached pnd_row_imp as l_pnd_row_imp then
				Result := l_pnd_row_imp.ready_for_pnd_menu (a_button, a_press)
			else
				Result := Precursor (a_button, a_press)
			end
		end

	disable_transport
		do
			Precursor
			update_pnd_status
		end

	update_pnd_status
			-- Update PND status of list and its children.
		local
			a_enable_flag: BOOLEAN
			i: INTEGER
			a_cursor: CURSOR
			a_tree_node_imp: detachable EV_TREE_NODE_IMP
			l_child_array: like child_array
		do
			from
				a_cursor := child_array.cursor
				l_child_array := child_array
				l_child_array.start
				i := 1
			until
				i > l_child_array.count or else a_enable_flag
			loop
				l_child_array.go_i_th (i)
				if l_child_array.item /= Void then
					a_tree_node_imp ?= l_child_array.item.implementation
					check a_tree_node_imp /= Void end
					if a_tree_node_imp /= Void then
						a_enable_flag := a_tree_node_imp.is_transport_enabled_iterator
					end
				end
				i := i + 1
			end
			l_child_array.go_to (a_cursor)
			update_pnd_connection (a_enable_flag)
		end

	update_pnd_connection (a_enable: BOOLEAN)
			-- Update the PND connection status for `Current'.
		do
			if not is_transport_enabled then
				if a_enable or pebble /= Void then
					is_transport_enabled := True
				end
			elseif not a_enable and pebble = Void then
				is_transport_enabled := False
			end
		end

	on_mouse_button_event (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)

			-- Initialize a pick and drop transport.
		local
			l_pnd_row_imp: like pnd_row_imp
		do
			l_pnd_row_imp := item_from_coords (a_x, a_y)
			pnd_row_imp := l_pnd_row_imp

			if l_pnd_row_imp /= Void and then not (l_pnd_row_imp.able_to_transport (a_button) or l_pnd_row_imp.mode_is_configurable_target_menu) then
				pnd_row_imp := Void
			end
			Precursor (
				a_type,
				a_x, a_y, a_button,
				a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y
			)
		end

	pnd_row_imp: detachable EV_TREE_NODE_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: detachable ANY
			-- Temporary pebble holder used for PND implementation with nodes.

	temp_pebble_function: detachable FUNCTION [detachable ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: detachable EV_POINTER_STYLE

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Set `pebble' using `pebble_function' if present.
		do
			temp_pebble := pebble
			temp_pebble_function := pebble_function
			if attached pnd_row_imp as l_pnd_row_imp then
				pebble := l_pnd_row_imp.pebble
				pebble_function := l_pnd_row_imp.pebble_function
			end

			if attached pebble_function as l_pebble_function then
				pebble := l_pebble_function.item ([a_x, a_y]);
			end
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Steps to perform before transport initiated.
		local
			l_pebble: like pebble
			l_pnd_row_imp: like pnd_row_imp
		do
			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor
			l_pebble := pebble
			if l_pebble /= Void then
				App_implementation.on_pick (Current, l_pebble)
			end
			l_pnd_row_imp := pnd_row_imp


			if l_pnd_row_imp /= Void then
				if l_pnd_row_imp.pick_actions_internal /= Void then
					l_pnd_row_imp.pick_actions.call ([a_x, a_y])
				end
				accept_cursor := l_pnd_row_imp.accept_cursor
				deny_cursor := l_pnd_row_imp.deny_cursor
			else
				if pick_actions_internal /= Void then
					pick_actions_internal.call ([a_x, a_y])
				end
			end

			pointer_x := a_screen_x.to_integer_16
			pointer_y := a_screen_y.to_integer_16

			if l_pnd_row_imp = Void then
				if (pick_x = 0 and then pick_y = 0) then
					App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
				else
					if pick_x > width then
						pick_x := width.to_integer_16
					end
					if pick_y > height then
						pick_y := height.to_integer_16
					end
					App_implementation.set_x_y_origin (pick_x + (a_screen_x - a_x), pick_y + (a_screen_y - a_y))
				end
			else
				if (l_pnd_row_imp.pick_x = 0 and then l_pnd_row_imp.pick_y = 0) then
					App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
				else
					if pick_x > width then
						pick_x := width.to_integer_16
					end
					if pick_y > row_height then
						pick_y := row_height.to_integer_16
					end
					App_implementation.set_x_y_origin (
						l_pnd_row_imp.pick_x + (a_screen_x - a_x),
						l_pnd_row_imp.pick_y +
						(a_screen_y - a_y) +
						((child_array.index_of (l_pnd_row_imp.attached_interface, 1) - 1) * row_height)
					)
				end
			end
			modify_widget_appearance (True)
		end

	reset_pebble_function
			-- Reset `pebble_function'.
		do
			pebble := temp_pebble
			pebble_function := temp_pebble_function
			temp_pebble := Void
			temp_pebble_function := Void
		end

	post_drop_steps (a_button: INTEGER)
			-- Steps to perform once an attempted drop has happened.
		do
			Precursor (a_button)
			accept_cursor := temp_accept_cursor
			deny_cursor := temp_deny_cursor

			temp_accept_cursor := Void
			temp_deny_cursor := Void

			pnd_row_imp := Void
		end

feature {EV_TREE_NODE_IMP}

	item_from_coords (a_x, a_y: INTEGER): detachable EV_TREE_NODE_IMP
			-- Returns the row index at relative coordinate `a_y'.
		local
			a_tree_path, a_tree_column: POINTER
			a_success: BOOLEAN
			a_int_ptr: POINTER
			mp: MANAGED_POINTER
			a_depth: INTEGER
			a_tree_node_imp: detachable EV_TREE_NODE_IMP
			i: INTEGER
			current_depth_index: INTEGER
		do
			a_success := {GTK2}.gtk_tree_view_get_path_at_pos (tree_view, 1, a_y, $a_tree_path, $a_tree_column, default_pointer, default_pointer)
			if a_success then
				a_int_ptr := {GTK2}.gtk_tree_path_get_indices (a_tree_path)
				a_depth := {GTK2}.gtk_tree_path_get_depth (a_tree_path)
				from
					create mp.share_from_pointer (a_int_ptr, {PLATFORM}.integer_32_bytes * a_depth)
					current_depth_index := mp.read_integer_32 (0) + 1
					a_tree_node_imp ?= child_array.i_th (current_depth_index).implementation
					check a_tree_node_imp /= Void then end
					i := 1
				until
					i = a_depth
				loop
					current_depth_index := mp.read_integer_32 (i * {PLATFORM}.integer_32_bytes) + 1
					a_tree_node_imp ?= a_tree_node_imp.child_array.i_th (current_depth_index).implementation
					check a_tree_node_imp /= Void then end
					i := i + 1
				end
				Result := a_tree_node_imp
				{GTK2}.gtk_tree_path_free (a_tree_path)
			end
		end

feature {NONE} -- Implementation

	previous_selected_item: detachable EV_TREE_NODE
			-- Item that was selected previously.

	append (s: SEQUENCE [EV_TREE_ITEM])
			-- Add 's' to 'Current'
		do
			Precursor (s)
		end

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			item_imp: detachable EV_TREE_NODE_IMP
		do
			item_imp ?= v.implementation
			check item_imp /= Void end
			if item_imp /= Void then
				item_imp.set_parent_imp (Current)

				child_array.go_i_th (i)
				child_array.put_left (v)

				item_imp.add_item_and_children_to_parent_tree (Current, Void, i)
				update_row_pixmap (item_imp)

				if item_imp.is_transport_enabled_iterator then
					update_pnd_connection (True)
				end
			end
		end

	remove_i_th (a_position: INTEGER)
			-- Remove item at `a_position'
		local
			item_imp: detachable EV_TREE_NODE_IMP
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			item_imp ?= (child_array @ (a_position)).implementation
			check item_imp /= Void end
			if item_imp /= Void then
					-- Remove from tree if present
				l_list_iter := item_imp.list_iter
				check l_list_iter /= Void end
				if l_list_iter /= Void then
					{GTK2}.gtk_tree_store_remove (tree_store, l_list_iter.item)
					item_imp.set_parent_imp (Void)
					child_array.go_i_th (a_position)
					child_array.remove
					update_pnd_status
				end
			end
		end

feature {EV_TREE_NODE_IMP} -- Implementation

	get_text_from_position (a_tree_node_imp: EV_TREE_NODE_IMP): STRING_32
			-- Retrieve cell text from `a_tree_node_imp`
		local
			a_g_value_string_struct: POINTER
			a_string: POINTER
			a_cs: EV_GTK_C_STRING
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_g_value_string_struct := g_value_string_struct
			{GTK2}.g_value_unset (a_g_value_string_struct)
			l_list_iter := a_tree_node_imp.list_iter
			check l_list_iter /= Void end
			if l_list_iter /= Void then
				{GTK2}.gtk_tree_model_get_value (tree_store, l_list_iter.item, 1, a_g_value_string_struct)
			end
			a_string := {GTK2}.g_value_get_string (a_g_value_string_struct)
			if a_string /= default_pointer then
				a_cs := App_implementation.reusable_gtk_c_string
				a_cs.share_from_pointer ({GTK2}.g_value_get_string (a_g_value_string_struct))
				Result := a_cs.string
			else
				Result := ""
			end
		end

	set_text_on_position (a_tree_node_imp: EV_TREE_NODE_IMP; a_text: READABLE_STRING_GENERAL)
			-- Set cell text at to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
			str_value: POINTER
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_cs := App_implementation.reusable_gtk_c_string
			a_cs.share_with_eiffel_string (a_text)
			str_value := g_value_string_struct
			{GTK2}.g_value_take_string (str_value, a_cs.item)
			l_list_iter := a_tree_node_imp.list_iter
			check l_list_iter /= Void end
			if l_list_iter /= Void then
				{GTK2}.gtk_tree_store_set_value (tree_store, l_list_iter.item, 1, str_value)
			end
		end

	g_value_string_struct: POINTER
			-- Optimization for GValue struct access
		once
			Result := {GTK2}.c_g_value_struct_allocate
			{GTK2}.g_value_init_string (Result)
		end

	update_row_pixmap (a_tree_node_imp: EV_TREE_NODE_IMP)
			-- Set the pixmap for `a_tree_node_imp'.
		local
			a_pix: POINTER
			l_list_iter: detachable EV_GTK_TREE_ITER_STRUCT
		do
			a_pix := a_tree_node_imp.gdk_pixbuf
			l_list_iter := a_tree_node_imp.list_iter
			check l_list_iter /= Void end
			if l_list_iter /= Void then
				{GTK2}.gtk_tree_store_set_pixbuf (tree_store, l_list_iter.item, 0, a_pix)
			end
		end

	tree_store: POINTER
		-- Gtk Model use for storing tree data	

	set_row_height (value: INTEGER)
			-- Make `value' the new height of all the rows.
		local
			a_column_ptr, a_cell_rend_list, a_cell_rend: POINTER
			a_vert_sep: INTEGER
		do
			a_column_ptr := {GTK2}.gtk_tree_view_get_column (tree_view, 0)
			a_cell_rend_list := {GTK}.gtk_cell_layout_get_cells (a_column_ptr)
			a_cell_rend := {GTK}.g_list_nth_data (a_cell_rend_list, 0)

			{GTK2}.gtk_widget_style_get_integer (tree_view, {GTK_PROPERTIES}.vertical_separator, $a_vert_sep)

			{GTK2}.g_object_set_integer (a_cell_rend, {GTK_PROPERTIES}.height, value - a_vert_sep)
			{GTK}.g_list_free (a_cell_rend_list)
		end

	row_height: INTEGER
			-- Height of rows in `Current'
		local
			a_column_ptr: POINTER
			a_x, a_y, a_width, a_height: INTEGER
		do
			a_column_ptr := {GTK2}.gtk_tree_view_get_column (tree_view, 0)
			{GTK2}.gtk_tree_view_column_cell_get_size (a_column_ptr, default_pointer, $a_x, $a_y, $a_width, $a_height)
			Result := a_height
		end

	tree_view: POINTER
			-- Pointer to the gtktree widget.

feature {NONE} -- Implementation

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end

	new_tree_store: POINTER
			-- New instance of a tree store.
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_new (2, GDK_TYPE_PIXBUF, G_TYPE_STRING)"
		end

feature {EV_ANY_I} -- Implementation

	scrollable_area: POINTER
		-- Pointer to the GtkScrolledWindow widget used for scrolling the tree view

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TREE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_TREE_IMP
