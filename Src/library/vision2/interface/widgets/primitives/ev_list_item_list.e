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
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_ITEM_LIST [EV_LIST_ITEM]
		redefine
			implementation,
			is_in_default_state
		end

	EV_LIST_ITEM_LIST_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make_with_strings (a_string_array: INDEXABLE [STRING, INTEGER]) is
			-- Create with an item for each of `a_string_array'.
		do
			default_create
			set_strings (a_string_array)
		ensure
			items_created: count = strings.count
		end

feature -- Access

	selected_item: EV_LIST_ITEM is
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

	strings: LINKED_LIST [STRING] is
			-- Representation of `Current'.
		require
			not_destroyed: not is_destroyed
		local
			c: CURSOR
		do
			create Result.make
			c := cursor
			from start until after loop
				Result.extend (clone (item.text))
				forth
			end
			go_to (c)
		ensure
			not_void: Result /= Void
			same_size: Result.count = count
		end

feature -- Status setting

	remove_selection is
			-- Ensure there is no `selected_item'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.clear_selection
		ensure
			not_selected: selected_item = Void
		end

	set_strings (a_string_array: INDEXABLE [STRING, INTEGER]) is
			-- Wipe out and re-initialize with an item
			-- for each of `a_string_array'.
		require
			not_destroyed: not is_destroyed
		local
			sc: like a_string_array
			i, upper: INTEGER
			li: EV_LIST_ITEM
		do
			wipe_out
			sc := a_string_array
			upper := sc.index_set.upper
			from i := sc.index_set.lower until i > upper loop
				create li.make_with_text (sc.item (i))
				extend (li)
				i := i + 1
			end
		ensure
			items_created: count = strings.count
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_ITEM_LIST}
		end

feature {EV_ANY_I, EV_LIST_ITEM_LIST} -- Implementation

	implementation: EV_LIST_ITEM_LIST_I
			-- Responsible for interaction with native graphics toolkit.

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
