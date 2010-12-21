note
	description: "EiffelVision list, gtk implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			clear_selection,
			on_item_clicked,
			needs_event_box
		end
create
	make

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- True if the user can choose several items,
			-- False otherwise.

feature -- Initialize

	needs_event_box: BOOLEAN = True

	initialize
			-- Initialize the list.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
				-- Set to single selection
			multiple_selection_enabled := False
			selection_mode_is_single := True
			{EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, {EV_GTK_EXTERNALS}.gtk_selection_single_enum)
		end

feature -- Status Report

	has_focus: BOOLEAN
			-- Does the list have the focus?

feature -- Status setting

	ensure_item_visible (an_item: EV_LIST_ITEM)
			-- Ensure item `an_index' is visible in `Current'.
		local
			an_item_index: INTEGER
			item_imp: EV_LIST_ITEM_IMP
		do
			an_item_index := index_of (an_item, 1)
			item_imp ?= an_item.implementation

				-- Show the item at position `item_index'
			{EV_GTK_EXTERNALS}.gtk_adjustment_set_value (vertical_adjustment_struct, (an_item_index - 1) * (App_implementation.default_font_ascent + App_implementation.default_font_descent + 2))
			--| FIXME IEK This needs to be properly implemented
		end

	enable_multiple_selection
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS
		do
			multiple_selection_enabled := True
			if selection_mode_is_single then
				{EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, {EV_GTK_EXTERNALS}.gTK_SELECTION_MULTIPLE_ENUM)
			else
				{EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, {EV_GTK_EXTERNALS}.gTK_SELECTION_EXTENDED_ENUM)
			end
		end

	disable_multiple_selection
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
			{EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, {EV_GTK_EXTERNALS}.gTK_SELECTION_SINGLE_ENUM)
			if sel_item /= Void then
				sel_item.enable_select
			end
		end

	clear_selection
			-- Clear the selection of the list.
		do
			switch_to_single_mode_if_necessary
			Precursor {EV_LIST_ITEM_LIST_IMP}
		end

feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER
		do
			Result := list_widget
		end

	interface: EV_LIST

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation	

	set_is_out (a_value: BOOLEAN)
			-- Assign `a_value' to `is_out'.
		do
			is_out := a_value
		end

feature {NONE} -- Implementation

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end

	vertical_adjustment_struct: POINTER
			-- Pointer to vertical adjustment struct use in the scrollbar.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_range_struct_adjustment ({EV_GTK_EXTERNALS}.gtk_scrolled_window_struct_vscrollbar (c_object))
		end

	select_callback (n_args: INTEGER; args: POINTER)
			-- Called when a list item is selected.
		local
			l_item: EV_LIST_ITEM_IMP
		do
			switch_to_browse_mode_if_necessary
		 	l_item ?= eif_object_from_c ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args))
			call_select_actions (l_item)
		end

	switch_to_single_mode_if_necessary
			-- Change selection mode if the last selected
			-- item is deselected.
		local
			sel_items: like selected_items
		do
			if not selection_mode_is_single then
				if multiple_selection_enabled then
					sel_items := selected_items
					if sel_items = Void or else selected_items.count <= 1 then
						{EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, {EV_GTK_EXTERNALS}.gtk_selection_multiple_enum)
						selection_mode_is_single := True
					end
				else
					{EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, {EV_GTK_EXTERNALS}.gtk_selection_single_enum)
					selection_mode_is_single := True
				end
			end
		end

	switch_to_browse_mode_if_necessary
			-- Change selection mode to browse mode
			-- if necessary.
		do
			if selection_mode_is_single then
				if multiple_selection_enabled then
					{EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, {EV_GTK_EXTERNALS}.gtk_selection_extended_enum)
				else
					{EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (list_widget, {EV_GTK_EXTERNALS}.gtk_selection_browse_enum)
				end
				selection_mode_is_single := False
			end
		end

	is_out: BOOLEAN
			-- Is the mouse pointer over the list?

	button_is_pressed: BOOLEAN
			-- Is one of the mouse buttons pressed?
		local
			temp_mask, temp_x, temp_y: INTEGER
			button_pressed_mask: INTEGER
			temp_ptr: POINTER
		do
			temp_ptr := {EV_GTK_EXTERNALS}.gdk_window_get_pointer (default_pointer, $temp_x, $temp_y, $temp_mask)
			button_pressed_mask := {EV_GTK_EXTERNALS}.gdk_button1_mask_enum + {EV_GTK_EXTERNALS}.gdk_button2_mask_enum + {EV_GTK_EXTERNALS}.gdk_button3_mask_enum
			Result := (temp_mask.bit_and (button_pressed_mask)).to_boolean
		end

	on_item_clicked
			-- One of the item has been clicked.
		do
			Precursor
			switch_to_browse_mode_if_necessary
		end

	selection_mode_is_single:BOOLEAN;


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




end -- class EV_LIST_IMP

