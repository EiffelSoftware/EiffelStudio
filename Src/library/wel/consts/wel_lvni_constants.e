indexing
	description	: "List view next item (LVNI) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	note		: "Used to find items in a list view with the given%
				  % properties."

class
	WEL_LVNI_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Geometric relation of the requested item to the 
		-- specified item.

	Lvni_above: INTEGER is 256
			-- Searches for an item that is above the specified item.
			--
			-- Declared in Windows as LVNI_ABOVE

	Lvni_all: INTEGER is 0
			-- Searches for a subsequent item by index.
			--
			-- Declared in Windows as LVNI_ALL

	Lvni_below: INTEGER is 512
			-- Searches for an item that is below the specified item.
			--
			-- Declared in Windows as LVNI_BELOW

	Lvni_toleft: INTEGER is 1024
			-- Searches for an item to the left of the specified item.
			--
			-- Declared in Windows as LVNI_TOLEFT

	Lvni_toright: INTEGER is 2048
			-- Searches for an item to the right of the specified item.
			--
			-- Declared in Windows as LVNI_TORIGHT

feature -- State of the item

	Lvni_cut: INTEGER is 4
			-- The item has the LVIS_CUT state flag set.
			--
			-- Declared in Windows as LVNI_CUT

	Lvni_drophilited: INTEGER is 8
			-- The item has the LVIS_DROPHILITED state flag set.
			--
			-- Declared in Windows as LVNI_DROPHILITED

	Lvni_focused: INTEGER is 1
			-- The item has the LVIS_FOCUSED state flag set.
			--
			-- Declared in Windows as LVNI_FOCUSED

	Lvni_selected: INTEGER is 2
			-- The item has the LVIS_SELECTED state flag set.
			--
			-- Declared in Windows as LVNI_SELECTED

end -- class WEL_LVNI_CONSTANTS

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

