indexing
	description: 
		"Common ancestor for EV_LIST and EV_COMBO_BOX."
	status: "See notice at end of class"
	keywords: "list, list_item"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_LIST_ITEM_LIST

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			create_action_sequences
		end

	EV_ITEM_LIST [EV_LIST_ITEM]
		redefine
			implementation,
			create_action_sequences
		end

feature -- Initialization

	make_with_strings (strings: CHAIN [STRING]) is
			-- Create with an item for each of `strings'.
		local
			c: CURSOR
		do
			default_create
			c := strings.cursor
			from
				strings.start
			until
				strings.after
			loop
				extend (create {EV_LIST_ITEM}.make_with_text (strings.item))
				strings.forth
			end
			strings.go_to (c)
		ensure
			items_created: count = strings.count
		end

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at `an_index'.
		require
			index_within_range: an_index > 0 and an_index <= count
		do
			implementation.select_item (an_index)
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at `an_index'.
		require
			index_within_range: an_index > 0 and an_index <= count
		do
			implementation.deselect_item (an_index)
		end

	clear_selection is
			-- Ensure there is no `selected_item'.
		do
			implementation.clear_selection
		ensure
			not_selected: selected_item = Void
		end

feature -- Event handling

	select_actions: EV_LIST_ITEM_SELECT_ACTION_SEQUENCE
			-- Actions to be performed when an item is selected. 

	deselect_actions: EV_LIST_ITEM_SELECT_ACTION_SEQUENCE
			-- Actions to be performed when an item is deselected.

feature {EV_ANY_I, EV_LIST_ITEM_LIST} -- Implementation

	implementation: EV_LIST_ITEM_LIST_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_action_sequences is
   			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_ITEM_LIST} Precursor
			{EV_PRIMITIVE} Precursor
			create select_actions
			create deselect_actions
		end

end -- class EV_LIST_ITEM_LIST

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/06/07 17:28:13  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.1.2.1  2000/05/10 18:54:33  king
--| initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
