indexing
	description: "EiffelVision list item list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface
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
			remove_i_th
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
			gtk_widget_set_flags (
				c_object,
				C.GTK_CAN_FOCUS_ENUM
			)
			C.gtk_scrolled_window_set_policy (
				c_object,
				C.GTK_POLICY_AUTOMATIC_ENUM,
				C.GTK_POLICY_AUTOMATIC_ENUM
			)

			-- Creating the gtk_list, pointed by `list_widget':
			list_widget := C.gtk_list_new

			C.gtk_widget_show (list_widget)
			C.gtk_scrolled_window_add_with_viewport (
				c_object,
				list_widget
			)
			real_signal_connect (
				list_widget,
				"unselect_child",
				~deselect_callback,
				Void
			)
		end

	initialize is
		local
			temp_sig_id: INTEGER
		do
			{EV_PRIMITIVE_IMP} Precursor
			real_signal_connect (
				list_widget,
				"select_child",
				~select_callback,
				Void
			)
			gtk_widget_set_flags (
				visual_widget,
				C.GTK_CAN_FOCUS_ENUM
			)
			temp_sig_id := c_signal_connect (
					visual_widget,
					eiffel_to_c ("button-press-event"),
					~on_list_clicked
			)
			selection_mode_is_single := True
		end
		
	select_callback (n_args: INTEGER; args: POINTER) is
			-- Called when a list item is selected.
		require
			one_arg: n_args = 1
		local
			l_item: EV_LIST_ITEM_IMP
		do
			switch_to_browse_mode_if_necessary		
		 	l_item ?= eif_object_from_c (
				gtk_value_pointer (args)
			)
			call_select_actions (l_item)
		end

	deselect_callback (n_args: INTEGER; args: POINTER) is
			-- Called when a list item is deselected.
		require
			one_arg: n_args = 1
		local
			l_item: EV_LIST_ITEM_IMP
		do
		 	l_item ?= eif_object_from_c (
				gtk_value_pointer (args)
			)
			if l_item.deselect_actions_internal /= Void then
				l_item.deselect_actions_internal.call ([])
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
			-- Select the item of the list at the one-based
			-- `index'.
		do
			switch_to_browse_mode_if_necessary
			C.gtk_list_select_item (list_widget, an_index - 1)
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			switch_to_single_mode_if_necessary
			C.gtk_list_unselect_item (list_widget, an_index - 1)
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			switch_to_single_mode_if_necessary
			C.gtk_list_unselect_all (list_widget)
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
			item_pointer: POINTER
				-- Single element glist holding `a_child'.
		do
			item_pointer := C.g_list_nth (
						C.gtk_container_children (a_container),
						C.gtk_list_child_position (a_container, a_child)
					)
			check
				item_pointer_not_null: item_pointer /= NULL
			end
			C.gtk_list_remove_items_no_unref (a_container, item_pointer)
			C.gtk_list_insert_items (a_container, item_pointer, a_position)
		end

	interface: EV_LIST_ITEM_LIST

	list_widget: POINTER
	
feature {NONE} -- Implementation

	switch_to_single_mode_if_necessary is
			-- 
		deferred
		end
	
	switch_to_browse_mode_if_necessary is
			-- 
		deferred
		end

	call_select_actions (selected_item_imp: EV_LIST_ITEM_IMP) is
			-- Call `select_actions'.
		do
			if previous_selected_item_imp /= Void and then
				previous_selected_item_imp.parent = interface and then
				previous_selected_item_imp /= selected_item_imp then
				if previous_selected_item_imp.deselect_actions_internal /= Void then
					previous_selected_item_imp.deselect_actions_internal.call ([])
				end
			end
			
			if selected_item_imp.parent /= Void and then selected_item_imp.is_selected then
					-- Parent check due to bug in combo box.
				if selected_item_imp.select_actions_internal /= Void then
					selected_item_imp.select_actions_internal.call ([])
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
		
	add_to_container (v: like item) is
			-- Add `v' to end of list.
			-- (from EV_ITEM_LIST_IMP)
			-- (export status {NONE})
		local
			v_imp: EV_ITEM_IMP
			temp_sig_id: INTEGER
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= void
			end
			C.gtk_container_add (list_widget, v_imp.c_object)
--			gtk_widget_unset_flags (v_imp.c_object, C.GTK_CAN_FOCUS_ENUM)
			temp_sig_id := c_signal_connect (
				v_imp.c_object,
				eiffel_to_c ("button-press-event"),
				~on_item_clicked
				)
			real_signal_connect (
				v_imp.c_object,
				"key-press-event",
				~on_key_pressed,
				~key_event_translate
			)	
			v_imp.key_press_actions.extend (~on_key_pressed)
		end

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
			switch_to_browse_mode_if_necessary
		end
	
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
		
	create_focus_in_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- 	
		do
			create Result
		end
	
	create_focus_out_actions: EV_FOCUS_ACTION_SEQUENCE is
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
				if 
					item_imp /= Void 
						and then
					gtk_widget_has_focus (item_imp.c_object)
				then
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
		
	selection_mode_is_single:BOOLEAN

	list_has_been_clicked: BOOLEAN
		-- Are we between "item_clicked" and "list_clicked" event.
	
end -- class EV_LIST_ITEM_LIST_IMP

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
--| Revision 1.8  2001/06/29 22:33:34  king
--| Removed scrollable code
--|
--| Revision 1.7  2001/06/15 17:42:26  etienne
--| Fixed problem with focus_in/out_actions in combo boxes.
--|
--| Revision 1.6  2001/06/13 16:44:13  etienne
--| Cosmetics.
--|
--| Revision 1.5  2001/06/13 16:35:58  etienne
--| Improved item selection in combo boxes and lists.
--|
--| Revision 1.4  2001/06/08 22:07:54  etienne
--| Made the focus work.
--|
--| Revision 1.1.2.16  2001/06/05 01:36:10  king
--| Uncommented focus code, needs fixing
--|
--| Revision 1.1.2.15  2001/05/18 18:18:22  king
--| Updated focus implementation
--|
--| Revision 1.1.2.14  2001/04/26 19:12:24  king
--| Removed unused locals
--|
--| Revision 1.1.2.13  2000/12/08 18:17:43  etienne
--| Removed invalid scroll code
--|
--| Revision 1.1.2.12  2000/11/30 19:28:41  king
--| Removed unused local variable
--|
--| Revision 1.1.2.11  2000/11/06 19:45:07  king
--| Temp code store for new checkout
--|
--| Revision 1.1.2.10  2000/10/27 16:54:44  manus
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
--| Revision 1.1.2.9  2000/09/06 23:18:48  king
--| Reviewed
--|
--| Revision 1.1.2.8  2000/08/28 16:42:31  king
--| Removed event_widget
--|
--| Revision 1.1.2.7  2000/08/02 23:29:56  king
--| Calling internal AS directly instead of indirecting though interface
--|
--| Revision 1.1.2.6  2000/07/28 23:58:43  king
--| Changed selection callbacks to avoid unneccessary instantiation of empty
--| action sequences via call to interface.
--|
--| Revision 1.1.2.5  2000/07/24 21:36:10  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.1.2.4  2000/06/28 00:10:18  king
--| c_object is now scroll_window from event_box
--|
--| Revision 1.1.2.3  2000/06/12 16:41:38  oconnor
--| removed references to obsolete features
--|
--| Revision 1.1.2.2  2000/05/10 21:22:59  king
--| Implemented selected_item
--|
--| Revision 1.1.2.1  2000/05/10 19:40:01  king
--| Initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
