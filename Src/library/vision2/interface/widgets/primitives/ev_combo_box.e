indexing 
	description:
		"[
			A text field with a button. When the button is pressed, a list of
			text strings is displayed. Selecting one causes it to be copied into
			the text field.
		]"
	appearance:
		"[
			+-----------+-+
			|  text     |V|
			+-----------+-+
			 | first      |
			 | ...        |
			 | last       |
			 +------------+
		]"
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

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
			combo_box_is_editable: is_editable
		do
			set_editable_text (a_text)
		ensure
			text_set: check_text_modification ("", a_text)
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TEXT_FIELD} and Precursor {EV_LIST_ITEM_LIST}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_COMBO_BOX_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_COMBO_BOX_IMP} implementation.make (Current)
		end

end -- class EV_COMBO_BOX

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

