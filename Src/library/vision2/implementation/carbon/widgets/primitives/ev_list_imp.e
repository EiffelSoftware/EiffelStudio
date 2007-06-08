indexing
	description: "EiffelVision list, Carbon implementation"
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
			insert_i_th,
			remove_i_th,
			minimum_height,
			minimum_width
		end

	EV_CARBON_DATABROWSER-- [EV_LIST_ITEM]
		undefine
			destroy
		redefine
			make,
			initialize,
			interface,
			insert_i_th
		end

create
	make

feature -- Initialize

	make (an_interface: like interface) is
			-- Create a list widget with `par' as parent.
			-- By default, a list allow only one selection.
		do
			Precursor {EV_CARBON_DATABROWSER} (an_interface)
			hide_title_row
		end

	initialize is
			-- Initialize the list.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
		end


	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP} (v, i)
			Precursor {EV_CARBON_DATABROWSER} (v, i)
		end

	remove_i_th (i: INTEGER) is
			-- Remove at position `i'.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= child_array.i_th (i).implementation
			remove_id (item_imp.item_id)
			Precursor {EV_LIST_ITEM_LIST_IMP} (i)
		end

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection.
		do
			Result ?= selected_item_imp.interface
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than
			-- `selected_items' for a single selection list.
		do
		end

feature -- Status Report

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise.
		do
		end

feature -- Status setting

	ensure_item_visible (an_item: EV_LIST_ITEM) is
			-- Ensure item `an_index' is visible in `Current'.
		do
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		do
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
		do
		end

	select_item (an_index: INTEGER) is
			-- Select an item at the one-based `index' of the list.
		do
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
		end

	clear_selection is
			-- Clear the selection of the list.
		do
		end

feature -- PND

	row_index_from_y_coord (a_y: INTEGER): INTEGER is
			-- Returns the row index at relative coordinate `a_y'.
		do
		end

	row_from_y_coord (a_y: INTEGER): EV_PND_DEFERRED_ITEM is
			-- Returns the row at relative coordinate `a_y'
		do
		end

	on_mouse_button_event (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Initialize a pick and drop transport.
		do
		end

	row_height: INTEGER is
			-- Height of rows in `Current'
			-- (export status {NONE})
		do
		end

feature {EV_ANY_I} -- Implementation

	visual_widget: POINTER is
		do
		end

	interface: EV_LIST

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	previous_selection: ARRAYED_LIST [EV_LIST_ITEM]
		-- List of selected items from last selection change

	call_selection_action_sequences is
			-- Call appropriate selection and deselection action sequences
		do
		end

feature {NONE} -- Implementation

	disable_default_key_processing is
			-- Ensure default key processing is not performed.
		do
		end

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
		end


	minimum_height: INTEGER is
			-- Minimum height that the widget may occupy.
		do
			Result := 74 -- Hardcoded, TODO calculate a meaningful height depending on the content.
		end

	minimum_width: INTEGER is
			-- Minimum width that the widget may occupy.
		do
			Result := 55 -- Hardcoded, TODO calculate a meaningful width depending on the content
		end

indexing
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_LIST_IMP

