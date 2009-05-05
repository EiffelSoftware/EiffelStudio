indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
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
			initialize,
			insert_i_th
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			set_default_minimum_size
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_HEADER_ACTION_SEQUENCES_IMP

	NS_OUTLINE_VIEW_DATA_SOURCE[ANY]

create
	make

feature -- Initialization

	make (an_interface: like interface)
			-- Create an empty Tree.
		do
			base_make (an_interface)
--			create w.new
--			w.set_frame (create {NS_RECT}.make_rect (0, 0, 0, 18))
--			create h.new
--			w.set_cell (h)

			create container.new
			container.set_frame (create {NS_RECT}.make_rect (0, 0, 0, 18))
			container.set_has_horizontal_scroller (False)
			container.set_has_vertical_scroller (False)

			create outline_view.new
			container.set_document_view (outline_view)
			outline_view.set_data_source (current)
			cocoa_item := container
		end

	initialize
			-- Initialize `Current'
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}

			set_is_initialized (True)
		end

feature {EV_HEADER_ITEM_IMP} -- Implemnentation

	insert_i_th (v: like item; i: INTEGER_32)
		local
			v_imp: EV_HEADER_ITEM_IMP
		do
			Precursor {EV_ITEM_LIST_IMP} (v, i)
			v_imp ?= v.implementation
			outline_view.add_table_column (v_imp.table_column)
		end

	number_of_children_of_item (an_item: ANY): INTEGER
		do
		end

	is_item_expandable (an_item: ANY): BOOLEAN
		do
		end

	child_of_item (an_index: INTEGER; an_item: ANY): ANY
		do
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

	interface: EV_HEADER;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end
