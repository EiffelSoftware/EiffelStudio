note
	description:
		"EiffelVision Tree, Cocoa implementation"
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
			call_pebble_function
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			set_to_drag_and_drop,
			able_to_transport,
			ready_for_pnd_menu,
			disable_transport,
			pre_pick_steps,
			post_drop_steps,
			call_pebble_function
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE, EV_TREE_NODE_IMP]
		redefine
			interface,
			initialize
		end

	EV_TREE_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM_PARENT

	NS_OUTLINE_VIEW_DATA_SOURCE [EV_TREE_NODE]
		rename
			new as new_data_source
		end

	NS_OUTLINE_VIEW_DELEGATE
		rename
			new as new_delegate,
			cocoa_object as delegate
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create an empty Tree.
		local
			table_column: NS_TABLE_COLUMN
		do
			base_make (an_interface)
			create scroll_view.new
			cocoa_item := scroll_view
			create outline_view.new
			scroll_view.set_document_view (outline_view)
			scroll_view.set_has_horizontal_scroller (True)
			scroll_view.set_has_vertical_scroller (True)
			scroll_view.set_autohides_scrollers (True)
			create table_column.new
			table_column.set_editable (False)
			outline_view.add_table_column (table_column)
			outline_view.set_outline_table_column (table_column)
			outline_view.set_header_view (NULL)
			table_column.set_width (1000.0)

			new_data_source
			outline_view.set_data_source (current)

			new_delegate
			outline_view.set_delegate (current)
		end

	initialize
			-- Connect action sequences to signals.
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_TREE_I}
			enable_tabable_from
			enable_tabable_to
			set_is_initialized (True)
		end

feature -- Events

	call_selection_action_sequences
			-- Call the appropriate selection action sequences
		do
			select_actions.call ([])
		end

feature -- Delegate

	selection_did_change
			-- The selection of the NSOutlineView changed
		do
			select_actions.call ([])
			if selected_item /= Void then
				selected_item.select_actions.call([])
			end
		end

feature -- DataSource

	number_of_children_of_item (a_node: EV_TREE_NODE): INTEGER
		do
			if a_node = void then
				Result := count
			else
				Result := a_node.count
			end
		end

	is_item_expandable (a_node: EV_TREE_NODE): BOOLEAN
		do
			if a_node = void then
				Result := count > 0
			else
				Result := a_node.count > 0
			end
		end

	child_of_item (an_index: INTEGER; a_node: EV_TREE_NODE): EV_TREE_NODE
		do
			if a_node = void then
				Result := i_th (an_index + 1)
			else
				Result := a_node.i_th (an_index + 1)
			end
		end

	object_value_for_table_column_by_item (a_table_column: POINTER; a_node: EV_TREE_NODE): POINTER
		do
			Result :=(create {NS_STRING}.make_with_string (a_node.text)).cocoa_object
		end

feature -- Status report

	selected_item: EV_TREE_NODE
			-- Item which is currently selected
		do
			Result ?= outline_view.item_at_row (outline_view.selected_row)
		end

	selected: BOOLEAN
			-- Is one item selected?

feature -- Implementation

	ensure_item_visible (an_item: EV_TREE_NODE)

		do
			-- reveal_data_browser_item_external
		end

	set_to_drag_and_drop: BOOLEAN
		do
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is list or row able to transport PND data using `a_button'.
		do

		end

	ready_for_pnd_menu (a_button: INTEGER): BOOLEAN
			-- Is list or row able to display PND menu using `a_button'
		do

		end

	disable_transport
		do

		end

	update_pnd_status
			-- Update PND status of list and its children.
		do
		end

	update_pnd_connection (a_enable: BOOLEAN)
			-- Update the PND connection status for `Current'.
		do
		end

	pnd_row_imp: EV_TREE_NODE_IMP
			-- Implementation object of the current row if in PND transport.

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Set `pebble' using `pebble_function' if present.
		do
		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
			-- Steps to perform before transport initiated.
		do
		end

	post_drop_steps (a_button: INTEGER)
			-- Steps to perform once an attempted drop has happened.
		do
		end

feature {EV_TREE_NODE_IMP}

	row_from_y_coord (a_y: INTEGER): EV_TREE_NODE_IMP
			-- Returns the row index at relative coordinate `a_y'.
		do
		end

feature {NONE} -- Implementation

	previous_selected_item: EV_TREE_NODE
			-- Item that was selected previously.

	insert_item (item_imp: EV_TREE_NODE_IMP; an_index: INTEGER)
			-- Insert `item_imp' at the `an_index' position.
		do
			-- TODO: optimization potential?
			outline_view.reload_item_reload_children (NULL, True)
		end

	remove_item (item_imp: EV_TREE_NODE_IMP)
			-- Remove `item_imp' from `Current'.
		do
			-- TODO: optimization potential?
			outline_view.reload_item_reload_children (NULL, True)
		end


feature {EV_TREE_NODE_IMP} -- Implementation

	get_text_from_position (a_tree_node_imp: EV_TREE_NODE_IMP): STRING_32
			-- Retrieve cell text from `a_tree_node_imp`
		do
		end

	set_text_on_position (a_tree_node_imp: EV_TREE_NODE_IMP; a_text: STRING_GENERAL)
			-- Set cell text at to `a_text'.
		do
		end

	update_row_pixmap (a_tree_node_imp: EV_TREE_NODE_IMP)
			-- Set the pixmap for `a_tree_node_imp'.
		do
		end

	set_row_height (value: INTEGER)
			-- Make `value' the new height of all the rows.
		do
		end

	row_height: INTEGER
			-- Height of rows in `Current'
		do
		end

feature {NONE} -- Implementation

	pixmaps_size_changed
			-- Not implemented
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE;

feature {EV_ANY_I, EV_TREE_NODE_IMP} -- Implementation

	scroll_view: NS_SCROLL_VIEW

	outline_view: NS_OUTLINE_VIEW;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TREE_IMP

