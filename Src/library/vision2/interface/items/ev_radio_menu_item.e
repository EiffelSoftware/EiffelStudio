indexing	
	description:
		"Menu item with state displayed as a circular check box.%N%
		%`is_selected' is mutually exclusive with respect to other radio menu%
		%items between separators in a menu."
	status: "See notice at end of class"
	keywords: "radio, item, menu, check, select, unselect"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_RADIO_MENU_ITEM

inherit
	EV_MENU_ITEM
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

	EV_RADIO_PEER
		redefine
			implementation,
			is_in_default_state
		end

	EV_SELECTABLE
		redefine
			implementation,
			is_in_default_state
		end
	
create
	default_create,
	make_with_text

feature {NONE} -- Implementation

	implementation: EV_RADIO_MENU_ITEM_I
		-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Initialization

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_RADIO_MENU_ITEM_IMP} implementation.make (Current)
		end

feature -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- Radio buttons are selected by default.
		do
			Result := {EV_MENU_ITEM} Precursor
				and then {EV_RADIO_PEER} Precursor
		end

end -- class EV_RADIO_MENU_ITEM

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
--| Revision 1.19  2000/06/07 17:28:05  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.9.4.2  2000/05/09 21:46:47  king
--| Intergrated selectable/deselectable
--|
--| Revision 1.9.4.1  2000/05/03 19:09:58  oconnor
--| mergred from HEAD
--|
--| Revision 1.18  2000/05/01 21:34:40  king
--| Corrected spelling mistake in indexing clause
--|
--| Revision 1.17  2000/03/24 03:10:22  oconnor
--| formatting and comments
--|
--| Revision 1.16  2000/02/29 18:09:07  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.15  2000/02/24 20:31:34  brendel
--| Now does not inherit EV_CHECK_MENU_ITEM anymore, but EV_SELECT_MENU_ITEM
--| and EV_RADIO_PEER.
--|
--| Revision 1.14  2000/02/24 16:49:55  brendel
--| Made `toggle' inapplicable to radio items.
--|
--| Revision 1.13  2000/02/24 01:32:17  brendel
--| Added feature `peers' which lets the user look in the list of radio-items
--| associated with the current item.
--| Redefined `disable_select', because it is not applicable to radio items.
--|
--| Revision 1.12  2000/02/22 19:54:44  brendel
--| Reworked interface.
--| Basically removed everything since radiobuttons are now automatically
--| grouped in menu's separated by separators.
--|
--| Revision 1.11  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
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
