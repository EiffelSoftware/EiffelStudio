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

feature {NONE} -- Initialization

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PASSWORD_FIELD_IMP} implementation.make (Current)
		end

feature {NONE} -- Implementation

	implementation: EV_PASSWORD_FIELD_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_PASSWORD_FIELD

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/04/07 01:11:28  brendel
--| Revised.
--|
--| Revision 1.7  2000/02/29 18:09:10  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.6  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.2  2000/01/27 19:30:56  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:30:55  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.4.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
