note
	description: "EiffelVision multi-column list row, Cocoa implementation."
	author: "Daniel Furrer."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

	EV_ITEM_IMP
		undefine
			pixmap_equal_to,
			create_drop_actions
		redefine
			interface,
			parent_imp
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create the linked lists.
		do
			tooltip := ""
			set_is_initialized (True)
		end

feature -- Status report

	is_dockable: BOOLEAN

	is_selected: BOOLEAN
			-- Is the item selected.
		do
			if attached parent_imp as l_parent_imp then
				Result := (l_parent_imp.selected_item = interface)
					or else (l_parent_imp.selected_items.has (attached_interface))
			end
		end

feature -- Status setting

	enable_select
			-- Select the row in the list.
		do
			if not is_selected and attached parent_imp as l_parent_imp then
				l_parent_imp.select_item (index)
			end
		end

	disable_select
			-- Deselect the row from the list.
		do
			if is_selected and attached parent_imp as l_parent_imp then
				l_parent_imp.deselect_item (index)
			end
		end

feature -- Element Change

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
		do
			tooltip := a_tooltip.twin
		end

	tooltip: STRING_32
			-- Tooltip displayed on `Current'.

feature -- Measurement

	width: INTEGER
		do
--			io.put_string ("EV_MULTI_COLUMN_LIST_ROW_IMP.width: Not implemented%N")
		end

	height: INTEGER
		do
--			io.put_string ("EV_MULTI_COLUMN_LIST_ROW_IMP.height: Not implemented%N")
		end

	screen_x: INTEGER
		do
--			io.put_string ("EV_MULTI_COLUMN_LIST_ROW_IMP.screen_x: Not implemented%N")
		end

	screen_y: INTEGER
		do
--			io.put_string ("EV_MULTI_COLUMN_LIST_ROW_IMP.screen_y: Not implemented%N")
		end

	x_position: INTEGER
		do
--			io.put_string ("EV_MULTI_COLUMN_LIST_ROW_IMP.x_position: Not implemented%N")
		end

	y_position: INTEGER
		do
--			io.put_string ("EV_MULTI_COLUMN_LIST_ROW_IMP.y_position: Not implemented%N")
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.minimum_width
			end
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.attached_interface.row_height
			end
		end

feature {ANY} -- Implementation

	on_item_added_at (an_item: STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been added to index `item_index'.
		do
		end

	on_item_removed_at (an_item: STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been removed from index `item_index'.
		do
		end

feature {EV_ANY_I} -- Implementation

	set_list_iter (a_iter: ANY)
			-- Set `list_iter' to `a_iter'
		do
		end

	index: INTEGER
			-- Index of the row in the list
			-- (starting from 1).
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.ev_children.index_of (Current, 1)
			end
		end

	parent_imp: detachable EV_MULTI_COLUMN_LIST_IMP

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MULTI_COLUMN_LIST_ROW note option: stable attribute end;

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP
