indexing
	description: "List view next item (LVNI) constants."
	note: "Used to find items in a list view with the given%
		% properties."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVNI_CONSTANTS

feature -- Geometric relation of the requested item to the 
		-- specified item.

	Lvni_above: INTEGER is
			-- Searches for an item that is above the specified item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVNI_ABOVE"
		end

	Lvni_all: INTEGER is
			-- Searches for a subsequent item by index.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVNI_ALL"
		end

	Lvni_below: INTEGER is
			-- Searches for an item that is below the specified item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVNI_BELOW"
		end

	Lvni_toleft: INTEGER is
			-- Searches for an item to the left of the specified item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVNI_TOLEFT"
		end

	Lvni_toright: INTEGER is
			-- Searches for an item to the right of the specified item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVNI_TORIGHT"
		end

feature -- State of the item

	Lvni_cut: INTEGER is
			-- The item has the LVIS_CUT state flag set.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVNI_CUT"
		end
	
	Lvni_drophilited: INTEGER is
			-- The item has the LVIS_DROPHILITED state flag set.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVNI_DROPHILITED"
		end

	Lvni_focused: INTEGER is
			-- The item has the LVIS_FOCUSED state flag set.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVNI_FOCUSED"
		end

	Lvni_selected: INTEGER is
			-- The item has the LVIS_SELECTED state flag set.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVNI_SELECTED"
		end

end -- class WEL_LVNI_CONSTANTS

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

