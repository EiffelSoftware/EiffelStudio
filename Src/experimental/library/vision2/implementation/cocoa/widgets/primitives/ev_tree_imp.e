note
	description: "EiffelVision Tree, Cocoa implementation"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I
		redefine
			interface,
			make,
			call_pebble_function
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			make,
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
			make
		end

	EV_TREE_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM_PARENT

	NS_OUTLINE_VIEW_DATA_SOURCE [EV_TREE_NODE]
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

feature {NONE} -- Initialization

	make
			-- Create an empty Tree.
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
			table_column.set_data_cell (create {NS_IMAGE_CELL}.make)
			table_column.set_width ({REAL_32}20.0)
			outline_view.add_table_column (table_column)
			create table_column.make
			table_column.set_editable (False)
			outline_view.add_table_column (table_column)
			outline_view.set_outline_table_column (table_column)
			outline_view.set_header_view (default_pointer)
			table_column.set_width ({REAL_32}1000.0)

			initialize_item_list

			create_data_source
			outline_view.set_data_source (current)

			create_delegate
			outline_view.set_delegate (current)

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
			if attached selected_item as l_item then
				l_item.select_actions.call([])
			end
		end

feature -- DataSource

	number_of_children_of_item (a_node: detachable EV_TREE_NODE): INTEGER
		do
			if a_node = void then
				Result := count
			else
				Result := a_node.count
			end
		end

	is_item_expandable (a_node: detachable EV_TREE_NODE): BOOLEAN
		do
			if a_node = void then
				Result := count > 0
			else
				Result := a_node.count > 0
			end
		end

	child_of_item (an_index: INTEGER; a_node: detachable EV_TREE_NODE): EV_TREE_NODE
		local
			l_result: detachable EV_TREE_NODE
		do
			if a_node = void then
				l_result := i_th (an_index + 1)
				check l_result /= Void end
				Result := l_result
			else
				Result := a_node.i_th (an_index + 1)
			end
		end

	object_value_for_table_column_by_item (a_table_column: POINTER; a_node: EV_TREE_NODE): POINTER
		local
			l_pixmap_imp: detachable EV_PIXMAP_IMP
		do
			-- FIXME: do proper reverse mapping from the a_table_column pointer to the eiffel object
			if attached outline_view.table_columns.item (0) as l_item and then l_item.item = a_table_column then
				if attached a_node.pixmap as l_pixmap then
					l_pixmap_imp ?= l_pixmap.implementation
					check l_pixmap_imp /= Void end
					Result := l_pixmap_imp.image.item
				end
			else
				Result := (create {NS_STRING}.make_with_string (a_node.text)).item
			end
		end

feature -- Status report

	selected_item: detachable EV_TREE_NODE
			-- Item which is currently selected; Void if none
		local
			l_row: INTEGER
		do
			l_row := outline_view.selected_row
			if l_row /= -1 then
				Result ?= outline_view.item_at_row (l_row)
			end
		end

	selected: BOOLEAN
			-- Is one item selected?
		do
			Result := outline_view.selected_row /= -1
		end

feature -- Implementation

	ensure_item_visible (an_item: EV_TREE_NODE)

		do
			--outline_view
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

feature {NONE} -- Implementation

	previous_selected_item: detachable EV_TREE_NODE
			-- Item that was selected previously.

	insert_item (item_imp: EV_TREE_NODE_IMP; an_index: INTEGER)
			-- Insert `item_imp' at the `an_index' position.
		do
			-- TODO: optimization potential?
			outline_view.reload_item_reload_children (default_pointer, True)
		end

	remove_item (item_imp: EV_TREE_NODE_IMP)
			-- Remove `item_imp' from `Current'.
		do
			-- TODO: optimization potential?
			outline_view.reload_item_reload_children (default_pointer, True)
		end


feature {EV_TREE_NODE_IMP} -- Implementation

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

feature {EV_ANY_I, EV_TREE_NODE_IMP} -- Implementation

	scroll_view: NS_SCROLL_VIEW

	outline_view: NS_OUTLINE_VIEW;

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TREE note option: stable attribute end;

end -- class EV_TREE_IMP
