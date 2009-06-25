note
	description: "Cocoa Implementation for EV_HEADER_IMP."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_IMP

inherit
	EV_HEADER_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_HEADER_ITEM, EV_HEADER_ITEM_IMP]
		redefine
			interface,
			make
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			make,
			set_default_minimum_size
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			make
		end

	EV_HEADER_ACTION_SEQUENCES_IMP

	NS_OUTLINE_VIEW_DATA_SOURCE[ANY]
		rename
			make as create_data_source,
			item as data_source
		end

create
	make

feature -- Initialization

	make
			-- Initialize `Current'
		do
--			create w.new
--			w.set_frame (create {NS_RECT}.make_rect (0, 0, 0, 18))
--			create h.new
--			w.set_cell (h)

			create container.make
			container.set_frame (create {NS_RECT}.make_rect (0, 0, 0, 18))
			container.set_has_horizontal_scroller (False)
			container.set_has_vertical_scroller (False)

			create outline_view.make
			container.set_document_view (outline_view)
			outline_view.set_data_source (current)
			cocoa_item := container

			initialize_pixmaps

			initialize_item_list
			Precursor {EV_PRIMITIVE_IMP}
			disable_tabable_from
			disable_tabable_to
			set_is_initialized (True)
		end

feature -- Access

	insert_item (item_imp: EV_HEADER_ITEM_IMP; an_index: INTEGER)
			-- Insert `item_imp' at `an_index'.
		do
			outline_view.add_table_column (item_imp.table_column)
		end

	remove_item (item_imp: EV_HEADER_ITEM_IMP)
			-- Remove `item' from the list
		local
			an_index: INTEGER
		do
			an_index := ev_children.index_of (item_imp, 1) - 1
		end

feature {EV_HEADER_ITEM_IMP} -- Implemnentation

	number_of_children_of_item (an_item: ANY): INTEGER
		do
		end

	is_item_expandable (an_item: ANY): BOOLEAN
		do
		end

	child_of_item (an_index: INTEGER; an_item: ANY): ANY
		do
			Result := 1
		end

	object_value_for_table_column_by_item (a_table_column: POINTER; an_item: ANY): POINTER
		do
		end

	set_default_minimum_size
		do
			internal_set_minimum_size (0, 18)
		end

feature {NONE} -- Implementation

	pointed_divider_index: INTEGER
			-- Index of divider currently beneath the mouse pointer, or
			-- 0 if none.
		do
		end

	call_item_resize_actions
			-- Call the item resize end actions.
		do
		end

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
		end

	outline_view: NS_OUTLINE_VIEW

	container: NS_SCROLL_VIEW

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HEADER note option: stable attribute end;

end
