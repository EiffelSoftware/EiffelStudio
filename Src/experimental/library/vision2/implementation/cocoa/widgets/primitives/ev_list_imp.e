note
	description: "EiffelVision list, Cocoa implementation"
	author: "Daniel Furrer"
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
			make,
			on_mouse_button_event,
			row_height,
			minimum_height,
			minimum_width
		end

	NS_OUTLINE_VIEW_DATA_SOURCE [EV_LIST_ITEM] -- TODO: should probably be TABLE_VIEW
		rename
			make as create_data_source,
			item as data_source
		end

	NS_OUTLINE_VIEW_DELEGATE
		rename
			make as create_delegate,
			item as delegate
		end

create
	make

feature -- Initialize

	make
			-- Initialize the list.
		local
			table_column: NS_TABLE_COLUMN
		do
			create scroll_view.make
			cocoa_view := scroll_view
			create outline_view.make
			scroll_view.set_document_view (outline_view)
			scroll_view.set_has_horizontal_scroller (True)
			scroll_view.set_has_vertical_scroller (True)
			scroll_view.set_autohides_scrollers (True)
			create table_column.make
			table_column.set_editable (False)
			outline_view.add_table_column (table_column)
			outline_view.set_outline_table_column (table_column)
			outline_view.set_header_view (default_pointer)
			table_column.set_width ({REAL_32}1000.0)

			Precursor {EV_LIST_ITEM_LIST_IMP}

			create_data_source
			outline_view.set_data_source (current)

			create_delegate
			outline_view.set_delegate (current)

			-- FIXME: Change to TableView
			enable_tabable_to
		end

feature -- Delegate

	selection_did_change
			-- The selection of the NSOutlineView changed
		do
			select_actions.call ([])
			if attached selected_item as l_item then
				l_item.select_actions.call([])
			end
		end

feature -- DataSource

	number_of_children_of_item (a_node: detachable EV_LIST_ITEM): INTEGER
		do
			check a_node = Void end
			Result := count
		end

	is_item_expandable (a_node: detachable EV_LIST_ITEM): BOOLEAN
		do
			Result := False
		end

	child_of_item (an_index: INTEGER; a_node: detachable EV_LIST_ITEM): EV_LIST_ITEM
		local
			l_result: detachable EV_LIST_ITEM
		do
			l_result := i_th (an_index + 1)
			check l_result /= Void end
			Result := l_result
		end

	object_value_for_table_column_by_item (a_table_column: POINTER; a_node: EV_LIST_ITEM): POINTER
		do
			Result := (create {NS_STRING}.make_with_string (a_node.text)).item
		end

feature -- Access

	selected_item: detachable EV_LIST_ITEM
			-- Item which is currently selected, for a multiple
			-- selection.
		do
			Result ?= outline_view.item_at_row (outline_view.selected_row)
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than
			-- `selected_items' for a single selection list.
		do
			create Result.make (1)
			if attached selected_item as l_item then
				Result.extend (l_item)
			end
		end

feature -- Status Report

	multiple_selection_enabled: BOOLEAN
			-- True if the user can choose several items
			-- False otherwise.

feature -- Status setting

	ensure_item_visible (an_item: EV_LIST_ITEM)
			-- Ensure item `an_index' is visible in `Current'.
		do
		end

	enable_multiple_selection
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		do
			multiple_selection_enabled := True
		end

	disable_multiple_selection
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
		do
			multiple_selection_enabled := False
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

	on_mouse_button_event (a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Initialize a pick and drop transport.
		do
		end

	row_height: INTEGER
			-- Height of rows in `Current'
			-- (export status {NONE})
		do
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation


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
			-- TODO: optimization potential?
			outline_view.reload_item_reload_children (default_pointer, True)
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP)
			-- Remove `item' from the list
		do
			-- TODO: optimization potential?
			outline_view.reload_item_reload_children (default_pointer, True)
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

feature {EV_ANY_I, EV_TREE_NODE_IMP} -- Implementation

	scroll_view: NS_SCROLL_VIEW

	outline_view: NS_OUTLINE_VIEW;

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST note option: stable attribute end;

end -- class EV_LIST_IMP
