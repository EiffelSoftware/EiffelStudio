indexing	
	description:
		"Menu item with a check box."
	status: "See notice at end of class"
	keywords: "menu, item, check, select, deselect, uncheck"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECK_MENU_ITEM

inherit
	EV_MENU_ITEM
		redefine
			implementation,
			create_implementation
		end

	EV_DESELECTABLE
		redefine
			implementation
		end
	
create
	default_create,
	make_with_text

feature -- Status setting

	toggle is
			-- Change `is_selected'.
		do
			implementation.toggle
		ensure
			changed: is_selected = not old is_selected
		end

feature {NONE} -- Implementation

	implementation: EV_CHECK_MENU_ITEM_I
			-- Responsible for interaction with the native graphics toolkit.

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_CHECK_MENU_ITEM_IMP} implementation.make (Current)
		end


end -- class EV_CHECK_MENU_ITEM

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
--| Revision 1.18  2000/06/07 17:28:04  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.11.4.2  2000/05/09 21:46:47  king
--| Intergrated selectable/deselectable
--|
--| Revision 1.11.4.1  2000/05/03 19:09:57  oconnor
--| mergred from HEAD
--|
--| Revision 1.17  2000/03/22 23:49:53  oconnor
--| comments
--|
--| Revision 1.16  2000/02/29 18:09:07  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.15  2000/02/24 20:30:27  brendel
--| Removed features `is_selected' and `enable_select', since they are now
--| defined in EV_SELECT_MENU_ITEM.
--|
--| Revision 1.14  2000/02/22 18:39:47  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.13  2000/02/18 19:06:50  brendel
--| Fixed bug where before the implementation was of type EV_MENU_ITEM_IMP.
--|
--| Revision 1.12  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.11.6.6  2000/02/05 01:41:35  brendel
--| Inherits from EV_MENU_ITEM instead of EV_MENU.
--| `toggle' is now implemented in _IMP.
--|
--| Revision 1.11.6.5  2000/02/04 07:47:04  oconnor
--| fixed broken comment
--|
--| Revision 1.11.6.4  2000/02/03 23:32:00  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.11.6.3  2000/01/28 22:24:20  oconnor
--| released
--|
--| Revision 1.11.6.2  2000/01/27 19:30:35  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.6.1  1999/11/24 17:30:41  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.11.2.3  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.11.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
