--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: 
		"EiffelVision radio menu item. Item that must be put in%
		% an EV_MENU_ITEM_HOLDER. It has the same appearance%
		% than the check menu-item, yet, when a radio menu-item%
		% is checked, all the other radio menu-item of the%
		% container are unchecked."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_RADIO_MENU_ITEM

inherit
	EV_CHECK_MENU_ITEM
		redefine
			make,
			make_with_text,
			implementation
		end
	
create
	make,
	make_with_text,
	make_peer_with_text
	
feature {NONE} -- Initialization

	make (par: like parent) is
			-- Create the widget with `par' as parent.
		do
			!EV_RADIO_MENU_ITEM_IMP! implementation.make
			implementation.set_interface (Current)
			set_parent (par)
		end

	make_with_text (par: like parent; txt: STRING) is
			-- Create an item with `par' as parent and `txt'
			-- as text.
		do
			!EV_RADIO_MENU_ITEM_IMP!implementation.make
			implementation.set_interface (Current)
			implementation.set_text (txt)
			set_parent (par)
		end

	make_peer_with_text (par: like parent; txt: STRING; peer: EV_RADIO_MENU_ITEM) is
			-- Create a radio menu item and put it in
			-- the same group as peer
		do
			make_with_text (par, txt)
			set_peer (peer)
			set_selected (False)
		end

feature -- Status Setting

	set_peer (peer: like Current) is
			-- Put in same group as peer
		require
		do
			implementation.set_peer (peer)
		ensure
			same_group: implementation.is_peer (peer)
		end

feature -- Implementation

	implementation: EV_RADIO_MENU_ITEM_I
			-- Platform dependent access.

end -- class EV_RADIO_MENU_ITEM

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
--| Revision 1.10  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.2  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.3  1999/11/04 23:10:51  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.9.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
