indexing
	description:
		"[
			Toggle button with state displayed as a circular check box.
			`is_selected' is mutually exclusive with respect to other
			radio buttons in `parent' container.
		]"
	appearance:
		"[
			--------------
			| (*)  text  |
			--------------
		]"
	status: "See notice at end of class"
	keywords: "toggle, radio, button"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_BUTTON

inherit
	EV_BUTTON
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

	EV_RADIO_PEER
		redefine
			implementation,
			is_in_default_state
		end

	EV_SELECTABLE
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_text,
	make_with_text_and_action

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- Radio buttons are selected by default.
		do
			Result := Precursor {EV_RADIO_PEER}
				and then Precursor {EV_BUTTON} and is_left_aligned
		end


feature {EV_ANY_I} -- Implementation

	implementation: EV_RADIO_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_RADIO_BUTTON_IMP} implementation.make (Current)
		end
	
end -- class EV_RADIO_BUTTON

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

