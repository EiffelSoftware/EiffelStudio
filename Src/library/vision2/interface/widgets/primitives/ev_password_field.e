indexing 
	description:
		"Input field for a single line of `text', displayed%N%
		%as a sequence of `*'."
	appearance:
		"+-------------+%N%
		%| ********    |%N%
		%+-------------+"
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

feature {EV_ANY_I} -- Implementation

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

