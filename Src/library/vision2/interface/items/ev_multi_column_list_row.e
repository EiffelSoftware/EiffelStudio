indexing
	description:
		"Row item for use in EV_MULTI_COLUMN_LIST"
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
		end

	EV_PICK_AND_DROPABLE
		undefine
			copy, is_equal
		redefine
			implementation,
			is_in_default_state
		end

	INTERACTIVE_LIST [STRING]
		rename
			default_create as interactive_list_make
		redefine
			on_item_added,
			on_item_removed
		end

	EV_PIXMAPABLE
		undefine
			initialize, copy, is_equal
		redefine
			implementation,
			is_in_default_state
		select
			default_create
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
			Result := Precursor {EV_ITEM} and Precursor {EV_PICK_AND_DROPABLE} and
				Precursor {EV_PIXMAPABLE} and Precursor {EV_DESELECTABLE}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ROW_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is 
			-- See `{EV_ANY}.create_implementation'.
		do
			interactive_list_make
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make (Current)
		end
		
	on_item_added (an_item: STRING) is
			-- `an_item' is about to be added.
		do
			implementation.update
		end

	on_item_removed (an_item: STRING) is
			-- `an_item' is about to be removed.
		do
			implementation.update
		end

end -- class EV_MULTI_COLUMN_LIST_ROW

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
