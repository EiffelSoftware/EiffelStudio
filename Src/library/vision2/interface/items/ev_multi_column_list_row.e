indexing
	description:
		"[
			Row item for use in EV_MULTI_COLUMN_LIST
		]"
	status: "See notice at end of class"
	keywords: "multi column list, row, item, select"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW

inherit
	EV_ITEM
		undefine
			copy, is_equal
		redefine
			implementation,
			is_in_default_state
		select
			default_create
		end

	INTERACTIVE_LIST [STRING]
		rename
			default_create as interactive_list_make
		redefine
			on_item_added_at,
			on_item_removed_at
		end

	EV_DESELECTABLE
		undefine
			initialize, copy, is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES
		undefine
			copy, is_equal
		redefine
			implementation
		end

create
	default_create

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and Precursor {EV_DESELECTABLE}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ROW_I
			-- Responsible for interaction with native graphics toolkit.

feature {EV_ANY_I} -- Implementation

	create_implementation is 
			-- See `{EV_ANY}.create_implementation'.
		do
			interactive_list_make
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make (Current)
		end
		
	on_item_added_at (an_item: STRING; item_index: INTEGER) is
			-- `an_item' is about to be added.
		do
			implementation.on_item_added_at (an_item, item_index)
		end

	on_item_removed_at (an_item: STRING; item_index: INTEGER) is
			-- `an_item' is about to be removed.
		do
			implementation.on_item_removed_at (an_item, item_index)
		end

end -- class EV_MULTI_COLUMN_LIST_ROW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

