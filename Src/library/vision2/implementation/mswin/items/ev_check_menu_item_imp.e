indexing	
	description: 
		"EiffelVision check menu item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		undefine
			parent
		redefine
			interface
		end

	EV_SELECT_MENU_ITEM_IMP
		redefine
			on_activate,
			interface
		end
	
create
	make

feature -- Status setting

	disable_select is
		do
			parent_imp.uncheck_item (id)
		end

	toggle is
			-- Change the checked state of the menu-item.
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		end

feature {NONE} -- Implementation

	on_activate is
		do
			toggle
			Precursor
		end

	interface: EV_CHECK_MENU_ITEM

end -- class EV_CHECK_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--| Revision 1.15  2000/02/24 20:35:38  brendel
--| Changed to comply with interface.
--|
--| Revision 1.14  2000/02/24 01:42:02  brendel
--| Undefined parent from ImpInt.
--|
--| Revision 1.13  2000/02/23 02:13:26  brendel
--| Revised. Implemented.
--|
--| Revision 1.12  2000/02/19 06:20:41  oconnor
--| removed command stuff
--|
--| Revision 1.11  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.10  2000/02/19 04:35:44  oconnor
--| added deferred features
--|
--| Revision 1.9  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.2  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
