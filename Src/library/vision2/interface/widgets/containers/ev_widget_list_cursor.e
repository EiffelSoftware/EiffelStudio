indexing
	description:
		"Cursors for widget lists.";

	status: "See notice at end of class";
	keywords: "container, widget list, cursor"
	date: "$Date$";
	revision: "$Revision$"

class
	 EV_WIDGET_LIST_CURSOR

--| FIXME Does this need to be done differntly for GTK+ and WEL?
--| If so it should be bridged.

inherit
	CURSOR

creation
	make

feature {EV_WIDGET_LIST} -- Initialization

	make (current_index: INTEGER) is
			-- Create a cursor and set it up on `current_index'.
		do
			index := current_index
		end;

feature {EV_WIDGET_LIST, EV_WIDGET_LIST_I, EV_ITEM_LIST, EV_ITEM_LIST_I} -- Access

	index: INTEGER;
		-- Index of current item

end -- class ARRAYED_LIST_CURSOR

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
--| Revision 1.2  2000/02/14 12:05:14  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.4  2000/01/28 22:24:24  oconnor
--| released
--|
--| Revision 1.1.4.3  2000/01/27 19:30:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.2  1999/11/30 22:17:24  oconnor
--| export cursor features to allow use from EV_ITEM_LIST
--|
--| Revision 1.1.4.1  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.2.2  1999/11/17 02:00:56  oconnor
--| made index accessable to EV_WIDGET_LIST_I
--|
--| Revision 1.1.2.1  1999/11/05 19:53:05  oconnor
--| initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
