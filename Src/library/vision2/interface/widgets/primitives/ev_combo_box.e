indexing 
	description:
		"A text field with a button. When the button is pressed, a list of%
		%text strings is displayed. Selecting one causes it to be copied into%
		%the text field."
	appearance:
		"+-----------+-+%N%
		%| `text'    |V|%N%
		%+-----------+-+%N%
		% |`first'     |%N%
		% | ...        |%N%
		% |`last'      |%N%
		% +------------+"
	status: "See notice at end of class"
	keywords: "combo, box, button, option, menu"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_COMBO_BOX

inherit
	EV_TEXT_FIELD
		rename
			set_text as set_editable_text
		export
			{NONE} set_editable_text
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state,
			create_implementation
		end

	EV_LIST_ITEM_LIST
		redefine
			implementation,
			is_in_default_state,
			create_implementation
		end

create	
	default_create,
	make_with_strings,
	make_with_text

feature -- Access

	pixmaps_width: INTEGER is
			-- Width of pixmaps displayed in list.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_width
		ensure
			bridge_ok: Result = implementation.pixmaps_width
		end

	pixmaps_height: INTEGER is
			-- Height of pixmaps dispalyed in list.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_height
		ensure
			bridge_ok: Result = implementation.pixmaps_height
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
			a_text_not_empty: not a_text.is_empty
			combo_box_is_editable: is_editable
		do
			set_editable_text (a_text)
		ensure
			text_set: check_text_modification (Void, a_text)
		end

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of pixmaps displayed in `Current'.
			-- Note: The Default value is 16x16
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
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TEXT_FIELD} and Precursor {EV_LIST_ITEM_LIST}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_COMBO_BOX_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_COMBO_BOX_IMP} implementation.make (Current)
		end

end -- class EV_COMBO_BOX

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
