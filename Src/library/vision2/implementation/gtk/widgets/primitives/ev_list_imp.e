indexing
	description: "EiffelVision list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_IMP

inherit
	EV_LIST_I
		redefine
			interface,
			wipe_out
		end

	EV_LIST_ITEM_LIST_IMP
		redefine
			interface,
			visual_widget,
			initialize,
			has_focus,
			add_to_container,
			select_item,
			deselect_item,
			clear_selection,
			on_item_clicked,
			wipe_out
		end	
create
	make

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- True if the user can choose several items,
			-- False otherwise.

feature -- Initialize

	initialize is
			-- Initialize the list.
		local
			temp_sig_id: INTEGER
		do
			{EV_LIST_ITEM_LIST_IMP} Precursor
			temp_sig_id := c_signal_connect (
					list_widget,
					eiffel_to_c ("leave-notify-event"),
					agent set_is_out (True)
			)
			temp_sig_id := c_signal_connect (
					list_widget,
					eiffel_to_c ("enter-notify-event"),
					agent set_is_out (False)
			)
			temp_sig_id := c_signal_connect (
					visual_widget,
					eiffel_to_c ("focus-in-event"),
					agent attain_focus
			)
			temp_sig_id := c_signal_connect (
					visual_widget,
					eiffel_to_c ("focus-out-event"),
					agent lose_focus
			)
			disable_multiple_selection
		end
		
feature -- Status Report

	has_focus: BOOLEAN
			-- Does the list have the focus?

feature -- Status setting

	ensure_item_visible (an_item: EV_LIST_ITEM) is
			-- Ensure item `an_index' is visible in `Current'.
		local
			an_item_index: INTEGER
		do
			an_item_index := index_of (an_item, 1)
			
				-- Show the item at position `item_index'
			C.gtk_clist_moveto (list_widget, an_item_index, 0, 0.0, 1.0)
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS
		do
			multiple_selection_enabled := True
			if selection_mode_is_single then
				C.gtk_list_set_selection_mode (list_widget, C.GTK_SELECTION_MULTIPLE_ENUM)
			else
				C.gtk_list_set_selection_mode (list_widget, C.GTK_SELECTION_EXTENDED_ENUM)
			end
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS
		do
			multiple_selection_enabled := False
			selection_mode_is_single := True
			C.gtk_list_unselect_all (list_widget)
			C.gtk_list_set_selection_mode (list_widget, C.GTK_SELECTION_SINGLE_ENUM)
		end
		
	select_item (an_index: INTEGER) is
			-- Select the item of the list at the one-based
			-- `index'.
		do
			switch_to_browse_mode_if_necessary
			Precursor {EV_LIST_ITEM_LIST_IMP} (an_index)
		end
		
	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			switch_to_single_mode_if_necessary
			Precursor {EV_LIST_ITEM_LIST_IMP} (an_index)
		end
		
	clear_selection is
			-- Clear the selection of the list.
		do
			switch_to_single_mode_if_necessary
			Precursor {EV_LIST_ITEM_LIST_IMP}
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			C.gtk_list_clear_items (list_widget, 0, -1)
			from
				start
			until
				index > count
			loop
				item_imp ?= item.implementation
				item_imp.set_parent_imp (Void)
				forth
			end

			index := 0
		end

feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER is
		do
			Result := list_widget
		end

	interface: EV_LIST
	
feature {NONE} -- Implementation

	select_callback (n_args: INTEGER; args: POINTER) is
			-- Called when a list item is selected.
		local
			l_item: EV_LIST_ITEM_IMP
		do
			switch_to_browse_mode_if_necessary		
		 	l_item ?= eif_object_from_c (gtk_marshal.gtk_value_pointer (args))
			call_select_actions (l_item)
		end

	switch_to_single_mode_if_necessary is
			-- Change selection mode if the last selected
			-- item is deselected.
		local
			sel_items: like selected_items
		do
			if not selection_mode_is_single then
				if multiple_selection_enabled then
					sel_items := selected_items
					if sel_items = Void or else selected_items.count <= 1 then
						C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_multiple_enum)
						selection_mode_is_single := True
					end
				else
					C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_single_enum)
					selection_mode_is_single := True
				end
			end
		end
		
	switch_to_browse_mode_if_necessary is
			-- Change selection mode to browse mode
			-- if necessary.
		do
			if selection_mode_is_single then
				if multiple_selection_enabled then
					C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_extended_enum)					
				else
					C.gtk_list_set_selection_mode (list_widget, C.Gtk_selection_browse_enum)
				end
				selection_mode_is_single := False
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
			Precursor {EV_LIST_ITEM_LIST_IMP} (v)
			v_imp ?= v.implementation
			temp_sig_id := c_signal_connect (
				v_imp.c_object,
				eiffel_to_c ("focus-out-event"),
				agent lose_focus
				)
		end
		
	attain_focus is
			-- The list has just grabbed the focus.
		do
			if not has_focus then
				has_focus := True
				top_level_window_imp.set_focus_widget (Current)
				if focus_in_actions_internal /= Void then
					focus_in_actions_internal.call ([])				
				end
			end
		end

	lose_focus is
			-- The list has just lost the focus.
		do
				-- This routine is called when an item loses the focus too.
				-- The follwing test prevent call to `focus_out_actions' when
				-- the user has only changed the selected item.
			if (not has_capture) and then 
				(is_out or else not button_is_pressed) and then
				(not list_has_been_clicked) and then
				(not arrow_used)
			then
				has_focus := False
				top_level_window_imp.set_focus_widget (Void)
				if not has_focus and focus_out_actions_internal /= Void then
					focus_out_actions_internal.call ([])
				end
			end
			arrow_used := False
		end

	is_out: BOOLEAN
			-- Is the mouse pointer over the list?
		
	set_is_out (a_value: BOOLEAN) is
			-- Assign `a_value' to `is_out'.
		do
			is_out := a_value
		end
		
	button_is_pressed:BOOLEAN is
			-- Is one of the mouse buttons pressed?
		local
			temp_mask, temp_x, temp_y: INTEGER
			button_pressed_mask: INTEGER
			temp_ptr: POINTER
		do
			temp_ptr := C.gdk_window_get_pointer (default_pointer, $temp_x, $temp_y, $temp_mask)
			button_pressed_mask := C.gdk_button1_mask_enum + C.gdk_button2_mask_enum + C.gdk_button3_mask_enum
			Result := (temp_mask.bit_and (button_pressed_mask)).to_boolean
		end	

	on_item_clicked is
			-- One of the item has been clicked.
		do
			Precursor
			switch_to_browse_mode_if_necessary
		end

	selection_mode_is_single:BOOLEAN

		
end -- class EV_LIST_IMP

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

