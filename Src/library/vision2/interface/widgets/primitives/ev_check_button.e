indexing
	description:
		"Toggle button with state displayed as a check box."
	appearance:
		" [X] `text' "
	status: "See notice at end of class"
	keywords: "toggle, check, tick, button, box"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_CHECK_BUTTON

inherit
	EV_TOGGLE_BUTTON
		redefine 
			implementation,
			create_implementation
		end

create
	default_create,
	make_with_text,
	make_for_test

feature {NONE} -- Implementation

	implementation: EV_CHECK_BUTTON_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			Create {EV_CHECK_BUTTON_IMP} implementation.make (Current)
		end
	
end -- class EV_CHECK_BUTTON

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
--| Revision 1.14  2000/03/21 01:53:00  oconnor
--| comments and formatting
--|
--| Revision 1.13  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.12  2000/02/25 21:28:16  brendel
--| Formatting.
--|
--| Revision 1.11  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.5  2000/01/28 20:00:19  oconnor
--| released
--|
--| Revision 1.9.6.4  2000/01/27 19:30:54  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.3  2000/01/19 08:16:07  oconnor
--| formatting and comments
--|
--| Revision 1.9.6.2  1999/12/23 01:39:34  king
--| Implemented to fit in with new structure
--|
--| Revision 1.9.6.1  1999/11/24 17:30:53  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
