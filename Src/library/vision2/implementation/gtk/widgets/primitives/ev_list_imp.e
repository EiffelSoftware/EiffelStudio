indexing
	description: "EiffelVision list, gtk implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_IMP

inherit
	EV_LIST_I
		undefine
			wipe_out
		redefine
			interface
		end

	EV_LIST_ITEM_LIST_IMP
		redefine
			interface,
			visual_widget,
			initialize,
			has_focus,
			add_to_container,
			clear_selection,
			on_item_clicked
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
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
			
			real_signal_connect (
					list_widget,
					"leave-notify-event",
					agent (App_implementation.gtk_marshal).list_proximity_intermediary (c_object, True),
					size_allocate_translate_agent
			)
			real_signal_connect (
					list_widget,
					"enter-notify-event",
					agent (App_implementation.gtk_marshal).list_proximity_intermediary (c_object, False),
					size_allocate_translate_agent
			)
			real_signal_connect (
					visual_widget,
					"focus-in-event",
					agent (App_implementation.gtk_marshal).widget_focus_in_intermediary (c_object),
					size_allocate_translate_agent
			)
			real_signal_connect (
					visual_widget,
					"focus-out-event",
					agent (App_implementation.gtk_marshal).widget_focus_out_intermediary (c_object),
					size_allocate_translate_agent
			)
				-- Set to single selection
			multiple_selection_enabled := False
			selection_mode_is_single := True
			feature {EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, feature {EV_GTK_EXTERNALS}.gtk_selection_single_enum)
		end
		
feature -- Status Report

	has_focus: BOOLEAN
			-- Does the list have the focus?

feature -- Status setting

	ensure_item_visible (an_item: EV_LIST_ITEM) is
			-- Ensure item `an_index' is visible in `Current'.
		local
			an_item_index: INTEGER
			item_imp: EV_LIST_ITEM_IMP
		do
			an_item_index := index_of (an_item, 1)
			item_imp ?= an_item.implementation
			
				-- Show the item at position `item_index'
			feature {EV_GTK_EXTERNALS}.gtk_adjustment_set_value (vertical_adjustment_struct, (an_item_index - 1) * (App_implementation.default_font_ascent + App_implementation.default_font_descent + 2))
			--| FIXME IEK This needs to be properly implement
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS
		do
			multiple_selection_enabled := True
			if selection_mode_is_single then
				feature {EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, feature {EV_GTK_EXTERNALS}.gTK_SELECTION_MULTIPLE_ENUM)
			else
				feature {EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, feature {EV_GTK_EXTERNALS}.gTK_SELECTION_EXTENDED_ENUM)
			end
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS
		local
			sel_items: ARRAYED_LIST [EV_LIST_ITEM]
			sel_item: EV_LIST_ITEM
		do
			multiple_selection_enabled := False
			selection_mode_is_single := True
			sel_items := selected_items
			if not sel_items.is_empty then
				sel_item := sel_items.first
			end
			feature {EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, feature {EV_GTK_EXTERNALS}.gTK_SELECTION_SINGLE_ENUM)
			if sel_item /= Void then
				sel_item.enable_select
			end
		end
		
	clear_selection is
			-- Clear the selection of the list.
		do
			switch_to_single_mode_if_necessary
			Precursor {EV_LIST_ITEM_LIST_IMP}
		end

feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER is
		do
			Result := list_widget
		end

	interface: EV_LIST
	
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation	
	
	set_is_out (a_value: BOOLEAN) is
			-- Assign `a_value' to `is_out'.
		do
			is_out := a_value
		end
	
	attain_focus is
			-- The list has just grabbed the focus.
		do
			if not has_focus then
				has_focus := True
				top_level_window_imp.set_focus_widget (Current)
				if focus_in_actions_internal /= Void then
					focus_in_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)				
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
					focus_out_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)
				end
			end
			arrow_used := False
		end
	
feature {NONE} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end

	vertical_adjustment_struct: POINTER is
			-- Pointer to vertical adjustment struct use in the scrollbar.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_range_struct_adjustment (feature {EV_GTK_EXTERNALS}.gtk_scrolled_window_struct_vscrollbar (c_object))
		end

	select_callback (n_args: INTEGER; args: POINTER) is
			-- Called when a list item is selected.
		local
			l_item: EV_LIST_ITEM_IMP
		do
			switch_to_browse_mode_if_necessary		
		 	l_item ?= eif_object_from_c ((App_implementation.gtk_marshal).gtk_value_pointer (args))
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
						feature {EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, feature {EV_GTK_EXTERNALS}.gtk_selection_multiple_enum)
						selection_mode_is_single := True
					end
				else
					feature {EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, feature {EV_GTK_EXTERNALS}.gtk_selection_single_enum)
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
					feature {EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, feature {EV_GTK_EXTERNALS}.gtk_selection_extended_enum)					
				else
					feature {EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, feature {EV_GTK_EXTERNALS}.gtk_selection_browse_enum)
				end
				selection_mode_is_single := False
			end
		end

	add_to_container (v: like item; v_imp: EV_LIST_ITEM_IMP) is
			-- Add `v' to end of list.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP} (v, v_imp)
			real_signal_connect (
				v_imp.c_object,
				"focus-out-event",
				agent (App_implementation.gtk_marshal).on_list_focus_intermediary (c_object, False),
				size_allocate_translate_agent
				)
		end
		
	is_out: BOOLEAN
			-- Is the mouse pointer over the list?
		
	button_is_pressed: BOOLEAN is
			-- Is one of the mouse buttons pressed?
		local
			temp_mask, temp_x, temp_y: INTEGER
			button_pressed_mask: INTEGER
			temp_ptr: POINTER
		do
			temp_ptr := feature {EV_GTK_EXTERNALS}.gdk_window_get_pointer (default_pointer, $temp_x, $temp_y, $temp_mask)
			button_pressed_mask := feature {EV_GTK_EXTERNALS}.gdk_button1_mask_enum + feature {EV_GTK_EXTERNALS}.gdk_button2_mask_enum + feature {EV_GTK_EXTERNALS}.gdk_button3_mask_enum
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

