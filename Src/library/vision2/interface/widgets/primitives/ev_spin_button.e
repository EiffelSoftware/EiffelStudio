indexing
	description:
		"[
			Displays `value' and two buttons that allow it to be adjusted up and
			down within `range'.
		]"
	status: "See notice at end of class"
	keywords: "gauge, edit, text, number, up, down"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON

inherit
	EV_GAUGE
		redefine
			create_implementation,
			implementation,
			is_in_default_state
		end

	EV_TEXT_FIELD
		rename
			change_actions as text_change_actions
		redefine
			create_implementation,
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_value_range,
	make_with_text
	
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := Precursor {EV_GAUGE} and then
				text.is_equal ("0")
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_SPIN_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_SPIN_BUTTON_IMP} implementation.make (Current)
		end

end -- class EV_SPIN_BUTTON

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

