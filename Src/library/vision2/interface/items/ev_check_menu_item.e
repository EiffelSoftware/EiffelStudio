indexing	
	description: "Eiffel Vision check menu item."
	status: "See notice at end of class"
	keywords: "menu, item, dropdown, popup, check, select"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECK_MENU_ITEM

inherit
	EV_MENU_ITEM
		redefine
			implementation
		end
	
create
	default_create,
	make_with_text
	
feature -- Status report

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		do
			Result := implementation.is_selected
		ensure
			bridge_ok: Result = implementation.is_selected
		end

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
			implementation.enable_select
		ensure
			is_selected: is_selected
		end

	disable_select is
			-- Deselect this menu item.
		do
			implementation.disable_select
		ensure
			not_is_selected: not is_selected
		end

	toggle is
			-- Invert the value of `is_selected'.
		do
			implementation.toggle
		ensure
			inverted: is_selected = not old is_selected
		end

feature {NONE} -- Implementation

	implementation: EV_CHECK_MENU_ITEM_I
			-- Platform dependent access.

end -- class EV_CHECK_MENU_ITEM

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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
