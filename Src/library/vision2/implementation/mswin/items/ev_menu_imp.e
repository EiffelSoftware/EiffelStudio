--| FIXME Not for release
indexing
	description: "EiffelVision menu. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_IMP
	
inherit
	EV_MENU_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		undefine
			destroy
		redefine
			interface,
			make,
			initialize
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
		do
			Precursor (an_interface)
			wel_make
			make_id
		end

	initialize is
		do
			{EV_MENU_ITEM_IMP} Precursor
			{EV_MENU_ITEM_LIST_IMP} Precursor
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU	

end -- class EV_MENU_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.14  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.10.6  2000/02/05 02:26:29  brendel
--| Revised.
--| Implemented using EV_MENU_ITEM and EV_MENU_ITEM_LIST.
--|
--| Revision 1.13.10.5  2000/02/04 01:05:41  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.13.10.4  2000/02/03 17:16:59  brendel
--| Commented out old vision related implementation. Needs implementing.
--|
--| Revision 1.13.10.3  2000/01/27 19:30:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.10.2  1999/12/17 00:21:00  rogers
--| Altered to fit in with the review branch. Make now takes an interface.
--|
--| Revision 1.13.10.1  1999/11/24 17:30:36  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
