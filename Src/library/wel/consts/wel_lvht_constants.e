indexing
	description	: "List View HitTest info (LVHT) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVHT_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Access

	Lvht_above: INTEGER is 8
			-- Above the client area.
			--
			-- Declared in Windows as LVHT_ABOVE

	Lvht_below: INTEGER is 16
			-- Below the client area.
			--
			-- Declared in Windows as LVHT_BELOW

	Lvht_nowhere: INTEGER is 1
			-- In the client area, but below the last item.
			--
			-- Declared in Windows as LVHT_NOWHERE

	Lvht_onitemicon: INTEGER is 2
			-- On the button associated with an item.
			--
			-- Declared in Windows as LVHT_ONITEMICON

	Lvht_onitemlabel: INTEGER is 4
			-- On the label (string) associated with an item.
			--
			-- Declared in Windows as LVHT_ONITEMLABEL

	Lvht_onitemstateicon: INTEGER is 8
			-- On the state icon for a tree view item that is in
			-- a user-defines state.
			--
			-- Declared in Windows as LVHT_ONITEMSTATEICON

	Lvht_toleft: INTEGER is 64
			-- To the left of the client area.
			--
			-- Declared in Windows as LVHT_TOLEFT

	Lvht_toright: INTEGER is 32
			-- To the right of the client area.
			--
			-- Declared in Windows as LVHT_TORIGHT

end -- class WEL_LVHT_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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

