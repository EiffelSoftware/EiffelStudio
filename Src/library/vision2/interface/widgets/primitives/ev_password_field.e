indexing 
	description:
		"[
			Input field for a single line of `text', displayed
			as a sequence of `*'.
		]"
	appearance:
		"[
			+-------------+
			| ********    |
			+-------------+
		]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PASSWORD_FIELD

inherit
	EV_TEXT_FIELD
		redefine
			create_implementation,
			implementation
		end

create
	default_create,
	make_with_text

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PASSWORD_FIELD_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Initialization

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PASSWORD_FIELD_IMP} implementation.make (Current)
		end

end -- class EV_PASSWORD_FIELD

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

