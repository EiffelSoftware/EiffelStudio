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
	EV_LIST_ITEM_LIST
		redefine
			implementation
		end

create
	default_create,
	make_with_strings

feature -- Access

	selected_items: DYNAMIC_LIST [EV_LIST_ITEM] is
			-- Currently selected items.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_items
		ensure
			bridge_ok: lists_equal (Result, implementation.selected_items)
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN is
			-- Can more than one item be selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.multiple_selection_enabled
		ensure
			bridge_ok: Result = implementation.multiple_selection_enabled
		end

	pixmaps_width: INTEGER is
			-- Width of displayed pixmaps in the list.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_width
		ensure
			bridge_ok: Result = implementation.pixmaps_width
		end

	pixmaps_height: INTEGER is
			-- Height of displayed pixmaps in the list.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_height
		ensure
			bridge_ok: Result = implementation.pixmaps_height
		end

feature -- Status setting
	
	ensure_item_visible (an_item: EV_LIST_ITEM) is
			-- Ensure item `an_item' is visible in `Current'.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
			an_item_contained: has (an_item)
		do
			implementation.ensure_item_visible (an_item)
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_selection	
		ensure
			multiple_selection_enabled: multiple_selection_enabled
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_multiple_selection
		ensure
			not_multiple_selection_enabled: not multiple_selection_enabled
		end

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set size of pixmaps disaplyed in `Current'.
			-- Note: Default value is 16x16
		require
			not_destroyed: not is_destroyed
			valid_width: a_width > 0
			valid_height: a_height > 0
		do
			implementation.set_pixmaps_size (a_width, a_height)
		ensure
			width_set: pixmaps_width = a_width
			height_set: pixmaps_height = a_height
		end

feature {EV_ANY_I, EV_LIST} -- Implementation

	implementation: EV_LIST_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_LIST_IMP} implementation.make (Current)
		end

invariant
	selected_items_not_void: is_usable implies selected_items /= Void
	selected_items_first_is_selected_item:
		is_usable and not selected_items.is_empty implies
		selected_items.first = selected_item
	selected_items_empty_xor_selected_item_not_void: is_usable implies
		selected_items.is_empty xor selected_item /= Void
	single_selection_implies_at_most_one_selected_item:
		is_usable and not multiple_selection_enabled implies
		selected_items.count <= 1
	selection_size_within_bounds: is_usable implies
		selected_items.count <= count

end -- class EV_LIST

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------
