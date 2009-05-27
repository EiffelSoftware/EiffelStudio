note
	description: "EiffelVision list, Cocoa implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_IMP

inherit
	EV_LIST_I
		undefine
			wipe_out,
			selected_items,
			call_pebble_function
		redefine
			interface,
			disable_default_key_processing
		end

	EV_LIST_ITEM_LIST_IMP
		redefine
			interface,
			initialize,
			row_from_y_coord,
			on_mouse_button_event,
			row_height,
			minimum_height,
			minimum_width
		end

create
	make

feature -- Initialize

	make (an_interface: like interface)
			-- Create a list widget with `par' as parent.
			-- By default, a list allow only one selection.
		do
			base_make (an_interface)
			create {NS_OUTLINE_VIEW}cocoa_item.make
			-- FIXME: Change to TableView
		end

	initialize
			-- Initialize the list.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
		end

feature -- Access

	selected_item: EV_LIST_ITEM
			-- Item which is currently selected, for a multiple
			-- selection.
		do
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than
			-- `selected_items' for a single selection list.
		do
			create Result.make (0)
		end

feature -- Status Report

	multiple_selection_enabled: BOOLEAN
			-- True if the user can choose several items
			-- False otherwise.
		do
		end

feature -- Status setting

	ensure_item_visible (an_item: EV_LIST_ITEM)
			-- Ensure item `an_index' is visible in `Current'.
		do
		end

	enable_multiple_selection
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		do
		end

	disable_multiple_selection
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
		do
		end

	select_item (an_index: INTEGER)
			-- Select an item at the one-based `index' of the list.
		do
		end

	deselect_item (an_index: INTEGER)
			-- Unselect the item at the one-based `index'.
		do
		end

	clear_selection
			-- Clear the selection of the list.
		do
		end

feature -- PND

	row_index_from_y_coord (a_y: INTEGER): INTEGER
			-- Returns the row index at relative coordinate `a_y'.
		do
		end

	row_from_y_coord (a_y: INTEGER): EV_PND_DEFERRED_ITEM
			-- Returns the row at relative coordinate `a_y'
		do
		end

	on_mouse_button_event (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Initialize a pick and drop transport.
		do
		end

	row_height: INTEGER
			-- Height of rows in `Current'
			-- (export status {NONE})
		do
		end

feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER
		do
		end

	interface: EV_LIST

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	previous_selection: ARRAYED_LIST [EV_LIST_ITEM]
		-- List of selected items from last selection change

	call_selection_action_sequences
			-- Call appropriate selection and deselection action sequences
		do
		end

feature {NONE} -- Implementation

	disable_default_key_processing
			-- Ensure default key processing is not performed.
		do
		end

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
		end

	vertical_adjustment_struct: POINTER
			-- Pointer to vertical adjustment struct use in the scrollbar.
		do
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER)
			-- Insert `item_imp' at `an_index'.
		do
			io.put_string ("EV_LIST_IMP.insert_item: Not implemented")
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP)
			-- Remove `item' from the list
		do
			io.put_string ("EV_LIST_IMP.remove_item: Not implemented")
		end

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 74 -- Hardcoded, TODO calculate a meaningful height depending on the content.
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := 55 -- Hardcoded, TODO calculate a meaningful width depending on the content
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_LIST_IMP

