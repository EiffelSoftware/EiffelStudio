--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision menu container. A common type for%
		% all the menu-container : ev_static_menu_bar,%
		% ev_popup_menu, ev_option_button, ev_menu_bar.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MENU_HOLDER

inherit
	EV_ANY
		undefine
			create_action_sequences
		redefine
			implementation
		end

feature -- Implementation

	implementation: EV_MENU_HOLDER_I

end -- class EV_MENU_HOLDER

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.3  2000/01/28 22:24:22  oconnor
--| released
--|
--| Revision 1.5.6.2  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/23 23:01:37  oconnor
--| undefine create_action_sequences on repeated inherit
--|
--| Revision 1.5.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
