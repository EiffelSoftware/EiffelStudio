indexing
	description: "EiffelVision list item list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface,
			wipe_out
		end

	EV_PRIMITIVE_IMP
		redefine
			pointer_over_widget,
			initialize,
			interface,
			make,
			create_focus_in_actions,
			create_focus_out_actions
		end

	EV_ITEM_LIST_IMP [EV_LIST_ITEM]
		redefine
			interface,
			list_widget,
			add_to_container,
			remove_i_th,
			wipe_out,
			initialize
		end
	
	EV_LIST_ITEM_LIST_ACTION_SEQUENCES_IMP
	
	EV_KEY_CONSTANTS

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a list widget with `par' as parent.
			-- By default, a list allow only one selection.
		do
			base_make (an_interface)

			set_c_object (C.gtk_scrolled_window_new (NULL, NULL))
		
					-- Creating the gtk_list, pointed by `list_widget':
			list_widget := C.gtk_list_new
			gtk_widget_set_flags (
				c_object,
				C.GTK_CAN_FOCUS_ENUM
			)
			C.gtk_scrolled_window_set_policy (
				c_object,
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)

			C.gtk_widget_show (list_widget)
			C.gtk_scrolled_window_add_with_viewport (
				c_object,
				list_widget
			)
			real_signal_connect (
				list_widget,
				"unselect_child",
				agent (App_implementation.gtk_marshal).list_item_deselect_callback_intermediary (c_object, ?, ?),
				Void
			)
		end

	initialize is
		do
			{EV_ITEM_LIST_IMP} Precursor
			{EV_PRIMITIVE_IMP} Precursor

			real_signal_connect (
				list_widget,
				"select_child",
				agent (App_implementation.gtk_marshal).list_item_select_callback_intermediary (c_object, ?, ?),
				Void
			)
			real_signal_connect (
				visual_widget,
				"button-press-event",
				agent (App_implementation.gtk_marshal).list_clicked_intermediary (c_object),
				App_implementation.default_translate
			)
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Initialization

	select_callback (n_args: INTEGER; args: POINTER) is
			-- Called when a list item is selected.
		require
			one_arg: n_args = 1
		deferred
		end
		
	deselect_callback (n_args: INTEGER; args: POINTER) is
			-- Called when a list item is deselected.
		require
			one_arg: n_args = 1
		local
			l_item: EV_LIST_ITEM_IMP
		do
		 	l_item ?= eif_object_from_c (
				(App_implementation.gtk_marshal).gtk_value_pointer (args)
			)
			if l_item.deselect_actions_internal /= Void then
				l_item.deselect_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)
			end

			if deselect_actions_internal /= Void then
				deselect_actions_internal.call ([l_item.interface])
			end

			previous_selected_item_imp := Void
		end

feature -- Status report

	selected_item: EV_LIST_ITEM is
			-- Currently selected item if any.
		local
			item_pointer: POINTER
		do
			item_pointer := C.gtk_list_struct_selection (list_widget)
			if item_pointer /= NULL then
				item_pointer := C.gslist_struct_data (item_pointer)
				if item_pointer /= NULL then
					Result ?= eif_object_from_c (item_pointer).interface
					check Result_not_void: Result /= Void end
				end
			end
		end

	selected: BOOLEAN is
			-- Is one item selected?
		local
			list_pointer: POINTER
		do
			list_pointer := C.gtk_list_struct_selection (list_widget)
			if list_pointer /= NULL then
				Result := C.g_list_length (list_pointer) > 0
			end
		end
		
feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Give the item of the list at the one-base index.
		do
			C.gtk_list_select_item (list_widget, an_index - 1)
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			C.gtk_list_unselect_item (list_widget, an_index - 1)
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			C.gtk_list_unselect_all (list_widget)
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		local
			item_imp: EV_LIST_ITEM_IMP
			a_child_list: POINTER
		do
			clear_selection
			a_child_list := C.gtk_container_children (list_widget)
			C.gtk_list_remove_items_no_unref (list_widget, a_child_list)
			C.g_list_free (a_child_list)
			from
				start
			until
				index > count
			loop
				item_imp ?= item.implementation
				item_imp.set_item_parent_imp (Void)
				forth
			end
			child_array.wipe_out
			index := 0
		end

feature {EV_APPLICATION_IMP} -- Implementation

	pointer_over_widget (a_gdkwin: POINTER; a_x, a_y: INTEGER): BOOLEAN is
			-- Is mouse pointer over widget.
		do
			Result := a_gdkwin = C.gtk_widget_struct_window (list_widget)
		end
		
feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_IMP} -- Implementation

	previous_selected_item_imp: EV_LIST_ITEM_IMP
			-- Item that was selected previously.

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		local
			item_list, item_pointer, new_item_list: POINTER
				-- Single element glist holding `a_child'.
			a_child_list: POINTER
			a_child_pos: INTEGER
		do
			a_child_list := C.gtk_container_children (a_container)
			a_child_pos := C.gtk_list_child_position (a_container, a_child)
			check
				a_child_pos_correct: a_child_pos >= 0 and a_child_pos < count
			end
			item_list := C.g_list_nth (
						a_child_list,
						a_child_pos
					)	
			check
				item_list_not_null: item_list /= NULL
			end
			new_item_list := C.g_list_copy (item_list)
			item_list := NULL
			C.g_list_free (a_child_list)
			item_pointer := C.g_list_nth_data (new_item_list, 0)
			C.gtk_object_ref (item_pointer)
			C.gtk_container_remove (a_container, item_pointer)
			C.gtk_list_insert_items (a_container, new_item_list, a_position)
		end

	interface: EV_LIST_ITEM_LIST

	list_widget: POINTER
	
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation	
	
	on_list_clicked is
			-- The list was clicked.
		do
			if not has_focus then
				set_focus	
			end
			if not list_has_been_clicked then
				clear_selection
			end
			list_has_been_clicked := False
		end	
	
feature {NONE} -- Implementation

	call_select_actions (selected_item_imp: EV_LIST_ITEM_IMP) is
			-- Call `select_actions'.
		do
			if previous_selected_item_imp /= Void and then
				previous_selected_item_imp.parent = interface and then
				previous_selected_item_imp /= selected_item_imp then
				if previous_selected_item_imp.deselect_actions_internal /= Void then
					previous_selected_item_imp.deselect_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)
				end
			end
			
			if selected_item_imp.parent /= Void and then selected_item_imp.is_selected then
					-- Parent check due to bug in combo box.
				if selected_item_imp.select_actions_internal /= Void then
					selected_item_imp.select_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)
				end
				if select_actions_internal /= Void then
					select_actions_internal.call ([selected_item_imp.interface])
				end
				previous_selected_item_imp := selected_item_imp
			elseif selected_item_imp.parent /= Void then
				if deselect_actions_internal /= Void then
					deselect_actions_internal.call ([selected_item_imp.interface])
				end
				previous_selected_item_imp := Void
			end
		end

	remove_i_th (an_index: INTEGER) is
		local
			f_i: EV_LIST_ITEM
			item_imp: EV_LIST_ITEM_IMP
		do
			clear_selection
			f_i := focused_item
			if f_i /= Void and then f_i.is_equal (i_th (an_index)) then
				list_has_been_clicked := True
				if count > 1 then
					if index < count then
						item_imp ?= i_th (index + 1).implementation
					else
						item_imp ?= i_th (index - 1).implementation
					end
					item_imp.set_focus
					Precursor (an_index)
				else
					Precursor (an_index)
					set_focus
				end
				list_has_been_clicked := False
			else
				Precursor (an_index)
			end
		end
		
	add_to_container (v: like item; v_imp: EV_ITEM_IMP) is
			-- Add `v' to end of list.
			-- (from EV_ITEM_LIST_IMP)
			-- (export status {NONE})
		do
			C.gtk_container_add (list_widget, v_imp.c_object)
			v_imp.set_item_parent_imp (Current)

			v_imp.real_signal_connect (
				v_imp.c_object,
				"key-press-event",
				agent (App_implementation.gtk_marshal).list_key_pressed_intermediary (c_object, ?, ?, ?),
				key_event_translate_agent
			)	
			v_imp.real_signal_connect (
				v_imp.c_object,
				"button-press-event",
				agent (App_implementation.gtk_marshal).list_item_clicked_intermediary (c_object),
				App_implementation.default_translate
				)
			v_imp.key_press_actions.extend (agent on_key_pressed)
		end

	create_focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- 	
		do
			create Result
		end
	
	create_focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- 
		do
			create Result
		end

	focused_item: EV_LIST_ITEM is
			-- item of the list which has currently the focus.
		local
			item_imp: EV_LIST_ITEM_IMP
			indx: INTEGER
		do
			indx := index
			from
				start
			until
				index > count
			loop
				item_imp ?= item.implementation
				if item_imp /= Void and then gtk_widget_has_focus (item_imp.c_object) then
					Result := item
				end
				forth
			end
			index := indx
		ensure
			index = old index
		end

	arrow_used: BOOLEAN
		-- Has the user just used up or down arrows
		-- to change the focused item?
		
	list_has_been_clicked: BOOLEAN
		-- Are we between "item_clicked" and "list_clicked" event.
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation
		
	on_key_pressed (ev_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Called when a list item is selected.
		local
			f_item: EV_LIST_ITEM
		do
			f_item := focused_item
			if count = 0 or else ev_key = Void or else f_item = Void then
				arrow_used := False
			elseif ev_key.code = Key_up then
				start
				arrow_used := not item.is_equal (f_item)
			elseif ev_key.code = Key_down then
				go_i_th (count)
				arrow_used := not item.is_equal (f_item)
			end
			on_key_event (ev_key, a_key_string, a_key_press)
		end
		
	on_item_clicked is
			-- One of the item has been clicked.
		do
				-- When the user clicks on one of the items of the list
				-- this routine is called, then `lose_focus', then `attain_focus'
				-- then `on_list_clicked'. `list_has_been_clicked' will prevent the 
				-- `focus_out_actions' from being called.
			list_has_been_clicked := True
		end

end -- class EV_LIST_ITEM_LIST_IMP

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

