indexing
	description: "Eiffel Vision list item list. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_ITEM_LIST_I
	
inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_ITEM_LIST_I [EV_LIST_ITEM]
		redefine
			interface
		end
		
	EV_ITEM_PIXMAP_SCALER_I
		redefine
			interface
		end

	EV_LIST_ITEM_LIST_ACTION_SEQUENCES_I

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- `Result' is currently selected item.
			-- Topmost selected item if multiple items are selected.
		deferred
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at one based index, `an_index'.
		require
			index_within_range: an_index > 0 and an_index <= count
		deferred
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at one based index, `an_index'.
		require
			index_within_range: an_index > 0 and an_index <= count
		deferred
		end

	clear_selection is
			-- Ensure there is no `selected_item' in `Current'.
		deferred
		end

feature {EV_LIST_ITEM_LIST_I, EV_LIST_ITEM_IMP} -- Implementation

	interface: EV_LIST_ITEM_LIST;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_LIST_ITEM_LIST_I

