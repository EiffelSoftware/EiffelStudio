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
			call_pebble_function
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			destroy,
			initialize,
			visual_widget,
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
			call_pebble_function
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		redefine
			interface,
			remove_i_th,
			reorder_child,
			i_th,
			add_to_container,
			list_widget,
			visual_widget,
			count
		end

	EV_TREE_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty Tree.
		local
			a_event_box: POINTER
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
			a_event_box := C.gtk_event_box_new
			C.gtk_widget_show (a_event_box)
			C.gtk_container_add (a_event_box, list_widget)
			--C.gtk_widget_set_usize (list_widget, 100, 100)
			C.gtk_ctree_set_line_style (list_widget, C.GTK_CTREE_LINES_DOTTED_ENUM)
			C.gtk_clist_set_selection_mode (list_widget, C.GTK_SELECTION_BROWSE_ENUM)
			C.gtk_ctree_set_expander_style (list_widget, C.GTK_CTREE_EXPANDER_SQUARE_ENUM)
			C.gtk_clist_set_shadow_type (list_widget, C.GTK_SHADOW_NONE_ENUM)	
			C.gtk_scrolled_window_add_with_viewport (c_object, a_event_box)
			C.gtk_widget_show (list_widget)
			create ev_children.make (0)
			create tree_node_ptr_table.make (100)
			-- Make initial hash table with room for 100 child pointers, may be increased later.
			C.gtk_clist_set_row_height (list_widget, row_height)
		end

	initialize is
			-- Connect action sequences to signals.

		do
			{EV_PRIMITIVE_IMP} Precursor
			{EV_TREE_I} Precursor
			real_signal_connect (visual_widget, "motion_notify_event", ~motion_handler, Default_translate)


			real_signal_connect (
				list_widget,
				"tree-select-row",
				~select_callback,
				~gtk_value_pointer_to_tuple
			)

			real_signal_connect (
				list_widget,
				"tree-expand",
				~expand_callback,
				~gtk_value_pointer_to_tuple
			)

			real_signal_connect (
				list_widget,
				"tree-collapse",
				~collapse_callback,
				~gtk_value_pointer_to_tuple
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
			Result := [gtk_value_pointer (args)]
		end

	row_from_y_coord (a_y: INTEGER): EV_TREE_NODE_IMP is
		local
			temp_row_ptr: POINTER
		do
			temp_row_ptr := C.gtk_ctree_node_nth (list_widget, a_y // (row_height + 1))
			if temp_row_ptr /= NULL then
				Result := tree_node_ptr_table.item (temp_row_ptr)
			end
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

feature {EV_TREE_NODE_IMP} -- Implementation

	tree_node_ptr_table: HASH_TABLE [EV_TREE_NODE_IMP, POINTER]
			-- Hash table linking tree node pointers to eiffel implementation objects.

feature {NONE} -- Implementation

	dummy_tree_node: POINTER
		-- Added to prevent seg fault on wipeout by adding temporarily

	expand_callback (a_tree_item: POINTER) is
			-- Expand callback passing expanded `a_tree_item' node pointer.
		local
			a_tree_node_imp: EV_TREE_NODE_IMP
		do
			--C.gtk_clist_freeze (list_widget)
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void and then a_tree_node_imp.expand_actions_internal /= Void then
				a_tree_node_imp.expand_callback
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
			if a_tree_node_imp /= Void and then a_tree_node_imp.collapse_actions_internal /= Void then
				a_tree_node_imp.collapse_callback
			end
			C.gtk_clist_thaw (list_widget)
		end

	select_callback (a_tree_item: POINTER) is
			-- Called when a tree item is selected
		local
			a_tree_node_imp: EV_TREE_NODE_IMP

		do
			a_tree_node_imp := tree_node_ptr_table.item (a_tree_item)
			if a_tree_node_imp /= Void then
				if select_actions_internal /= Void then
					select_actions_internal.call ([])
				end
				if a_tree_node_imp.select_actions_internal /= Void then
					a_tree_node_imp.select_actions_internal.call ([])
				end
			end

			--if previous_selected_item /= Void and then
			--previous_selected_item.parent_tree = interface and then
			--previous_selected_item /= t_item.interface then
			--	p_item ?= previous_selected_item.implementation
			--	if p_item.deselect_actions_internal /= Void then
			--		p_item.deselect_actions_internal.call ([])
			--	end
			--end
			
			--if t_item.is_selected then
			--	if t_item.select_actions_internal /= Void then
			--		t_item.select_actions_internal.call ([])
			--	end
			--	if select_actions_internal /= Void then
			--		select_actions_internal.call ([t_item.interface])
			--	end
			--	previous_selected_item := t_item.interface
			--else
			--	if deselect_actions_internal /= Void then
			--		deselect_actions_internal.call ([t_item.interface])
			--	end
			--	previous_selected_item := Void
			--end		
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
			signal_connect ("button-press-event", ~start_transport_filter, default_translate)
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
		do
			from
				ev_children.start
			until
				ev_children.after or else a_enable_flag
			loop
				a_enable_flag := ev_children.item.is_transport_enabled_iterator
				ev_children.forth
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

			if accept_cursor = Void then
				--| FIXME IEK
				create accept_cursor--.make_with_code (curs_code.standard)
			end
			if deny_cursor = Void then
				create deny_cursor--.make_with_code (curs_code.no)
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
		local
			env: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			if pnd_row_imp /= Void then
				if pnd_row_imp.mode_is_pick_and_drop then
					signal_emit_stop (visual_widget, "button-press-event")
				end
			elseif mode_is_pick_and_drop then
					signal_emit_stop (visual_widget, "button-press-event")
			end
			create env
			app_imp ?= env.application.implementation
			check
				app_imp_not_void: app_imp /= Void
			end

			app_imp.on_drop (pebble)
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


feature {NONE} -- Implementation

	ensure_item_visible (an_item: EV_TREE_ITEM) is
			-- Ensure `an_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		local
--			item_alloc_y: INTEGER
--			v_adjustment: POINTER
		do
--			-- Move down in to ev_list_imp or refactor a scrolled window pointer.
--			item_alloc_y := C.gtk_allocation_struct_y (
--				C.gtk_widget_struct_allocation (l_item.c_object)
--			)
--			if item_alloc_y /= -1 then
--				--print ("Scroll window to " + item_alloc_y.out + "%N")
--				v_adjustment := C.gtk_scrolled_window_get_vadjustment (c_object)
--				C.set_gtk_adjustment_struct_value (v_adjustment, item_alloc_y)
--				C.gtk_scrolled_window_set_vadjustment (c_object, v_adjustment)
--			end
		end

	spacing: INTEGER is 5
		-- Spacing between pixmap and text.

	row_height: INTEGER is 15

	previous_selected_item: EV_TREE_NODE
		-- Item that was selected previously.

	count: INTEGER is
		do
			Result := ev_children.count
		end

	i_th (i: INTEGER): EV_TREE_NODE is
		do
			Result := (ev_children @ i).interface
		end

	add_to_container (v: like item) is
			-- Add `v' to tree at position `i'.
		local
			item_imp: EV_TREE_NODE_IMP
		do
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			item_imp.set_item_and_children (NULL)
			item_imp.insert_pixmap
			ev_children.force (item_imp)
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

			update_pnd_status
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position' in Current.
		local
			item_imp: EV_TREE_NODE_IMP
			temp_list: like ev_children
			a_counter: INTEGER
		do
			item_imp ?= v.implementation
			C.gtk_clist_row_move (
				list_widget,
				item_imp.index - 1,
				a_position - 1
			)
			-- Insert `v' in to ev_children list.	

			create temp_list.make (0)
			from
				a_counter := 1
			until
				a_counter = a_position
			loop
				temp_list.extend (ev_children.i_th (a_counter))
				a_counter := a_counter + 1
			end
			
			-- Insert `v' at a_position
			temp_list.extend (item_imp)

			from
				a_counter := a_position
			until
				a_counter = count
				-- The child to be reordered is always at i_th (count)
				-- Ie: We are reordering and truncating.
			loop
				temp_list.extend (ev_children.i_th (a_counter))
				a_counter := a_counter + 1
			end

			ev_children := temp_list	
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check  do_not_call: False end
		end

feature {EV_TREE_NODE_IMP} -- Implementation

	insert_ctree_node (
			a_item_imp: EV_TREE_NODE_IMP;
			par_node, a_sibling: POINTER
			): POINTER is
		local
			text_ptr: POINTER
		do
			C.gtk_label_get (a_item_imp.text_label, $text_ptr)	
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

	visual_widget: POINTER is
		do
			Result := list_widget
		end

	list_widget: POINTER
		-- Pointer to the gtktree widget.

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE

end -- class EV_TREE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.47  2001/07/02 16:19:57  king
--| Uncommented as of yet unused locals
--|
--| Revision 1.46  2001/06/29 22:37:41  king
--| Added unimplemented ensure_item_visible
--|
--| Revision 1.45  2001/06/15 19:30:52  king
--| Removed unnecessary freezing and thawing
--|
--| Revision 1.44  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.17.4.25  2001/06/05 01:37:22  king
--| Commented out unneeded freeze/thaws, reverted to scrolled window
--|
--| Revision 1.17.4.24  2001/05/18 18:19:28  king
--| Using container_add instead of add_with_viewport
--|
--| Revision 1.17.4.23  2001/05/10 22:34:36  king
--| Total reimplementation of trees
--|
--| Revision 1.17.4.22  2001/04/13 23:59:44  king
--| Changed selection style to that of windows
--|
--| Revision 1.17.4.21  2000/10/27 16:54:44  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.17.4.20  2000/09/06 23:18:48  king
--| Reviewed
--|
--| Revision 1.17.4.19  2000/08/28 16:45:05  king
--| Removed event_widget
--|
--| Revision 1.17.4.18  2000/08/08 00:03:16  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.17.4.17  2000/08/02 23:10:03  king
--| Fixed select_callback to only call AS if not void
--|
--| Revision 1.17.4.16  2000/07/24 21:36:10  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.17.4.15  2000/07/06 19:58:13  king
--| Added view mode comment
--|
--| Revision 1.17.4.14  2000/07/06 19:03:01  king
--| Changed view mode to prevent gdk error output
--|
--| Revision 1.17.4.13  2000/07/04 00:50:19  king
--| Explicitly setting root_tree due to gtk bug
--|
--| Revision 1.17.4.12  2000/06/28 00:20:10  king
--| c_object now scrollable_window from event_box
--|
--| Revision 1.17.4.11  2000/06/27 23:51:18  king
--| Redefined visual_widget
--|
--| Revision 1.17.4.10  2000/06/08 00:24:03  king
--| Implemented select signal handling
--|
--| Revision 1.17.4.9  2000/05/18 20:53:29  king
--| Add result check
--|
--| Revision 1.17.4.8  2000/05/16 21:15:57  king
--| Changed EV_TREE_ITEM->EV_TREE_NODE
--|
--| Revision 1.17.4.7  2000/05/16 16:56:20  oconnor
--| updated for EV_TREE_NODE
--|
--| Revision 1.17.4.6  2000/05/16 00:29:01  king
--| Redefined colorize object to return list_widget
--|
--| Revision 1.17.4.5  2000/05/08 23:04:56  king
--| Made c enumeration calls UPPERCASE
--|
--| Revision 1.17.4.2  2000/05/05 22:19:18  king
--| Implemented to use insert_i_th
--|
--| Revision 1.17.4.1  2000/05/03 19:08:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.42  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.41  2000/04/26 00:13:42  king
--| Made compilable with initialize in _I
--|
--| Revision 1.40  2000/04/06 23:52:37  brendel
--| Added list_widget.
--|
--| Revision 1.39  2000/04/06 02:05:50  brendel
--| Changed to comply with new EV_DYNAMIC_LIST_IMP.
--|
--| Revision 1.38  2000/04/04 21:00:33  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.37  2000/03/21 21:52:30  king
--| Made c_object an event box
--|
--| Revision 1.36  2000/03/13 22:10:13  king
--| Added reference handling for child reordering
--|
--| Revision 1.35  2000/03/10 23:53:10  king
--| Fixed dereferencing of list widget
--|
--| Revision 1.34  2000/03/09 19:56:46  king
--| Removed multiple-selection features as they are not available on win32
--|
--| Revision 1.33  2000/03/07 01:28:18  king
--| Optimized loop by adding and then
--|
--| Revision 1.32  2000/03/06 20:13:51  king
--| Made compatible with new action sequence
--|
--| Revision 1.31  2000/03/02 00:27:49  king
--| Updated bug comment
--|
--| Revision 1.30  2000/03/01 23:42:46  king
--| Corrected select_callback, corrected initialize
--|
--| Revision 1.29  2000/03/01 18:09:22  oconnor
--| released
--|
--| Revision 1.28  2000/03/01 18:06:44  king
--| Corrected selected_item comment
--|
--| Revision 1.27  2000/02/29 22:29:35  king
--| Merged selection callbacks in to one due to gtk bug
--|
--| Revision 1.26  2000/02/29 00:01:53  king
--| Added multiple selection features
--|
--| Revision 1.25  2000/02/26 01:28:43  king
--| Implemented to set sub_tree of children
--|
--| Revision 1.24  2000/02/24 21:40:08  king
--| Removed calling of subtree removal from item removal
--|
--| Revision 1.23  2000/02/24 20:11:05  king
--| corrected indentation
--|
--| Revision 1.22  2000/02/24 01:50:37  king
--| Implemented event handling
--|
--| Revision 1.21  2000/02/22 23:57:32  king
--| Implemented selecrted_item
--|
--| Revision 1.20  2000/02/22 21:37:40  king
--| Initial implementation to fit in with new structure
--|
--| Revision 1.19  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.18  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.6.2  2000/01/27 19:29:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.6.1  1999/11/24 17:29:59  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.2.3  1999/11/17 01:53:06  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.17.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
