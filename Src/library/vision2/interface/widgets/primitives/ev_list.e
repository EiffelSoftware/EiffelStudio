indexing
	description: 
		"Displays a list of items from which the user can select."
	appearance:
		"+-------------+%N%
		%| 'first'     |%N%
		%|  ...        |%N%
		%| `last'      |%N%
		%+-------------+"
	status: "See notice at end of class"
	keywords: "list, select, menu"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			create_action_sequences,
			make_for_test
		end

	EV_ITEM_LIST [EV_LIST_ITEM]
		undefine
			create_action_sequences
		redefine
			implementation
		end

create
	default_create,
	make_with_strings,
	make_for_test

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

	selected_items: LINKED_LIST [EV_LIST_ITEM] is
			-- Currently selected items.
		do
			Result := implementation.selected_items
		ensure
			bridge_ok: lists_equal (Result, implementation.selected_items)
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN is
			-- Can more than one item be selected?
		do
			Result := implementation.multiple_selection_enabled
		ensure
			bridge_ok: Result = implementation.multiple_selection_enabled
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
			-- Ensure there are no `selected_items'.
		do
			implementation.clear_selection
		ensure
			not_selected: selected_item = Void and selected_items.count = 0
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		do
			implementation.enable_multiple_selection	
		ensure
			multiple_selection_enabled: multiple_selection_enabled
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		do
			implementation.disable_multiple_selection
		ensure
			not_multiple_selection_enabled: not multiple_selection_enabled
		end

feature -- Event handling

	select_actions: EV_LIST_ITEM_SELECT_ACTION_SEQUENCE
			-- Actions to be performed when an item is selected. 

	deselect_actions: EV_LIST_ITEM_SELECT_ACTION_SEQUENCE
			-- Actions to be performed when an item is deselected.

feature {EV_ANY_I, EV_LIST} -- Implementation

	implementation: EV_LIST_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_LIST_IMP} implementation.make (Current)
		end

	create_action_sequences is
   			-- See `{EV_ANY}.create_action_sequences'.
		do
			{EV_PRIMITIVE} Precursor
			create select_actions
			create deselect_actions
		end

feature -- Contract support

	make_for_test is
			-- Create with items for testing.
		local
			list_item: EV_LIST_ITEM
			counter: INTEGER
		do
			{EV_PRIMITIVE} Precursor
			from
			until
				counter = 10
			loop
				counter := counter + 1
				create list_item.make_with_text ("Test item " + counter.out)
				extend (list_item)
				select_item (counter)
			end
		end

invariant
	selected_items_not_void: is_useable implies selected_items /= Void
	selected_items_first_is_selected_item:
		is_useable and not selected_items.empty implies
		selected_items.first = selected_item
	selected_items_empty_xor_selected_item_not_void:
		is_useable implies selected_items.empty xor selected_item /= Void
	selection_size_within_bounds:
		is_useable and not multiple_selection_enabled implies
		selected_items.count <= 1

end -- class EV_LIST

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
--| Revision 1.40  2000/03/21 02:11:50  oconnor
--| comments and formatting
--|
--| Revision 1.39  2000/03/06 20:15:23  king
--| Changed action sequence types
--|
--| Revision 1.38  2000/03/02 17:58:54  rogers
--| Added initial make_for_test. Currently very basic.
--|
--| Revision 1.37  2000/03/02 17:00:20  rogers
--| Added is_useable to assertions.
--|
--| Revision 1.36  2000/03/01 23:44:14  king
--| Moved lists_equal in to item_list
--|
--| Revision 1.35  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.34  2000/03/01 18:10:36  king
--| Added lists_equal feature, uncommented invariants
--|
--| Revision 1.33  2000/03/01 03:28:59  oconnor
--| added make_for_test
--|
--| Revision 1.32  2000/02/24 19:59:15  rogers
--| Corrected postconditions in select_item and deselect_item, they now
--| reference an_index instead of index.
--|
--| Revision 1.31  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.30  2000/02/17 01:09:25  oconnor
--| fixed invariant
--|
--| Revision 1.29  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.28.6.15  2000/02/11 00:56:36  king
--| Redefine action sequences to call both precursors
--|
--| Revision 1.28.6.14  2000/01/28 20:00:20  oconnor
--| released
--|
--| Revision 1.28.6.13  2000/01/28 19:05:29  king
--| Altered to new generic structure of ev_item_list
--|
--| Revision 1.28.6.12  2000/01/27 19:30:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.28.6.11  2000/01/26 23:18:18  king
--| Indented comment
--|
--| Revision 1.28.6.10  2000/01/18 23:26:16  rogers
--| The interface of list is now exported to EV_ANY_I instead of EV_LIST_I.
--|
--| Revision 1.28.6.9  2000/01/17 19:15:08  oconnor
--| fixed void call in invariant
--|
--| Revision 1.28.6.8  2000/01/15 01:48:49  oconnor
--| removed feature selected
--|
--| Revision 1.28.6.7  2000/01/15 01:39:32  rogers
--| Modified comments.
--|
--| Revision 1.28.6.6  2000/01/15 00:55:57  oconnor
--| renamed:
--|  is_multiple_selection -> multiple_selection_enabled
--|  set_multiple_selection -> enable_multiple_selection
--|  set_single_selection -> disable_multiple_selection
--| simplified retrieval of selection info
--| added invariants and oher contracts
--|
--| Revision 1.28.6.5  1999/12/17 19:38:06  rogers
--| redefined implementation to be a a more refined type. item is no longer
--| necessary in this class, now inherited.
--|
--| Revision 1.28.6.4  1999/12/02 00:07:43  oconnor
--| redefine item to be of type EV_LIST_ITEM
--|
--| Revision 1.28.6.3  1999/12/01 22:23:36  oconnor
--| moved item to EV_ITEM_LIST
--|
--| Revision 1.28.6.2  1999/11/30 22:37:42  oconnor
--| added inheritance of EV_ITEM_LIST, renamed arguments index -> an_index
--|
--| Revision 1.28.6.1  1999/11/24 17:30:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.28.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.28.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
