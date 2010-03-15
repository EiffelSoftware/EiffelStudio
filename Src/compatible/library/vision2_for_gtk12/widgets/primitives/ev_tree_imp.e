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
			initialize,
			wipe_out,
			call_pebble_function,
			append
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			create_pointer_motion_actions,
			set_to_drag_and_drop,
			able_to_transport,
			ready_for_pnd_menu,
			disable_transport,
			pre_pick_steps,
			post_drop_steps,
			call_pebble_function,
			visual_widget,
			needs_event_box,
			on_mouse_button_event,
			call_button_event_actions
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		redefine
			interface,
			insert_i_th,
			remove_i_th,
			i_th,
			count,
			wipe_out,
			append,
			initialize
		end

	EV_TREE_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM_PARENT

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN = True

	make (an_interface: like interface)
			-- Create an empty Tree.
		local
			a_scrolled_window: POINTER
		do
			base_make (an_interface)
			a_scrolled_window := {EV_GTK_EXTERNALS}.gtk_scrolled_window_new (NULL, NULL)
			set_c_object (a_scrolled_window)
			{EV_GTK_EXTERNALS}.gtk_scrolled_window_set_policy (
				a_scrolled_window,
				{EV_GTK_EXTERNALS}.gTK_POLICY_AUTOMATIC_ENUM,
				{EV_GTK_EXTERNALS}.gTK_POLICY_AUTOMATIC_ENUM
			)
			{EV_GTK_EXTERNALS}.gtk_scrolled_window_set_placement (a_scrolled_window, {EV_GTK_EXTERNALS}.gTK_CORNER_TOP_LEFT_ENUM)

			list_widget := {EV_GTK_EXTERNALS}.gtk_ctree_new (1, 0)

			{EV_GTK_EXTERNALS}.gtk_ctree_set_line_style (list_widget, GTK_CTREE_LINES_DOTTED_ENUM)
			{EV_GTK_EXTERNALS}.gtk_clist_set_selection_mode (list_widget, {EV_GTK_EXTERNALS}.GTK_SELECTION_BROWSE_ENUM)
			{EV_GTK_EXTERNALS}.gtk_ctree_set_expander_style (list_widget, GTK_CTREE_EXPANDER_SQUARE_ENUM)
			{EV_GTK_EXTERNALS}.gtk_ctree_set_show_stub (list_widget, True)
			{EV_GTK_EXTERNALS}.gtk_ctree_set_indent (list_widget, 17)
			{EV_GTK_EXTERNALS}.gtk_widget_show (list_widget)
			{EV_GTK_EXTERNALS}.gtk_scrolled_window_add_with_viewport (a_scrolled_window, list_widget)

			create ev_children.make (0)
				-- Make initial hash table with room for 100 child pointers, may be increased later.

			create tree_node_ptr_table.make (100)
			create timer.make_with_interval (0)
			timer.actions.extend (agent on_time_out)
		end

	tree_width: INTEGER
		-- Width of tree widget

	timer: EV_TIMEOUT
		-- Timer used for refresh hack.

	timer_interval: INTEGER = 50

	on_time_out
			-- Called on a timer, needed to correctly refresh tree widget.
		local
			a_wid: INTEGER
		do
			timer.set_interval (0)
			a_wid := {EV_GTK_EXTERNALS}.gtk_clist_columns_autosize (list_widget) + 16
			if tree_width /= a_wid then
				{EV_GTK_EXTERNALS}.gtk_widget_set_usize (list_widget, a_wid, -1)
				tree_width := a_wid
			end
		end

	visual_widget: POINTER
			-- Visible widget on screen.
		do
			Result := list_widget
		end

	initialize
			-- Connect action sequences to signals.
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_TREE_I}
			initialize_pixmaps

			--| Event position 1 in intermediary
			real_signal_connect (
				list_widget,
				"tree-select-row",
				agent (App_implementation.gtk_marshal).on_tree_event_intermediary (c_object, 1, ?),
				agent (App_implementation.gtk_marshal).gtk_value_pointer_to_tuple
			)

			real_signal_connect (
				list_widget,
				"tree-unselect-row",
				agent (App_implementation.gtk_marshal).on_tree_event_intermediary (c_object, 2, ?),
				agent (App_implementation.gtk_marshal).gtk_value_pointer_to_tuple
			)

			real_signal_connect (
				list_widget,
				"tree-expand",
				agent (App_implementation.gtk_marshal).on_tree_event_intermediary (c_object, 3, ?),
				agent (App_implementation.gtk_marshal).gtk_value_pointer_to_tuple
			)

			real_signal_connect (
				list_widget,
				"tree-collapse",
				agent (App_implementation.gtk_marshal).on_tree_event_intermediary (c_object, 4, ?),
				agent (App_implementation.gtk_marshal).gtk_value_pointer_to_tuple
			)
		end

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

	gtk_value_pointer_to_tuple (n_args: INTEGER; args: POINTER): TUPLE [POINTER]
			-- Tuple containing integer value from first of `args'.
		do
			(App_implementation.gtk_marshal).pointer_tuple.put ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args), 1)
			Result := (App_implementation.gtk_marshal).pointer_tuple
			--	Result := [(App_implementation.gtk_marshal).gtk_value_pointer (args)]
		end

	call_button_event_actions (
			a_type: INTEGER
			a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		
		local
			t : TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE,
				INTEGER, INTEGER]
			tree_item_imp: EV_TREE_NODE_IMP
			timeout_imp: EV_TIMEOUT_IMP

		do
			Precursor {EV_PRIMITIVE_IMP} (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			t := [a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y]

			tree_item_imp := item_from_coords (a_x, a_y)

			if a_type = {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_ENUM then
				if
					tree_item_imp /= Void and then tree_item_imp.pointer_button_press_actions_internal /= Void then
							--| This prevents freezing on possible show_modal_to_window calls for dialogs
						if not {EV_GTK_EXTERNALS}.gtk_ctree_is_hot_spot (list_widget, a_x, a_y) then
							timeout_imp ?= (create {EV_TIMEOUT}).implementation
							timeout_imp.interface.actions.extend (agent (tree_item_imp.pointer_button_press_actions_internal).call (t))
							timeout_imp.set_interval_kamikaze (100)
						end
				end
			elseif a_type = {EV_GTK_EXTERNALS}.GDK_2BUTTON_PRESS_ENUM then
				if tree_item_imp /= Void and then tree_item_imp.pointer_double_press_actions_internal /= Void then
					if not {EV_GTK_EXTERNALS}.gtk_ctree_is_hot_spot (list_widget, a_x, a_y) then
						tree_item_imp.pointer_double_press_actions_internal.call (t)
					end
				end
			end
		end

	motion_handler (a_x, a_y: INTEGER; a_a, a_b, a_c: DOUBLE; a_d, a_e: INTEGER)
			-- Handle motion events on 'Current'
		local
			t: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
			a_row_imp: EV_TREE_NODE_IMP
		do
			t := [a_x, a_y, a_a, a_b, a_c, a_d, a_e]
			if pointer_motion_actions_internal /= Void then
				pointer_motion_actions_internal.call (t)
			end

			a_row_imp := item_from_coords (a_x, a_y)
			if a_row_imp /= Void then
				if a_row_imp.pointer_motion_actions_internal /= Void then
					a_row_imp.pointer_motion_actions_internal.call (t)
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

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	expand_callback (a_tree_item: POINTER)
			-- Expand callback passing expanded `a_tree_item' node pointer.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void then
				a_tree_node_imp.expand_callback
			end
			if timer.interval = 0 then
				timer.set_interval (timer_interval)
			end
		end

	collapse_callback (a_tree_item: POINTER)
			-- Collapse callback passing collapsed `a_tree_item' node pointer.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void then
				a_tree_node_imp.collapse_callback
			end
			if timer.interval = 0 then
				timer.set_interval (timer_interval)
			end
		end

	selected_node: EV_TREE_NODE_IMP

	select_callback (a_tree_item: POINTER)
			-- Called when a tree item is selected
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void then
				if a_tree_node_imp /= selected_node then
					selected_node := a_tree_node_imp
					if select_actions_internal /= Void then
						select_actions_internal.call (Void)
					end
					if a_tree_node_imp.select_actions_internal /= Void then
						a_tree_node_imp.select_actions_internal.call (Void)
					end
				end
			else
				selected_node := Void
			end
		end

	deselect_callback (a_tree_item: POINTER)
			-- Called when a tree item is deselected.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void and selected_node = a_tree_node_imp then
				selected_node := Void
				if deselect_actions_internal /= Void then
					deselect_actions_internal.call (Void)
				end
				if a_tree_node_imp.deselect_actions_internal /= Void then
					a_tree_node_imp.deselect_actions_internal.call (Void)
				end
			end
		end

feature -- Status report

	selected_item: EV_TREE_NODE
			-- Item which is currently selected.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			a_tree_node_imp := selected_item_imp
			if a_tree_node_imp /= Void then
				Result := a_tree_node_imp.interface
			end
		end

	selected_item_imp: EV_TREE_NODE_IMP
			-- Item which is currently selected.
		local
			temp_item_ptr: POINTER
		do
			temp_item_ptr := {EV_GTK_EXTERNALS}.gtk_clist_struct_selection (list_widget)
			if temp_item_ptr /= NULL then
				temp_item_ptr := {EV_GTK_EXTERNALS}.g_list_nth_data (temp_item_ptr, 0)
				-- This is incase of unwanted items due to wipeout hack.
				Result := tree_node_ptr_table.item (temp_item_ptr)
			end
		end

	selected: BOOLEAN
			-- Is one item selected?
		do
			Result := selected_item /= Void
		end

feature -- Implementation

	set_to_drag_and_drop: BOOLEAN
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_drag_and_drop
			else
				Result := mode_is_drag_and_drop
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
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

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN
			-- Is list or row able to display PND menu using `a_button'
		do
			if pnd_row_imp /= Void then
				Result := pnd_row_imp.mode_is_target_menu and then a_button = 3
			else
				Result := mode_is_target_menu and then a_button = 3
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
		do
			pnd_row_imp := item_from_coords (a_x, a_y)

			if pnd_row_imp /= Void and then not pnd_row_imp.able_to_transport (a_button) then
				pnd_row_imp := Void
			end
			Precursor (
				a_type,
				a_x, a_y, a_button,
				a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y
			)
		end

	pnd_row_imp: EV_TREE_NODE_IMP
			-- Implementation object of the current row if in PND transport.

	temp_pebble: ANY
			-- Temporary pebble holder used for PND implementation with nodes.

	temp_pebble_function: FUNCTION [ANY, TUPLE [], ANY]
			-- Returns data to be transported by PND mechanism.

	temp_accept_cursor, temp_deny_cursor: EV_POINTER_STYLE

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
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

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Steps to perform before transport initiated.
		do
			temp_accept_cursor := accept_cursor
			temp_deny_cursor := deny_cursor
			App_implementation.on_pick (Current, pebble)

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

			pointer_x := a_screen_x.to_integer_16
			pointer_y := a_screen_y.to_integer_16

			if pnd_row_imp = Void then
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
				if (pnd_row_imp.pick_x = 0 and then pnd_row_imp.pick_y = 0) then
					App_implementation.set_x_y_origin (a_screen_x, a_screen_y)
				else
					if pick_x > width then
						pick_x := width.to_integer_16
					end
					if pick_y > row_height then
						pick_y := row_height.to_integer_16
					end
					App_implementation.set_x_y_origin (
						pnd_row_imp.pick_x + (a_screen_x - a_x),
						pnd_row_imp.pick_y +
						(a_screen_y - a_y) +
						((child_array.index_of (pnd_row_imp.interface, 1) - 1) * row_height)
					)
				end
			end
		end

	post_drop_steps (a_button: INTEGER)
			-- Steps to perform once an attempted drop has happened.
		do
			App_implementation.set_x_y_origin (0, 0)

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

	item_from_coords (a_x, a_y: INTEGER): EV_TREE_NODE_IMP
		local
			temp_row_ptr: POINTER
		do
			temp_row_ptr := {EV_GTK_EXTERNALS}.gtk_ctree_node_nth (list_widget, a_y // (row_height + 1))
			if temp_row_ptr /= NULL then
				Result := tree_node_ptr_table.item (temp_row_ptr)
			end
		end

feature {NONE} -- Implementation

	ensure_item_visible (an_item: EV_TREE_ITEM)
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		local
			tree_item_imp: EV_TREE_NODE_IMP
			parent_item_imp: EV_TREE_ITEM_IMP
		do
			from
				tree_item_imp ?= an_item.implementation
				parent_item_imp ?= tree_item_imp.parent_imp
			until
				parent_item_imp = Void
			loop
				if not tree_item_imp.is_viewable then
					parent_item_imp.set_expand (True)
				end
				tree_item_imp := parent_item_imp
				parent_item_imp ?= tree_item_imp.parent_imp
			end
				-- Show the node `an_item'
			tree_item_imp ?= an_item.implementation
			{EV_GTK_EXTERNALS}.gtk_ctree_node_moveto (list_widget, tree_item_imp.tree_node_ptr, 0, 0.0, 1.0)
		end

	previous_selected_item: EV_TREE_NODE
			-- Item that was selected previously.

	count: INTEGER
			-- Number of children
		do
			Result := ev_children.count
		end

	i_th (i: INTEGER): EV_TREE_NODE
			-- `i'_th child of Current.
		do
			Result := (ev_children @ i).interface
		end

	append (s: SEQUENCE [EV_TREE_ITEM])
			-- Add 's' to 'Current'
		do
			Precursor (s)
		end

	wipe_out
			-- Remove all items.
		local
			item_imp: EV_TREE_NODE_IMP
		do
				-- Remove all items (GTK part)
			{EV_GTK_EXTERNALS}.gtk_clist_clear (list_widget)
			from
				ev_children.start
			until
				ev_children.after
			loop
				item_imp := ev_children.item
				item_imp.set_item_and_children (NULL, NULL)
				item_imp.set_parent_imp (Void)
				ev_children.forth
			end

			-- Remove all items (Eiffel part)
			create ev_children.make (0)
			create child_array.make (5)
			tree_node_ptr_table.clear_all

			index := 0

			update_pnd_status
		end

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			item_imp.set_item_and_children (NULL, NULL)
			item_imp.check_branch_pixmaps
			ev_children.force (item_imp)

			if item_imp.is_transport_enabled_iterator then
				update_pnd_connection (True)
			end

			child_array.go_i_th (i)
			child_array.put_left (v)
			if i < count then
				{EV_GTK_EXTERNALS}.gtk_clist_row_move (list_widget, item_imp.index - 1, i - 1)
				ev_children.prune_all (item_imp)
				ev_children.go_i_th (i)
				ev_children.put_left (item_imp)
			end
			if count = 1 then
				selected_node := item_imp
				item_imp.enable_select
				selected_node := Void
			end
		end

	remove_i_th (a_position: INTEGER)
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_NODE_IMP
		do
			item_imp := (ev_children @ (a_position))

				-- Remove from tree
			{EV_GTK_EXTERNALS}.gtk_ctree_remove_node (list_widget, item_imp.tree_node_ptr)
			item_imp.set_item_and_children (NULL, NULL)
			item_imp.set_parent_imp (Void)

				-- remove the row from the `ev_children'
			ev_children.go_i_th (a_position)
			ev_children.remove

			child_array.go_i_th (a_position)
			child_array.remove

			update_pnd_status
		end

feature {EV_TREE_NODE_IMP} -- Implementation

	spacing: INTEGER = 3
			-- Spacing between pixmap and text.

	row_height: INTEGER
			-- Height of rows in tree
		do
			Result := {EV_GTK_EXTERNALS}.gtk_clist_struct_row_height (list_widget)
		end

	insert_ctree_node (a_item_imp: EV_TREE_NODE_IMP; par_node, a_sibling: POINTER): POINTER
			-- Insert 'a_item_imp' in 'par_node' above 'a_sibling' sibling node.
		local
			text_ptr: POINTER
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_item_imp.text
			text_ptr := a_cs.item
			Result := {EV_GTK_EXTERNALS}.gtk_ctree_insert_node (
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

feature {NONE} -- Implementation

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end

feature {NONE} -- Externals

	frozen gtk_ctree_lines_dotted_enum: INTEGER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_CTREE_LINES_DOTTED"
		end

	frozen gtk_ctree_expander_square_enum: INTEGER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_CTREE_EXPANDER_SQUARE"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TREE_IMP

