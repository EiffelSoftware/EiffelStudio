indexing	
	description: "Eiffel Vision radio menu item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			interface,
			on_activate,
			initialize
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize with state `is_selected'.
		do
			Precursor
			is_selected := True
		end

feature {EV_ANY_I} -- Status report

	is_selected: BOOLEAN

feature {EV_ANY_I} -- Status setting

	disable_select is
			-- Assign `False' to `is_selected'.
		do
			is_selected := False
		end
	
	enable_select is
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					parent_imp.uncheck_item (radio_group.item.id)
					radio_group.item.disable_select
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			is_selected := True
			if has_parent then
				parent_imp.check_item (id)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_MENU_ITEM

feature {NONE} -- Implementation

	on_activate is
			-- Enable this item and call `Precursor'.
		do
			enable_select
			Precursor
		end

end -- class EV_RADIO_MENU_ITEM_IMP

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
--| Revision 1.20  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.10.4.4  2000/08/17 17:26:12  rogers
--| Added disable_select. Enable_Select now calls disable_Select on the
--| previously selected item. Features are now exported to EV_ANY_I.
--|
--| Revision 1.10.4.3  2000/08/11 23:55:55  rogers
--| Corrected copyright clause so it now references EiffelVision2.
--|
--| Revision 1.10.4.2  2000/05/09 21:51:33  king
--| Implemented to new selectable abstract class
--|
--| Revision 1.10.4.1  2000/05/03 19:09:10  oconnor
--| mergred from HEAD
--|
--| Revision 1.18  2000/02/25 20:29:59  brendel
--| Does not need to redefine is_selected anymore, due to fix of
--| EV_SELECT_MENU_ITEM_IMP.
--|
--| Revision 1.17  2000/02/25 02:19:26  brendel
--| Removed implementation of features that are now inherited from
--| EV_RADIO_PEER_IMP.
--|
--| Revision 1.16  2000/02/24 20:36:47  brendel
--| Changed to comply with new inheritance structure. Invariants have been
--| moved from this file to EV_RADIO_PEER.
--|
--| Revision 1.15  2000/02/24 16:50:58  brendel
--| Made `toggle' inapplicable.
--| Added redefine of `on_activate', since toggle cannot be called anymore.
--|
--| Revision 1.14  2000/02/24 01:45:59  brendel
--| Improved contracts.
--| Fully implemented.
--|
--| Revision 1.13  2000/02/23 02:16:35  brendel
--| Revised. Implemented.
--|
--| Revision 1.12  2000/02/22 20:14:46  brendel
--| Commented out old implementation.
--|
--| Revision 1.11  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.2  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
